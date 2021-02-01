defmodule AVLTree do
  @moduledoc """
  Implementation of AVL-Tree as part of an assignment.

  AVL-tree properties:
    - Requires heights of right & left children of every
      node to differ by at most 1.

  Representation:
    - node    {:node, key, value, diff, left, right}
    - empty    nil

  """
  def new() do nil end
  def get(nil, key) do {:error, key} end
  def get({:node, key, value, _, _, _}, key) do {:ok, value} end
  def get({:node, _, _, _, nil, nil}, key) do {:error, key} end
  def get({:node, k, _, _, left, right}, key) do
    cond do
      key<k -> get(left, key)
      true  -> get(right, key)
    end
  end

  def get_key_value_pairs(tree) do
    _get_key_value_pairs(tree, [])
  end
  defp _get_key_value_pairs(nil, lst) do lst end
  defp _get_key_value_pairs({:node, k, v, _, l, r}, lst) do
    _get_key_value_pairs(r, [{k, v} | _get_key_value_pairs(l, lst)])
  end

  def insert(tree, key, value) do
    case _insert(tree, key, value) do
      {:inc, q} -> q
      {:ok, q}  -> q
    end
  end
  # special case 1
  defp _insert(nil, key, value) do
    {:inc, {:node, key, value, 0, nil, nil}}
  end
  # special case 2
  defp _insert({:node, key, _, f, a, b}, key, value) do
    {:ok, {:node, key, value, f, a, b}}
  end
  # general rule 1 - left
  defp _insert({:node, rk, rv, 0, a, b}, kk, kv) when kk < rk do
    case _insert(a, kk, kv) do
      {:inc, q} ->
        {:inc, {:node, rk, rv, -1, q, b}}
      {:ok, q}  ->
        {:ok, {:node, rk, rv, 0, q, b}}
    end
  end
  # general rule 2 - left
  defp _insert({:node, rk, rv, +1, a, b}, kk, kv) when kk < rk do
    case _insert(a, kk, kv) do
      {:inc, q} ->
        {:ok, {:node, rk, rv, 0, q, b}}
      {:ok, q}  ->
        {:ok, {:node, rk, rv, +1, q, b}}
    end
  end
  # general rule 3 - left
  defp _insert({:node, rk, rv, -1, a, b}, kk, kv) when kk < rk do
    case _insert(a, kk, kv) do
      {:inc, q} ->
        {:ok, rotate({:node, rk, rv, -2, q, b})}
      {:ok, q}  ->
        {:ok, {:node, rk, rv, -1, q, b}}
    end
  end
  # general rule 4 - right
  defp _insert({:node, rk, rv, 0, a, b}, kk, kv) do # rk <= kk
    case _insert(b, kk, kv) do
      {:inc, q} ->
        {:inc, {:node, rk, rv, +1, a, q}}
      {:ok, q}  ->
        {:ok, {:node, rk, rv, 0, a, q}}
    end
  end
  # general rule 5 - right
  defp _insert({:node, rk, rv, +1, a, b}, kk, kv) do # rk <= kk
    case _insert(b, kk, kv) do
      {:inc, q} ->
        {:ok, rotate({:node, rk, rv, +2, a, q})}
      {:ok, q}  ->
        {:ok, {:node, rk, rv, +1, a, q}}
    end
  end
  # general rule 6 - right
  defp _insert({:node, rk, rv, -1, a, b}, kk, kv) do # rk <= kk
    case _insert(b, kk, kv) do
      {:inc, q} ->
        {:ok, {:node, rk, rv, 0, a, q}}
      {:ok, q}  ->
        {:ok, {:node, rk, rv, -1, a, q}}
    end
  end

  # single rotation # 1
  defp rotate({:node, xk, xv, -2, {:node, yk, yv, -1, a, b}, c}) do
    {:node, yk, yv, 0, a, {:node, xk, xv, 0, b,c}}
  end
  # single rotation # 2
  defp rotate({:node, xk, xv, +2, a, {:node, yk, yv, +1, b, c}}) do
    {:node, yk, yv, 0, {:node, xk, xv, 0, a, b}, c}
  end

  # double rotations # 1 - left
  defp rotate({:node, xk, xv, -2, {:node, yk, yv, +1, a, {:node, zk, zv, -1, b, c}}, d}) do
    {:node, zk, zv, 0, {:node, yk, yv, 0, a, b}, {:node, xk, xv, +1, c, d}}
  end
  # double rotations # 2 - left
  defp rotate({:node, xk, xv, -2, {:node, yk, yv, +1, a, {:node, zk, zv, +1, b, c}}, d}) do
    {:node, zk, zv, 0, {:node, yk, yv, -1, a, b}, {:node, xk, xv, 0, c, d}}
  end
  # double rotations # 3 - left
  defp rotate({:node, xk, xv, -2, {:node, yk, yv, +1, a, {:node, zk, zv, 0, b, c}}, d}) do
    {:node, zk, zv, 0, {:node, yk, yv, 0, a, b}, {:node, xk, xv, 0, c, d}}
  end
  # double rotations # 4 - right
  defp rotate({:node, xk, xv, +2, a, {:node, yk, yv, -1, {:node, zk, zv, -1, b, c}, d}}) do
    {:node, zk, zv, 0, {:node, xk, xv, 0, a, b}, {:node, yk, yv, +1, c, d}}
  end
  # double rotations # 5 - right
  defp rotate({:node, xk, xv, +2, a, {:node, yk, yv, -1, {:node, zk, zv, +1, b, c}, d}}) do
    {:node, zk, zv, 0, {:node, xk, xv, -1, a, b}, {:node, yk, yv, 0, c, d}}
  end
  # double rotations # 6 - right
  defp rotate({:node, xk, xv, +2, a, {:node, yk, yv, -1, {:node, zk, zv, 0, b, c}, d}}) do
    {:node, zk, zv, 0, {:node, xk, xv, 0, a, b}, {:node, yk, yv, 0, c, d}}
  end
end


# res = AVLTree.get(t, 385)
# IO.inspect(res, label: "get")

# Huffman coding test

defmodule ReadFile do
  def read(file, n) do
    case File.open(file, [:read]) do
      {:ok, file} ->
        binary = IO.read(file, n)
        File.close(file)

        case :unicode.characters_to_list(binary, :utf8) do
          {:incompete, list, _} -> list;
          list ->
            list
        end
      {:error, reason} ->
        IO.puts("ERROR: #{reason}")
        {:error, reason}
    end
  end
end


# defmodule Test do
#   def test([]) do end
#   def test([h|t]) do
#     # IO.puts(List.to_string([h]))
#     IO.puts(<<h::utf8>>)
#     test(t)
#   end
# end


defmodule FrequencyCounter do
  def analyze_text(text, tree_module) do
    _analyze_text(text, tree_module.new(), tree_module)
  end

  defp _analyze_text([h|t], tree, tree_module) do
    case tree_module.get(tree, h) do
      {:error, h} -> _analyze_text(t, tree_module.insert(tree, h, 1), tree_module)
      {:ok, value} -> _analyze_text(t, tree_module.insert(tree, h, value+1), tree_module)
    end
  end
  defp _analyze_text([], tree, _) do tree end
end


defmodule Sort do
  def merge_sort(list, compare_func) do msort(list, compare_func) end

  defp msort(list, compare_func) do
    case length(list) do
      1 -> list
      _ ->
        {a, b} = msplit(list, [], [])
        merge(msort(a, compare_func), msort(b, compare_func), compare_func)
    end
  end

  defp msplit(lst, left, right) do
    case lst do
      []    -> {left, right}
      [h|t] -> msplit(t, right, [h|left])
    end
  end

  defp merge([], lst, _) do lst end
  defp merge(lst, [], _) do lst end
  defp merge([lh|lt], [rh|rt], compare_func) do
    if compare_func.(lh, rh) do
      [lh | merge(lt, [rh|rt], compare_func)]
    else
      [rh | merge(rt, [lh|lt], compare_func)]
    end
  end
end


defmodule Huffman do
  @moduledoc """
  Creates a huffman tree.



  empty tree:   nil
  node:         {:node, freq, l, r}
  leaf:         {letter, freq}
  """

  # base case return root
  @doc """
  Builds huffman tree from list.

  List format: [{letter, frequency}, ...]
  """
  def build_huffman_tree([h | []]) do h end
  def build_huffman_tree([h1, h2 | tail]) do
    # merge h1 into h2
    # insert the merged tree into the pq
    # continue until only one element left in the pq_list
    build_huffman_tree(pq_insert(tail, merge(h2, h1)))
  end

  @doc """
  Merges two trees with each other.

  Arg 1 is considered the base tree and arg 2
  is the tree that is merging into arg 1.

  merge(tree, node)
  """
  # node into node
  def merge({:node, freq, _, _} = old_node, {:node, f, _, _} = new_node) do
    case f < freq do
      false -> {:node, freq+f, old_node, new_node}
      true  -> {:node, freq+f, new_node, old_node}
    end
  end
  # should be redundant
  def merge(nil, node) do node end
  # node into leaf
  def merge({_, freq} = leaf, {:node, f, _, _} = new_node) do
    case f < freq do
      false -> {:node, freq+f, leaf, new_node}
      true  -> {:node, freq+f, new_node, leaf}
    end
  end
  # leaf into leaf
  def merge({_, freq1} = leaf1, {_, freq2} = leaf2) do
    case freq2 < freq1 do
      false -> {:node, freq1+freq2, leaf1, leaf2}
      true ->  {:node, freq1+freq2, leaf2, leaf1}
    end
  end
  # leaf into node
  def merge({:node, freq, _, _} = old_node, {_, f} = new_leaf) do
    case f < freq do
      false -> {:node, freq+f, old_node, new_leaf}
      true  -> {:node, freq+f, new_leaf, old_node}
    end
  end

  # end of list
  def pq_insert([], {:node, _, _, _} = node) do [node] end

  def pq_insert([{_, freq1} = h | tail], {:node, freq2, _, _} = node) do
    case freq2 < freq1 do
      false -> [h | pq_insert(tail, node)]
      true  -> [node |[ h | tail]]
    end
  end

  def pq_insert([{:node, freq1, _, _} = h | tail], {:node, freq2, _, _} = node) do
    case freq2 < freq1 do
      false -> [h | pq_insert(tail, node)]
      true  -> [node | [h | tail]]
    end
  end
end



# lst = [{:a, 1}, {:b, 3}, {:c, 7}]
# lst = Huffman.pq_insert(lst, {:node, 2, nil, nil})
# IO.inspect(lst)

# n = {:node, 14, {"f", 5}, {"e", 9}}
# l = {"d", 16}
# thirty = Huffman.merge(l, n)

# twentyfive = {:node, 25, {"c", 12}, {"b", 13}}

# fiftyfive = Huffman.merge(twentyfive, thirty)
# hundred = Huffman.merge(fiftyfive, {"a", 45})
# IO.inspect(hundred)

pq = [
  {"f", 5},
  {"e", 9},
  {"c", 12},
  {"b", 13},
  {"d", 16},
  {"a", 45}
]
# IO.inspect(pq)

IO.inspect(Huffman.build_huffman_tree(pq))


# Perform task
# text = ReadFile.read("trees/text-document.txt", 100000000)
# letter_frequency_bst = FrequencyCounter.analyze_text(text, AVLTree)
# letter_frequency_lst = AVLTree.get_key_value_pairs(letter_frequency_bst)

# compare = fn {_, freq1}, {_, freq2} -> freq1 < freq2 end

# sorted_frequency = Sort.merge_sort(letter_frequency_lst, compare)
# IO.inspect(sorted_frequency)


# IO.inspect(text, charlists: :as_lists)
# IO.inspect(text, label: "text")
# IO.inspect(AVLTree.get(letter_frequency, ?o), label: "o")
# IO.inspect(AVLTree.get(letter_frequency, ?d), label: "d")
# IO.inspect(AVLTree.get(letter_frequency, ?s), label: "s")
# IO.inspect(AVLTree.get(letter_frequency, ?a), label: "a")


# TODO: merge sort the list after the frequency
# TODO: huffman coding can begin
