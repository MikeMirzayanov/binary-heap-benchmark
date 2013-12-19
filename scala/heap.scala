// Author: Wizmann

import scala.util.control.Breaks._

object Heap {
    val N = 10000000
    val h = (0 until N).toArray

    def main(args: Array[String]) {
        val st = System.nanoTime

        (0 to N/2).reverse.foreach(pushDown(_, N))
        (2 to N).reverse.foreach(i => {
            val t = h(0);
            h(0) = h(i - 1);
            h(i - 1) = t;
            pushDown(0, i - 1)
        })
        (0 until N).foreach(x => assert(h(x) == x))

        val end = System.nanoTime
        println("Done in " + ((end - st)/1e6).toLong)
    }

    def pushDown(pos: Int, n: Int) {
        var p = pos;
        breakable { 
            while (2 * p + 1 < n) {
                var j = 2 * p + 1;
                if (j + 1 < n && h(j + 1) > h(j))
                    j += 1;
                if (h(p) >= h(j))
                    break;
                val t = h(p);
                h(p) = h(j);
                h(j) = t;
                p = j;
            }
        }
    }
}
