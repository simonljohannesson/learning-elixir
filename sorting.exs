defmodule Sort1 do
  def insert(e, []) do [e] end
  def insert(e, [h|t]) do
    cond do
      e < h -> [e | [h | t]]
      t == [] -> [h | [e]]
      true  -> [h | insert(e,t)]
    end
  end
  def isort([]) do [] end
  def isort(list) do isort(list, []) end
  def isort([h|t], acc) do
    case t do
      [] -> insert(h, acc)
      _  -> isort(t, insert(h,acc))
    end
  end
end

IO.puts("Insertionsort:")
rand = Enum.shuffle(1..15)
IO.inspect(rand, label:            "rand list")
IO.inspect(Enum.sort(rand), label: "control  ")
r = Sort1.isort(rand)
IO.inspect(r, label:               "isort    ")

defmodule Sort2 do
  def msort(list) do
    case length(list) do
      1 -> list
      _ ->
        {a, b} = msplit(list, [], [])
        merge(msort(a), msort(b))
    end
  end

  def msplit(lst, left, right) do
    case lst do
      []    -> {left, right}
      [h|t] -> msplit(t, right, [h|left])
    end
  end

  def msplit_alt(lst, left, right) do
    case lst do
      []        -> {left, right}
      [a,b | t] -> msplit_alt(t, [a|left], [b|right])
      [a|[]]    -> {[a|left], right}
    end
  end

  def bad_msplit([h|t], left, right) do
    cond do
      length(t) < length(left)  -> {left, [h|t]}
      true -> msplit(t, [h|left], right)
    end
  end

  def merge([], lst) do lst end
  def merge(lst, []) do lst end
  def merge([lh|lt], [rh|rt]) do
    if lh < rh do
      [lh | merge(lt, [rh|rt])]
    else
      [rh | merge(rt, [lh|lt])]
    end
  end

end

IO.puts("Mergesort:")
rand = Enum.take_random(0..99, 15)
IO.inspect(rand, label: "rand   ")
cont = Enum.sort(rand)
IO.inspect(cont, label: "cont   ")
sort = Sort2.msort(rand)
IO.inspect(sort, label: "sort   ")


defmodule Sort3 do
  def qsort([]) do
    []
  end
  # def qsort([h|[]]) do
  #   # IO.inspect binding()
  #   [h] end
  def qsort([p | l]) do
    # IO.inspect binding()
    {sma , lar} = qsplit(p, l, [], [])
    small = qsort(sma)
    large = qsort(lar)
    append(small, [p| large])
  end

  def qsplit(_, [], small, large) do {small, large} end
  def qsplit(p, [h|t], small, large) do
    if h < p do
      qsplit(p, t, [h|small], large)
    else
      qsplit(p, t, small, [h|large])
    end
  end
  def append([], right) do right end
  def append([h|[]], right) do
    [h | right] end
  def append([h|t], right)  do
    [h | append(t, right)] end
end

IO.puts("Qsort:")
r =  Enum.shuffle(1..15)
IO.inspect(r, charlists: :as_lists, label: "random" )
r = Enum.sort(r)
IO.inspect(r, charlists: :as_lists, label: "contrl" )
res = Sort3.qsort(r)
IO.inspect(res, charlists: :as_lists, label: "sorted" )
