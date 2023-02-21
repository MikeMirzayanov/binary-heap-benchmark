const std = @import("std");

fn pushDown(p: usize, n: usize, h: []i32) void {
    var pos = p;

    while (2 * pos + 1 < n) {
        var j = 2 * pos + 1;

        if (j + 1 < n and h[j + 1] > h[j]) {
            j += 1;
        }

        if (h[pos] >= h[j]) {
            break;
        }

        const t = h[pos];
        h[pos] = h[j];
        h[j] = t;
        pos = j;
    }
}

pub fn main() !void {
    var timer = try std.time.Timer.start();
    const N: usize = 10000000;
    var general_purpose_allocator = std.heap.GeneralPurposeAllocator(.{}){};
    const gpa = general_purpose_allocator.allocator();
    var h: []i32 = try gpa.alloc(i32, N);
    var i: i32 = 0;

    while (i < N) : (i += 1) {
        const index: usize = @intCast(usize, i);
        h[index] = i;
    }

    i = N / 2;

    while (i > -1) : (i -= 1) {
        const index: usize = @intCast(usize, i);
        pushDown(index, N, h);
    }

    var n = N;

    while (n > 1) {
        const t = h[n - 1];
        h[n - 1] = h[0];
        h[0] = t;
        n -= 1;
        pushDown(0, n, h);
    }

    i = 0;

    while (i < N) : (i += 1) {
        const index: usize = @intCast(usize, i);

        if (h[index] != i) {
            unreachable;
        }
    }

    const elapsedNanoseconds = timer.read() / 1000000;
    std.debug.print("Done in {} ms\n", .{elapsedNanoseconds});
}
