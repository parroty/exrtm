alias Exrtm.Util.Xml.XmlNode
alias Exrtm.Record.Chunk

defmodule Exrtm.Chunk do
  @moduledoc """
  Represents the 'task' of RTM API. Its operation is provided through Exrtm.Task.
  """

  def parse_chunks(elements) do
    Enum.map(elements, fn(e) -> parse_chunk(e) end)
  end

  defp parse_chunk(element) do
    Chunk.new(
      id:           element |> XmlNode.attr("id"),
      completed:    element |> XmlNode.attr("completed"),
      added:        element |> XmlNode.attr("added"),
      priority:     element |> XmlNode.attr("priority"),
      deleted:      element |> XmlNode.attr("deleted"),
      has_due_time: element |> XmlNode.attr("has_due_time"),
      estimate:     element |> XmlNode.attr("estimate"),
      due:          element |> XmlNode.attr("due")
    )
  end
end
