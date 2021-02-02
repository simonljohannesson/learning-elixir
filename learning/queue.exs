defmodule Queue do
  @moduledoc """
  Simple queue operations module.

  Head represents end of queue/last element in queue.
  """
  def add(queue, elm) do
    [elm | queue]
  end
  def remove([h|[]]) do
    {h}
  end
  def remove([h|t]) do
    case remove(t) do
      {head, queue} -> {head, [h | queue]}
      {head} -> {head, [h]}
    end
  end
end

defmodule Queue2 do
  @moduledoc """
  Simple queue operations module.

  Head represents beginning of queue.
  """
  def add([], elm) do [elm] end
  def add([h|t], elm) do [h | add(t, elm)] end
  def remove([h | t]) do {h, t} end

end

queue = [1,2,3,4,5,6]
queue = Queue.add(queue, 8)
IO.inspect(queue, label: "added 8")
{next, queue} = Queue.remove(queue)
IO.inspect(next, label: "next")
IO.inspect(queue, label: "new queue")
IO.puts("")
queue = [1,2,3,4,5,6]
queue = Queue2.add(queue, 8)
IO.inspect(queue, label: "added 8")
{next, queue} = Queue2.remove(queue)
IO.inspect(next, label: "next")
IO.inspect(queue, label: "new queue")
