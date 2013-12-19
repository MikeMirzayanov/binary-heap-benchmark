#!/usr/bin/env python2

import time

N = 10000000

h = [None] * N

def pushDown(pos, n):
    while 2*pos + 1 < n:
        j = 2*pos + 1
        if (j+1 < n) and (h[j+1] > h[j]):
            j += 1
        if h[pos] >= h[j]:
            break
        h[pos], h[j] = h[j], h[pos]
        pos = j

def main():
    start = time.time()

    for i in range(N):
        h[i] = i

    for i in range(N//2, -1, -1):
        pushDown(i, N)

    n = N
    while n > 1:
        h[0], h[n-1] = h[n-1], h[0]
        n -= 1
        pushDown(0, n)

    for i in range(N):
        if h[i] != i:
            raise Exception("h[i] != i")

    print("Done in %f" % ((time.time() - start) * 1000))

if __name__ == '__main__':
    main()
