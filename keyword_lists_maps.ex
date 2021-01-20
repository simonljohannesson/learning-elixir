# keyword lists are lists of tuples

a = [{:a, 4}, {:b, 1}]
b = [a: 4, b: 1]

IO.inspect(a)
IO.inspect(b)

# Keyword lists are important because they have three special characteristics:

#     Keys must be atoms.
#     Keys are ordered, as specified by the developer.
#     Keys can be given more than once.


# maps
a_map = %{:a => "A", :b => "B", 1 => :c}

IO.puts(a_map[:a])
IO.puts(a_map[:b])
IO.puts(a_map[1])
IO.puts(a_map.a)  # atom keys access

# Compared to keyword lists, we can already see two differences:

#     Maps allow any value as a key.
#     Maps’ keys do not follow any ordering.
