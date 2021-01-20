defmodule Temperature do
  def far_to_cel(temp) do
    (temp - 32)/1.8
  end
end

IO.puts(Temperature.far_to_cel(100))



temp_diff = &(IO.puts(
  "F: " <>
  Integer.to_string(&1) <>
  " C: " <>
  Float.to_string(Temperature.far_to_cel(&1))
))

Enum.map(0..30, &(&1 * 10)) |> IO.inspect(label: "before") |> Enum.map(temp_diff) |> IO.inspect(label: "after")


defmodule Shapes do
  def rect_area(x, y) do
    x * y
  end
  def square_area(x) do
    rect_area(x, x)
  end
  def circle_area(rad) do
    :math.pi() * :math.pow(rad, 2)
    end
end

# IO.puts(Shapes.circle_area(3))


defmodule Recurs do
  @doc """
  Compute the product between m and n.
  """
  def _prod(m, _n, acc) when m <=0, do: acc
    # acc
  # end

  def _prod(m, n, acc)  do
    _prod(m-1, n, n+acc)
  end

  def prod(m, n) do
    _prod(m, n, 0)
  end

  def prod_case(m, n) do
    case m do
      0 -> 0
      _ -> n + prod_case(m-1, n)
    end
  end

  def prod_negative(m, n) do
    # IO.inspect(m, label: "m:")
    # IO.inspect(n, label: "n:")
    cond do
      m < 0 -> prod_negative(-m, -n)
      m == 0 -> 0
      true -> n + prod_negative(m-1, n)
    end
  end

  def power_non_neg(base, exponent) when is_integer(exponent) and exponent >= 0 do
    case exponent do
      0 -> 1
      _ -> base * power_non_neg(base, exponent - 1)
    end
  end

  def qpower(base, exponent) do
    # if power odd do non neg power
    cond do
      rem(exponent, 2) == 1 -> base * qpower(base, exponent-1)
      exponent == 0 -> 1
      true -> qpower(base*base, div(exponent,2)) # power not odd
    end
  end
end

defmodule Fib do
  def fib(n) do
    cond do
      n==0 -> 0
      n==1 -> 1
      true -> fib(n-1) + fib(n-2)
    end
  end

  def bench() do
    8..40 |> Enum.filter( &(rem(&1, 2)==0) ) |> Enum.map(&time/1) |> Enum.map(&show/1)

  end

  def time(n) do
    {t, _} = :timer.tc(fn -> Fib.fib(n) end)
    {t, n}
  end

  def show({time, number}) do
    IO.puts("s: " <>
    Float.to_string(time / 1_000_000) <>
    " Fib(" <>
    Integer.to_string(number) <>
    ")")
  end
end




# IO.puts(Recurs.prod(88, 732))
# IO.puts(Recurs.prod_case(88, 732))
# IO.puts(Recurs.prod_negative(-3636535, 423345634))
# IO.puts(Recurs.prod_case(-3636535, 423345634))
# IO.puts(-3636535 * 423345634)
# IO.inspect(Recurs.power_non_neg(2, 10))
# IO.inspect(Recurs.qpower(93, 127))
# IO.inspect(:math.pow(93, 127))
# IO.inspect(Fib.fib(11))
# Fib.time(11)
Fib.bench()
