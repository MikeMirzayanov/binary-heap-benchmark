import Foundation;

let N: Int = 10000000
var h = [Int](repeating: 0, count: N)

func pushDown(_ pos_: Int, _ n: Int) -> Void {
	var pos: Int = pos_
    while 2 * pos + 1 < n {
        var j: Int = 2 * pos + 1
        if j + 1 < n && h[j + 1] > h[j] {
            j += 1
        }
        if h[pos] >= h[j] {
            break;
        }
        h.swapAt(pos, j)
        pos = j;
    }
}

func main() -> Void {
    let start = DispatchTime.now()

    for i in 0..<N {
    	h[i] = i
    }

    for i in stride(from: N / 2, to: -1, by: -1) {
        pushDown(i, N)
    }

    var n: Int = N
    while n > 1 {
        h.swapAt(0, n - 1)
        n -= 1
        pushDown(0, n)
    }

    for i in 0..<N {
    	assert(h[i] == i)
    }

    print("Done in \((DispatchTime.now().uptimeNanoseconds - start.uptimeNanoseconds) / 1_000_000)")
}

main()
