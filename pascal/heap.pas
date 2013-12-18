const MAXN = 10000000;

var h: array[0..MAXN - 1] of longInt;

procedure pushDown(pos, n: longInt);
var j, t: longInt;
begin
    while (2 * pos + 1 < n) do
    begin
        j := 2 * pos + 1;
        if (j + 1 < n) and (h[j + 1] > h[j]) then
            inc(j);

        if (h[pos] >= h[j]) then
            break;

        t := h[pos];
        h[pos] := h[j];
        h[j] := t;

        pos := j;
    end;
end;

var i, n, t: longInt;

begin
    for i := 0 to MAXN - 1 do
        h[i] := i;

    for i := (MAXN div 2) downTo 0 do
        pushDown(i, MAXN);

    n := MAXN;
    while (n > 1) do
    begin
        t := h[0];
        h[0] := h[n - 1];
        h[n - 1] := t;

        dec(n);
        pushDown(0, n);
    end;

    for i := 0 to MAXN - 1 do
        if (h[i] <> i) then
            writeln( 'fail: h[', i, '] != ', i );
end.
