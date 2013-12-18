#include <iostream>
#include <cassert>
#include <ctime>

#define forn(i, n) for (int i = 0; i < int(n); i++)

using namespace std;

const int N = 10000000;

int h[N];

void pushDown(int pos, int n)
{
    while (2 * pos + 1 < n)
    {
        int j = 2 * pos + 1;
        if (j + 1 < n && h[j + 1] > h[j])
            j++;
        if (h[pos] >= h[j])
            break;
        swap(h[pos], h[j]);
        pos = j;
    }
}

int main()
{
    forn(i, N)
        h[i] = i;

    for (int i = N / 2; i >= 0; i--)
        pushDown(i, N);

    int n = N;
    while (n > 1)
    {
        swap(h[0], h[n - 1]);
        n--;
        pushDown(0, n);
    }

    forn(i, N)
        assert(h[i] == i);

    cout << "Done in " << clock() * 1000 / CLOCKS_PER_SEC << endl;
}
