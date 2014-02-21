var N = 10000000;

var h = new Uint32Array(N);

function pushDown(pos, n) {
    while (2 * pos + 1 < n) {
        var j = 2 * pos + 1;
        if (j + 1 < n && h[j + 1] > h[j])
            j++;
        if (h[pos] >= h[j])
            break;
        var t = h[pos];
        h[pos] = h[j];
        h[j] = t;
        pos = j;
    }
}

function main() {
    var start = Date.now();

    for (var i = 0; i < N; i++) {
        h[i] = i;
    }

    for (var i = N / 2; i >= 0; i--)
        pushDown(i, N);

    var n = N;
    
    while (n > 1) {
        var t = h[0];
        h[0] = h[n - 1];
        h[n - 1] = t;

        n--;
        pushDown(0, n);
    }

    for (var i = 0; i < N; i++) {
        if (h[i] != i) {
            throw new RuntimeException("h[i] != i");
        }
    }

    print("Done in " + (Date.now() - start));
}

main();
