using Dates

function pushDown(h, pos, n)
    while 2 * pos <= n
        j = 2 * pos
        if j + 1 <= n && h[j+1] > h[j]
            j += 1
        end
        h[pos] >= h[j] && break
        h[pos], h[j] = h[j], h[pos]
        pos = j
    end
end

function main()
    start = now()
    N = 10000000
    h = collect(0:N-1)
    for i in div(N, 2)+1:-1:1
        pushDown(h, i, N)
    end
    
    n = N
    while n > 1
        h[1], h[n] = h[n], h[1]
        n -= 1
        pushDown(h, 1, n)
    end
    
    for i in 1:N
        @assert h[i] == i-1
    end

    println("Done in ", Dates.value(now() - start))
end

main()
