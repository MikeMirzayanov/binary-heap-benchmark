<?php
 
define('N', 10000000);
 
$h = array_fill(0, N, 0);
 
function pushDown($pos, $n) {
    global $h;
    
    while (2 * $pos + 1 < $n) {
        $j = 2 * $pos + 1;
        if ($j + 1 < $n && $h[$j + 1] > $h[$j])
            $j++;
        if ($h[$pos] >= $h[$j])
            break;
        $t = $h[$pos];
        $h[$pos] = $h[$j];
        $h[$j] = $t;
        $pos = $j;
    }
}
 
function main() {
    global $h;
   
    $start = round(microtime(true) * 1000);
   
    for ($i = 0; $i < N; $i++) {
        $h[$i] = $i;
    }
   
    for ($i = (int) (N / 2); $i >= 0; $i--) {
        pushDown($i, N);
    }
   
    $n = N;
    while ($n > 1) {
        $n--;
        $t = $h[0];
        $h[0] = $h[$n];
        $h[$n] = $t;
        pushDown(0, $n);
    }
   
    foreach ($h as $i => $v) {
        if ($i !== $v) {
            echo "Sorting failed at index $i!\n";
            return;
        }
    }
   
    $finish = round(microtime(true) * 1000);
    $delta = $finish - $start;
   
    echo "Done in $delta\n";
}

main();
