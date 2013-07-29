alias Exrtm.Xml.XmlNode

defmodule Exrtm.Chunk do
  defrecord Chunk, id: nil, completed: nil, added: nil, postponed: nil,
                   priority: nil, deleted: nil, has_due_time: nil,
                   estimate: nil, due: nil

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
