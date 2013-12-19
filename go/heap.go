package main

import (
  "fmt"
  "time"
)

const N int = 10000000

func pushDown(h *[N]int, pos, n int) {
  for 2*pos + 1 < n {
    j := 2 * pos + 1
    if j + 1 < n && h[j+1] > h[j] {
      j++
    }
    if h[pos] >= h[j] {
      break
    }

    h[pos], h[j] = h[j], h[pos]
    pos = j
  }
}

func main() {
  start := time.Now()

  var h [N]int
  for i := 0; i < N; i++ {
    h[i] = i
  }

  for i := N/2; i >= 0; i-- {
    pushDown(&h, i, N)
  }

  n := N
  for n > 1 {
    n--
    h[0], h[n] = h[n], h[0]
    pushDown(&h, 0, n)
  }

  for i := 0; i < N; i++ {
    if h[i] != i {
      panic("h[i] != i")
    }
  }

  end := time.Since(start)
  fmt.Println("Done in", end.Nanoseconds() / 1000000.0)
}
