alias Exrtm.Util.Xml.XmlNode
alias Exrtm.Record.List

defmodule Exrtm.List do
  @moduledoc """
  Represents the 'list' of RTM API.
  """

  @doc """
  Returns all the registered lists.
  """
  def get_list(user) do
    lists = Exrtm.API.Lists.GetList.invoke(user)
    Enum.map(lists, fn(e) -> parse_list(e) end)
  end

  @doc """
  Returns a list that maches the specified name.
  """
  def get_by_name(user, name) do
    lists = get_list(user)
    Enum.find(lists, fn(e) -> e.name == name end)
  end

  @doc """
  Creates a new list with the specified name.
  """
  def add(user, name) do
    Exrtm.API.Lists.Add.invoke(user, name)
  end

  @doc """
  Deletes a specified list object.
  """
  def delete(user, list) do
    Exrtm.API.Lists.Delete.invoke(user, list)
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
