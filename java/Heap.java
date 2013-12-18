/**
 * @author Mike Mirzayanov (mirzayanovmr@gmail.com)
 */
public class Heap {
    private static final int N = 10000000;
    private static final int[] h = new int[N];

    private static void pushDown(int pos, int n) {
        while (2 * pos + 1 < n) {
            int j = 2 * pos + 1;
            if (j + 1 < n && h[j + 1] > h[j])
                j++;
            if (h[pos] >= h[j])
                break;
            int t = h[pos];
            h[pos] = h[j];
            h[j] = t;
            pos = j;
        }
    }

    public static void main(String[] args) {
        long start = System.currentTimeMillis();

        for (int i = 0; i < N; i++) {
            h[i] = i;
        }

        for (int i = N / 2; i >= 0; i--)
            pushDown(i, N);

        int n = N;
        while (n > 1) {
            int t = h[0];
            h[0] = h[n - 1];
            h[n - 1] = t;
            n--;
            pushDown(0, n);
        }

        for (int i = 0; i < N; i++) {
            if (h[i] != i) {
                throw new RuntimeException("h[i] != i");
            }
        }

        System.out.println("Done in " + (System.currentTimeMillis() - start));
    }
}
