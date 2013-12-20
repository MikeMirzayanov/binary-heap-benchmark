require 'benchmark'

def push_down(heap, pos, n)
  while (2 * pos + 1) < n
    j = 2 * pos + 1

    if (j + 1 < n) and (heap[j + 1] > heap[j])
      j += 1
    end

    break unless heap[pos] < heap[j]

    tmp = heap[pos]
    heap[pos] = heap[j]
    heap[j] = tmp

    pos = j
  end
end


def heapsort(size)
  heap = (0...size).to_a

  (size / 2).downto(0) do |i|
    push_down heap, i, size
  end

  (size - 1).downto(1) do |n|
    tmp = heap[0]
    heap[0] = heap[n]
    heap[n] = tmp

    push_down heap, 0, n
  end

  raise "Array not sorted" unless heap.each.with_index.all? { |element, index| element == index }
end

n = 10_000_000
puts Benchmark.measure { heapsort n }
