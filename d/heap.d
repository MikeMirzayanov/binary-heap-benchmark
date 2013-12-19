import std.algorithm;
import std.conv;
import std.datetime;
import std.exception;
import std.range;
import std.stdio;

immutable int N = 10_000_000;

__gshared int [] h;

void pushDown (int pos, int n)
{
	while (2 * pos + 1 < n)
	{
		int j = 2 * pos + 1;
		if (j + 1 < n && h[j + 1] > h[j])
		{
			j++;
		}
		if (h[pos] >= h[j])
		{
			break;
		}
		swap (h[pos], h[j]);
		pos = j;
	}
}

void main ()
{
	auto sw = StopWatch (AutoStart.yes);

	h = new int [N];
	foreach (i; 0..N)
	{
		h[i] = i;
	}

	for (int i = N / 2; i >= 0; i--)
	{
		pushDown (i, N);
	}

	int n = N;
	while (n > 1)
	{
		swap (h[0], h[n - 1]);
		n--;
		pushDown (0, n);
	}

	foreach (i; 0..N)
	{
		enforce (h[i] == i);
	}

	sw.stop ();

	writeln (sw.peek ().msecs);
}
