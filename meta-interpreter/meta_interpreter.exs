defmodule Env do

  @doc """
  return an empty env
  """
  def new() do [] end

  @doc """
  return an env where binding of variable id to
  the structure str has been added to the env
  """
  def add(id, str, [{id, _} | tail]) do [{id, str} | tail] end
  def add(id, str, [{_, _} = var | tail ]) do [var | add(id, str, tail)] end
  def add(id, str, []) do [{id, str}] end

  @doc """
  return either {id, str}, if variable id was bound
  or nil
  """
  def lookup(_, []) do nil end
  def lookup(id, [{id, str} | _]) do {id, str} end
  def lookup(id, [_ | tail]) do lookup(id, tail) end

  @doc """
  returns an environment where all bindings for
  variables in the list ids have been removed
  """
  def remove([h|t], env) do remove(h, remove(t, env)) end
  def remove([], env) do env end
  def remove(_, []) do [] end
  def remove(elem, [{elem, _} | tail]) do tail end
  def remove(elem, [{_, _} = var | tail]) do [var | remove(elem, tail)] end

  def test() do
    e = Env.new()
    e = Env.add(1, :a, e)
    e = Env.add(2, :b, e)
    e = Env.add(3, :c, e)
    e = Env.add(4, :d, e)
    e = Env.add(5, :e, e)
    expected = [{1, :a}, {2, :b}, {3, :c}, {4, :d}, {5, :e}]
    IO.inspect(e == expected, label: "add")

    start = [{1, :a}, {2, :b}, {3, :c}, {4, :d}, {5, :e}]
    expected = [{1, :monkey123}, {2, :b}, {3, :c}, {4, :d}, {5, :e}]
    result = Env.add(1, :monkey123, start)
    IO.inspect(result == expected, label: "add, replace first")

    start = [{1, :a}, {2, :b}, {3, :c}, {4, :d}, {5, :e}]
    expected = [{1, :a}, {2, :b}, {3, :c}, {4, :d}, {5, :monkey123}]
    result = Env.add(5, :monkey123, start)
    IO.inspect(result == expected, label: "add, replace last")

    start = [{1, :a}, {2, :b}, {3, :c}, {4, :d}, {5, :e}]
    result = Env.lookup(5, start)
    expected = {5, :e}
    IO.inspect(result == expected, label: "lookup, exist")

    start = [{1, :a}, {2, :b}, {3, :c}, {4, :d}, {5, :e}]
    result = Env.lookup(0, start)
    expected = nil
    IO.inspect(result == expected, label: "lookup, exist")

    start = [{1, :a}, {2, :b}, {3, :c}, {4, :d}, {5, :e}]
    result = Env.remove([1, 4], start)
    expected = [{2, :b}, {3, :c}, {5, :e}]
    IO.inspect(result == expected, label: "remove1")

    start = [{1, :a}, {2, :b}, {3, :c}, {4, :d}, {5, :e}]
    result = Env.remove([0 ,1, 4, 9], start)
    expected = [{2, :b}, {3, :c}, {5, :e}]
    IO.inspect(result == expected, label: "remove2")

    start = [{1, :a}, {2, :b}, {3, :c}, {4, :d}, {5, :e}]
    result = Env.remove([5, 2], start)
    expected = [{1, :a}, {3, :c}, {4, :d}]
    IO.inspect(result == expected, label: "remove3")

    start = [{1, :a}, {2, :b}, {3, :c}, {4, :d}, {5, :e}]
    result = Env.remove([5, 2, 3], start)
    expected = [{1, :a}, {4, :d}]
    IO.inspect(result == expected, label: "remove4")
  end
end

defmodule Eager do
  @doc """
  takes an expression and an environment and returns either
  {:ok, str} where str is a data structure, or :error if the
  expression cannot be evaluated
  """
  def eval_expr({:atm, id}, _) do {:ok, id} end

  def eval_expr({:var, id}, env) do
    case Env.lookup(id, env) do
      nil      -> :error
      {_, str} -> {:ok, str}
    end
  end

  def eval_expr({:cons, head, tail}, env) do
    case eval_expr(head, env) do
      :error   -> :error
      {:ok, h} ->
        case eval_expr(tail, env) do
          :error   -> :error
          {:ok, t} -> {:ok, {h, t}}
        end
    end
  end


  def eval_match(:ignore, _, env) do
    {:ok, env}
  end
  def eval_match({:atm, id}, id, env) do {:ok, env} end
  def eval_match({:var, id}, str, env) do
    case Env.lookup(id, env) do
      nil       -> {:ok, Env.add(id, str, env)}
      {_, ^str} -> {:ok, env}
      {_, _}    -> :fail
    end
  end
  def eval_match({:cons, hp, tp}, {:cons, hs, ts}, env) do
    case eval_match(hp, hs, env) do
      :fail           -> :fail
      {:ok, env_prim} -> eval_match(tp, ts, env_prim)
    end
  end
  def eval_match(_, _, _) do :fail end

  def test() do
    result = eval_expr({:atm, :a}, [])
    expected = {:ok, :a}
    IO.inspect(result == expected, label: "eval_expr1")

    result = eval_expr({:var, :x},  [{:x, :a}])
    expected = {:ok, :a}
    IO.inspect(result == expected, label: "eval_expr2")

    result = eval_expr({:var, :x},  [])
    expected = :error
    IO.inspect(result == expected, label: "eval_expr3")

    result = eval_expr({:cons, {:var, :x}, {:atm, :b}},  [{:x, :a}])
    expected = {:ok, {:a, :b}}
    IO.inspect(result == expected, label: "eval_expr4")

    result = eval_match({:atm, :a}, :a, [])
    expected = {:ok, []}
    IO.inspect(result == expected, label: "eval_match1")

    result = eval_match({:var, :x}, :a, [])
    expected = {:ok, [{:x, :a}]}
    IO.inspect(result == expected, label: "eval_match2")

    result = eval_match({:var, :x}, :a, [{:x, :a}])
    expected = {:ok, [{:x, :a}]}
    IO.inspect(result == expected, label: "eval_match3")

    result = eval_match({:var, :x}, :a, [{:x, :b}])
    expected = :fail
    IO.inspect(result == expected, label: "eval_match4")

    result = eval_match({:cons, {:var, :x}, {:var, :x}}, {:cons, {:atm, :a}, {:atm, :b}}, [])
    expected = :fail
    IO.inspect(result == expected, label: "eval_match5")

    result = eval_match({:cons, {:var, :x}, {:var, :x}}, {:cons, {:atm, :a}, {:atm, :a}}, [])
    expected = {:ok, [x: {:atm, :a}]}
    IO.inspect(result == expected, label: "eval_match6")

  end
end

Eager.test()
