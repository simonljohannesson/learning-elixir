defmodule IntToBin do
  @moduledoc """
  Turns an integer into a list representing the binary representation.
  """
  def to_binary_list(n) do to_binary_list(n, []) end
  def to_binary_list(0, b) do b end
  def to_binary_list(n, b) do
    to_binary_list(div(n,2), [rem(n,2)|b])
  end

  def bin_backwards(0) do [] end
  def bin_backwards(n) do
    [rem(n,2)| bin_backwards(div(n,2))] # produces list bakofram
  end
end


IO.inspect(IntToBin.to_binary_list(88))
IO.inspect(IntToBin.bin_backwards(88))
