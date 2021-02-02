defmodule Append do

  def append([h|t], []),  do: [h|t]
  def append(a, []),      do: [a]
  def append(a, [h | t]), do: [h | append(a, t)]

  def append_tail_rec(e, [])  do [e] end
  def append_tail_rec(e, lst) do append_tail_rec(e, lst, []) end

  def append_tail_rec(e, [h|t], acc1) do append_tail_rec(e, t, [h | acc1]) end
  def append_tail_rec(e, [],    acc1) do reverse([e | acc1], []) end
  def reverse([],    acc) do acc end
  def reverse([h|t], [])  do reverse(t, [h]) end
  def reverse([h|t], acc) do reverse(t, [h | acc]) end

end

a = [:a, :b, :c, :d, :e, :f, :g, :h]
b = Append.append(:z, a)
IO.inspect(b)
b = Append.append([:b, :a, :t, :man], a)
IO.inspect(b)

b = Append.append_tail_rec(:z, a)
IO.inspect(b)
