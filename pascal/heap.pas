uses dos;

const MAXN = 10000000;

var h: array[0..MAXN - 1] of longInt;

procedure swap(var x, y: longInt);
begin
    x := x xor y;
    y := x xor y;
    x := x xor y;
end;

procedure pushDown(pos, n: longInt);
var j: longInt;
begin
    while (2 * pos + 1 < n) do
    begin
        j := 2 * pos + 1;
        if (j + 1 < n) and (h[j + 1] > h[j]) then
          inc(j);

        if (h[pos] >= h[j]) then
            break;

        swap(h[pos], h[j]);
        pos := j;
    end;
end;

var i, n: longInt;
    start: int64;

begin
    start := getMsCount();

    for i := 0 to MAXN - 1 do
        h[i] := i;

    for i := (MAXN div 2) downTo 0 do
        pushDown(i, MAXN);

    n := MAXN;
    while (n > 1) do
    begin
        swap(h[0], h[n - 1]);
        dec(n);
        pushDown(0, n);
    end;

    for i := 0 to MAXN - 1 do
        if (h[i] <> i) then
            writeln( 'fail: h[', i, '] != ', i );

    writeln( 'Done in ', getMsCount() - start, ' ms' );
end.
