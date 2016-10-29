use std::*;

const N : usize = 10000000;

static mut h : [i32; N] = [0; N];

fn push_down(mut pos : usize, n : usize)
{
    while 2 * pos + 1 < n
    {
        unsafe {
            let mut j = 2 * pos + 1;
            if j + 1 < n && h[j + 1] > h[j] {
                j = j + 1;
            }
            if h[pos] >= h[j] {
                break;
            }
            mem::swap(&mut h[pos], &mut h[j]);
            pos = j;
        }
    }
}

fn main() {
    let start = time::Instant::now();

    for i in 0..N {
        unsafe { h[i] = i as i32 };
    }

    for i in (0..(N/2 + 1)).rev() {
        push_down(i, N);
    }
    
    let mut n = N;
    while n > 1 {
        unsafe { mem::swap(&mut h[0], &mut h[n - 1]); }
        n = n - 1;
        push_down(0, n);
    }

    for i in 0..N {
        unsafe { assert!(h[i] == i as i32); }
    }

    let duration = start.elapsed();
    let ms_taken = duration.as_secs() * 1000
        + (duration.subsec_nanos() as u64) / 1000000;

    println!("Done in {}", ms_taken);
}
