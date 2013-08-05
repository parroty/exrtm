alias Exrtm.Util.Xml.XmlNode

defmodule Exrtm.List do
  defrecord List, id: nil, name: nil, deleted: nil, locked: nil,
                  archived: nil, position: nil, smart: nil, sort_order: nil

  def alive_all(user) do
    lists = Exrtm.API.Lists.GetList.invoke(user)
    Enum.map(lists, fn(e) -> parse_list(e) end)
  end

  def find(user, name) do
    lists = alive_all(user)
    Enum.find(lists, fn(e) -> e.name == name end)
  end

  def add(user, name) do
    Exrtm.API.Lists.Add.invoke(user, name)
  end

  def parse_list(element) do
    List.new(
      id:         element |> XmlNode.attr("id"),
      name:       element |> XmlNode.attr("name"),
      deleted:    element |> XmlNode.attr("deleted"),
      locked:     element |> XmlNode.attr("locked"),
      archived:   element |> XmlNode.attr("archived"),
      position:   element |> XmlNode.attr("position"),
      smart:      element |> XmlNode.attr("smart"),
      sort_order: element |> XmlNode.attr("sort_order")
    )
  end
end
