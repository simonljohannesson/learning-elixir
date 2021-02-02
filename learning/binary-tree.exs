defmodule BT do
  @moduledoc """
  A BT is determined to consist of the below components.

  :nil                              ## the empty tree
  {:leaf, value}                    ## a leaf
  {:node, value, left, right}       ## a node

  """
  @doc """
  Determines if an element is in tree.
  Takes an element and a binary tree.
  Returns :yes if member, else :no
  """
  def member(_, :nil) do :no end
  def member(e, {:leaf, e}) do :yes end
  def member(_, {:leaf, _}) do :no end
  def member(e, {:node, e, _, _}) do :yes end
  def member(e, {:node, v, left, _}) when e<v do
    member(e, left)
  end
  def member(e, {:node, _, _, right}) do
    member(e, right)
  end


  @doc """
  Inserts an element in a binary tree.

  Assumes that the item does not exist in tree.
  """
  def insert(e, :nil) do {:node, e, :nil, :nil} end
  def insert(e, {:leaf, v}) do
    cond do
      e < v -> {:node, v, {:leaf, e}, :nil}
      true  -> {:node, v, :nil, {:leaf, e}}
    end
  end
  def insert(e, {:node, v, left, right}) do
    cond do
      e < v -> {:node, v, insert(e, left), right}
      true  -> {:node, v, left, insert(e, right)}
    end

  end


  @doc """
  Deletes an element from a binary tree.

  If it does not, returns an identical tree.
  """
  def delete(_, :nil) do :nil end
  def delete(e, {:leaf, e}) do :nil end
  def delete(_, {:leaf, v}) do {:leaf, v} end
  def delete(e, {:node, e, left, :nil}) do left end
  def delete(e, {:node, e, :nil, right}) do right end
  def delete(e, {:node, v, left, right}) when e<v do
    {:node, v, delete(e, left), right}
  end
  # match in node with two children
  def delete(e, {:node, e, left, right}) do
    # find max elem of left branch
    m = max(left)
    # delete max elem, and use to replace e
    {:node, m, delete(m, left), right}
  end
  def delete(e, {:node, v, left, right}) do
    {:node, v, left, delete(e, right)}
  end
  @doc """
  Finds the max value in the tree.
  """
  def max({:leaf, v}) do v end
  def max({:node, v, _, :nil})  do v end
  def max({:node, _, _, right}) do max(right) end


end


# Do implement the above BT but with a key value store,
# and use same representation for a node and a leaf.
# I.e. a leaf is an empty node.
defmodule BTKeyValue do
  @moduledoc """
  A BTKeyValue is determined to consist of the below components.

  :nil                              ## the empty tree
  {:node, key, value, :nil, :nil}        ## a leaf
  {:node, key, value, left, right}       ## a node

  """
  @doc """
  Determines if an element is in tree.
  Takes an element and a binary tree.
  Returns :yes if member, else :no
  """
  def member(_, :nil) do :no end
  def member(key, {:node, key, _, :nil, :nil}) do :yes end
  def member(_, {:node, _, _, :nil, :nil}) do :no end
  def member(key, {:node, key, _, _, _}) do :yes end
  def member(key, {:node, v, _, left, _}) when key<v do
    member(key, left)
  end
  def member(key, {:node, _, _, _, right}) do
    member(key, right)
  end


  @doc """
  Inserts an element in a binary tree.

  Assumes that the item does not exist in tree.
  """
  def insert(key, value, :nil) do {:node, key, value, :nil, :nil} end
  def insert(key, value, {:node, k, v, :nil, :nil}) when key<k do
    {:node, k, v, {:node, key, value, :nil, :nil}, :nil}
  end
  def insert(key, value, {:node, k, v, :nil, :nil}) do
    {:node, k, v, :nil, {:node, key, value, :nil, :nil}}
  end
  def insert(key, value, {:node, k, v, left, right}) do
    cond do
      key < k -> {:node, k, v, insert(key, value, left), right}
      true  -> {:node, k, v, left, insert(key, value, right)}
    end

  end


  @doc """
  Deletes an element from a binary tree.

  If it does not, returns an identical tree.
  """
  def delete(_, _, :nil) do :nil end
  def delete(key, {:node, key, _, :nil, :nil}) do :nil end
  def delete(_, {:node, k, v, :nil, :nil}) do {:node, k, v, :nil, :nil} end
  def delete(key, {:node, key, _, left, :nil}) do left end
  def delete(key, {:node, key, _, :nil, right}) do right end
  # match in node with two children
  def delete(key, {:node, key, _, left, right}) do
    # find max elem of left branch
    {k, v} = max(left)
    # delete max elem, and use to replace e
    {:node, k, v, delete(k, left), right}
  end
  def delete(key, {:node, k, v, left, right}) when key<k do
    {:node, k, v, delete(key, left), right}
  end
  def delete(key, {:node, k, v, left, right}) do
    {:node, k, v, left, delete(key, right)}
  end
  @doc """
  Finds the max value in the tree.
  """
  def max({:node, k, v, :nil, :nil}) do {k, v} end
  def max({:node, k, v, _, :nil})  do {k, v} end
  def max({:node, _, _, _, right}) do max(right) end


end



# b1 = {:leaf, 1}
# b2 = {:leaf, 10}

# b3 = {:leaf, 20}
# b4 = {:leaf, 30}

# n1 = {:node, 4, b1, b2}
# n2 = {:node, 22, b3, b4}

# root = {:node, 15, n1, n2}


# single = {:node, 250, :nil, b1}
# res = BT.delete(15, root)

# IO.inspect(res)


b1 = {:node, 1, "a", :nil, :nil}
b2 = {:node, 10, "b", :nil, :nil}

b3 = {:node, 20, "c", :nil, :nil}
b4 = {:node, 30, "d", :nil, :nil}

n1 = {:node, 4, "e", b1, b2}
n2 = {:node, 22, "f", b3, b4}

root = {:node, 15,"g", n1, n2}


# single = {:node, 250, :nil, b1}
res = BTKeyValue.insert(0, "234", root)
IO.inspect(root, label: "root   ")
IO.inspect(res, label: "deleted")
