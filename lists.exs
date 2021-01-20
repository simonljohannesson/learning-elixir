defmodule ListAPI do
  @moduledoc """
  Module for interacting with list structure.
  """
  @doc """
  Take the first element of a list.
  """
  def tak(list) do
    case list do
      []     -> {:no}
      [h|_d] -> {:ok, h}
    end
  end
  @doc """
  Take the last element of a list.
  """
  def drp(list) do
    case list do
      []     -> {:no}
      [h|[]] -> {:ok, h}
      [h|t]  -> drp(t)
    end
  end
  @doc """
  Get length of list.
  """
  def len(list) do
    case list do
      [h|[]] -> 1
      [h|t]  -> 1 + len(t)
      []     -> 0
    end
  end
  @doc """
  Get sum of list.
  """
  def sum(list) do
    case list do
      []     -> 0
      [h|[]] -> h
      [h|t]  -> h + sum(t)
    end
  end
  @doc """
  Duplicate each element in list.
  """
  def duplicate(list) do
    case list do
      []     -> []
      [h|t]  -> [h*2| duplicate(t)]
    end
  end
  @doc """
  Add x to list if its not in the list.

  """
  def add(x, list) do
    case list do
      []    ->
        case x do
          nil -> []
          _   -> [ x ]
        end
      [h|t] ->
        cond do
          h==x -> [h | add(nil, t)]
          true -> [h | add(x, t)]
        end
    end
  end
  @doc """
  Remove all occurences of x in list.
  """
  def remove(x, list) do
    case list do
      []    -> []
      [h|t] ->
        case x do
          ^h -> remove(x,t)
          _  -> [h | remove(x,t)]
        end
    end
  end
  @doc """
  Return list with duplicate elements list removed.
  """
  def unique(list) do
    case list do
      [h|[]] -> [h]
      [h|t]  -> [h | unique(remove(h, t))]
      []     -> []
    end
  end
  @doc """
  Reverse list.
  """
  def reverse(list) do
    reverse(list, [])
  end
  def reverse([], acc) do
    acc
  end
  def reverse([h|t], acc) do
    reverse(t, [h | acc])
  end
end

tl = [1,2,3,4,5,6]
tldup = [1,2,2,3,4,4,4,5,6,6,6]

res = ListAPI.tak(tl)
IO.inspect(res)

res = ListAPI.tak([])
IO.inspect(res)

res = ListAPI.drp(tl)
IO.inspect(res)

res = ListAPI.drp([])
IO.inspect(res)

res = ListAPI.len(tl)
IO.inspect(res)

res = ListAPI.len([])
IO.inspect(res)

res = ListAPI.sum(tl)
IO.inspect(res)

res = ListAPI.sum([])
IO.inspect(res)

res = ListAPI.duplicate(tl)
IO.inspect(res)

res = ListAPI.duplicate([])
IO.inspect(res)

res = ListAPI.add(6, tl)
IO.inspect(res)

res = ListAPI.add(668, [])
IO.inspect(res)

res = ListAPI.remove(4, tl)
IO.inspect(res)

res = ListAPI.remove(668, [])
IO.inspect(res)


res = ListAPI.unique(tldup)
IO.inspect(res, label: "unique")
res = ListAPI.unique([])
IO.inspect(res, label: "unique")

res = ListAPI.reverse(tl)
IO.inspect(res, label: "reverse")
res = ListAPI.reverse([])
IO.inspect(res, label: "reverse")
