/**
 * @file tolowergb.c
 * @date 2018/07/31 13:37:03
 * @brief convert to lower case, for text in gb-xxx encoding
 *  
 **/

#include <stdio.h>
#include <assert.h>

static const char uppermask[] = {
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
	'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 0, 0, 0, 0, 0,
	//0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
};

int main(int argc, char **argv, char **env)
{
	enum { BUFSIZE = 512 };	// Strangely const size_t is slower than enum or define
	unsigned char buf[BUFSIZE];
	size_t read = 0;
	size_t left = 0;
	while (read = fread(buf + left, 1, BUFSIZE - left, stdin))
	{
		read += left;
		left = 0;
		size_t cur = 0;
		for (cur = 0; cur < read; ++cur)
		{
			if (buf[cur] > 127)
			{
				if (cur + 1 < read)
					++cur;	// the second byte of gb char may be in range [A-Z], skip it
				else
					break;
			}
			// Although isupper in ctype is likely to be a macro, it may involves locale function
			// calls and thus be considerably slower than range comparison or mask
			//else if (isupper(buf[cur]))
			//else if (buf[cur] >= 'A' && buf[cur] <= 'Z')
			else if (uppermask[buf[cur]]) 
				buf[cur] += 'a' - 'A';	// Strangely this is slower: buf[cur] = uppermask[buf[cur]]
		}
		if (cur != fwrite(buf, 1, cur, stdout))
		{
			fputs("Write output failed.\n", stderr);
			return 1;
		}
		if (cur < read)
		{
			assert(cur + 1 == read);
			buf[0] = buf[cur];
			left = 1;
		}
	}
	if (left)
		return left != fwrite((char *)buf, 1, left, stdout);
	return 0;
}

/* vim: set ts=4 sw=4 sts=4 tw=100: */
