use std::time::duration::Duration;

fn main() {
    let duration = Duration::span(|| {
        let n: i32 = 10000000;
        let mut h: Vec<i32> = (0..n).collect();

        make_heap(&mut *h);

        for i in (1..n as usize).rev() {
            h.swap(0, i);
            push_down(0, i, &mut *h);
        }

        for (elt, i) in h.iter().zip(0..n) {
            assert!(*elt == i);
        }
    });
    println!("Done in {}", duration.num_milliseconds());
}

fn make_heap(h: &mut [i32]) {
    for i in (0..h.len() / 2).rev() {
        push_down(i, h.len(), h);
    }
}

fn push_down(mut pos: usize, size: usize, h: &mut [i32]) {
    while 2 * pos + 1 < size {
        let mut vic = 2 * pos + 1;
        if vic + 1 < size && h[vic + 1] > h[vic] {
            vic += 1;
        }

        if h[pos] > h[vic] {
            break;
        }

        h.swap(pos, vic);
        pos = vic;
    }
}
