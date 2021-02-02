map = %{"a" => 1, "b" => 3}
map = Map.put(map,"a", map["a"]+1)
IO.inspect(map)
