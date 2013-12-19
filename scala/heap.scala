// Author: Wizmann
// Done in 1139(ms) on Intel(R) Core(TM) i5-3230M CPU @ 2.60GHz

import scala.annotation.tailrec

object Heap {
    val N = 10000000
    val h = (0 until N).toArray

    def main(args: Array[String]) {
        val st = System.nanoTime

        (0 to N/2).reverse.foreach(pushDown(_, N))
        (2 to N).reverse.foreach(i => {
            arraySwap(h, 0, i - 1);
            pushDown(0, i - 1)
        })
        (0 until N).foreach(x => assert(h(x) == x))

        val end = System.nanoTime
        println("Done in " + ((end - st)/1e6).toLong + "(ms)")
    }

    @tailrec
    def pushDown(pos: Int, n: Int) {
        val j = left(pos);
        if (j < n) {
            val next = if (j + 1 < n && h(j + 1) > h(j)) j + 1 else j

            if (h(pos) < h(next)) {
                arraySwap(h, pos, next)
                pushDown(next, n)
            }
        }
    }
    def arraySwap(ll: Array[Int], a: Int, b: Int) {
        val t = ll(a)
        ll(a) = ll(b)
        ll(b) = t
    }
    def left(x: Int): Int = 2 * x + 1
    def right(x: Int): Int = 2 * x + 2
}
