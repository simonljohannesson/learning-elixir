defmodule Recursion do
  def print(msg, num) when num <= 1 do
    IO.puts(msg)
  end
  def print(msg, num) do
    IO.puts(msg)
    print(msg, num-1)
  end
end
Recursion.print("working", 5)


defmodule Math do
  def sum_list(list, acc \\ 0) ## header with default value

  # def sum_list([h|t], acc) when length(t) == 0 do ##
  #   acc + h                                       ## Alternative
  # end                                             ##
  def sum_list([], acc) do
    acc
  end

  def sum_list([h|t], acc) do
    sum_list(t, acc + h)
  end

  # better map implementaiton
  def map([], _do_func) do [] end
  def map([h|t], do_func) do
    # IO.inspect binding()            # used for debugging
    [do_func.(h) | map(t, do_func)]
  end
end


list = [3, 2, 7]
acc = Math.sum_list(list)
IO.puts(acc)


sub_one = fn num -> num - 1 end
IO.inspect(sub_one.(10))

# IO.inspect(Math.map([], &sub_one/1))
IO.inspect(Math.map(list, &(&1-1)))

IO.inspect(Enum.map(list, &(&1-1)))
