use std::mem;
use std::time::Instant;

const N: usize = 10000000;

#[allow(non_upper_case_globals)]
static mut h: [i32; N] = [0; N];

#[inline(always)]
unsafe fn push_down(mut pos: usize, n: usize) {
    while 2 * pos + 1 < n {
        let mut j = 2 * pos + 1;

        if j + 1 < n && h[j + 1] > h[j] {
            j += 1;
        }

        if h[pos] >= h[j] {
            break;
        }

        mem::swap(&mut h[pos], &mut h[j]);

        pos = j;
    }
}

fn main() {
    unsafe {
        let start = Instant::now();

        for i in 0..N {
            h[i] = i as i32;
        }

        for i in (0..N / 2 + 1).rev() {
            push_down(i, N);
        }

        for n in (1..N).rev() {
            mem::swap(&mut h[0], &mut h[n]);
            push_down(0, n);
        }

        for i in 0..N {
            assert_eq!(h[i], i as i32);
        }

        let elapsed = start.elapsed();
        println!("Done in {}", (elapsed.as_secs() * 1_000) + (elapsed.subsec_nanos() / 1_000_000) as u64);
    }
}
