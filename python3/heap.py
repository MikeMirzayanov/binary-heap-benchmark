import time
 
def pushDown(h, pos, n):
    while 2 * pos + 1 < n:
        j = 2 * pos + 1
        if j + 1 < n and h[j+1] > h[j]:
            j += 1
        if h[pos] >= h[j]:
            break
        h[pos], h[j] = h[j], h[pos]
        pos = j
 
if __name__ == "__main__":
    start = time.clock()
    N = 10000000
    h = list(range(N))
    for i in range(N//2, -1, -1):
        pushDown(h, i, N)
    n = N
    while n > 1:
        n -= 1
        h[0], h[n] = h[n], h[0]
        pushDown(h, 0, n)
    for i in range(N):
        assert(h[i] == i)
    print("Done in %f" % ((time.clock() - start) * 1000))
