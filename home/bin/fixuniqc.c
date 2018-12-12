/**
 * @file fixuniqc.c
 * @date 2018/07/31 13:37:03
 * @brief reformat `uniq -c` output to be more machine-readable, e.g.: "42\tcontent1\n64\tcont2\n"
 *  
 **/

#include <stdio.h>
#include <string.h>
#include <assert.h>

int main(int argc, char **argv, char **env)
{
	enum { BUFSIZE = 512 };	// Strangely const size_t is slower than enum or define
	unsigned char buf[BUFSIZE];
	size_t read = 0;
	size_t left = 0;
	ssize_t sline = 0;
	size_t last = 0;
	while (read = fread(buf + left, 1, BUFSIZE - left, stdin))
	{
		read += left;
		left = 0;
		assert(sline == 0 || sline == -1);
		size_t cur = 0;
		while (cur < read)
		{
			if (sline >= 0)
			{
				for ( ; cur < read && buf[cur] == ' '; ++cur)	// leading ' ', skip
				{
					sline = cur + 1;
					last = cur + 1;
				}
				if (cur >= read)
					break;
				if (!(buf[cur] >= '0' && buf[cur] <= '9'))	// line not starts with digit char
				{
					sline = -1;
					continue;
				}
				for (; cur < read && buf[cur] >= '0' && buf[cur] <= '9'; ++cur)
					;
				if (cur >= read)
					break;
				if (buf[cur] != ' ')	// no space after count
				{
					sline = -1;
					continue;
				}
				if (cur - last != fwrite(buf + last, 1, cur - last, stdout) || EOF == fputc('\t', stdout))
				{
					fputs("Write output failed.\n", stderr);
					return 1;
				}
				last = cur + 1;
				sline = -1;
				++cur;
			}
			for (; cur < read; ++cur)
			{
				if (buf[cur] == '\n' || buf[cur] == '\r')
				{
					if (cur + 1 - last != fwrite(buf + last, 1, cur + 1 - last, stdout))
					{
						fputs("Write output failed.\n", stderr);
						return 1;
					}
					last = sline = cur + 1;
					++cur;
					break;
				}
			}
		}	// for (size_t cur = 0; cur < read; )
		// one iteration finished
		if (sline < 0)	// not in counts, just write out all content
		{
			if (cur - last != fwrite(buf + last, 1, cur - last, stdout))
			{
				fputs("Write output failed.\n", stderr);
				return 1;
			}
			last = left = 0;
		}
		else
		{
			if (sline == 0 && cur >= BUFSIZE)
			{
				fputs("Count number too large.\n", stderr);
				return 1;
			}
			assert(sline == last);
			memmove(buf, buf + sline, cur - sline);
			left = cur - sline;
			last = sline = 0;
		}
	}
	if (read > last)
		return read - last != fwrite(buf + last, 1, read - last, stdout);
	return 0;
}

/* vim: set ts=4 sw=4 sts=4 tw=100: */
