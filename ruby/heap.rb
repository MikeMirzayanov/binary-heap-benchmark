N = 10000000.freeze
$h = Array.new

def pushDown(pos, n)
  while 2*pos + 1 < n
    j = 2*pos + 1
    if (j+1 < n) and ($h[j+1] > $h[j])
      j += 1
    end

    break unless $h[pos] < $h[j]

    $h[pos], $h[j] = $h[j], $h[pos]
    pos = j
  end
end

def main
  start = Time.now

  N.times do |i|
    $h << i
  end

  (N/2).downto(0) do |i|
    pushDown i, N
  end

  n = N
  while n > 1
    $h[0], $h[n-1] = $h[n-1], $h[0]
    n -= 1
    pushDown 0, n
  end

  N.times do |i|
    raise "h[i] != i" unless $h[i] == i
  end

  puts "Done in #{((Time.now - start) * 1000).to_i}"
end

begin
  main
end
