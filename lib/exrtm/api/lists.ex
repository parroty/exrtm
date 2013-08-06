alias Exrtm.Util.Xml.XmlNode
alias Exrtm.Record.List

defmodule Exrtm.API.Lists.Base do
  @doc """
  handle requests which involves single item like add and delete operations.
  """
  def handle_single_item(user, request) do
    response = Exrtm.API.do_request(user, request)
    list = XmlNode.from_string(response)
             |> XmlNode.first("//list")

    parse(list)
  end

  @doc """
  handle requests which involves multiple items like getList operations.
  """
  def handle_multiple_items(user, request) do
    response = Exrtm.API.do_request(user, request)
    lists = XmlNode.from_string(response)
              |> XmlNode.first("//lists")
              |> XmlNode.all("//list")

    Enum.map(lists, fn(e) -> parse(e) end)
  end

  defp parse(element) do
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

defmodule Exrtm.API.Lists.GetList do
  def invoke(user) do
    request  = Exrtm.API.create_request_param(user, [method: "rtm.lists.getList"])
    Exrtm.API.Lists.Base.handle_multiple_items(user, request)
  end
end

defmodule Exrtm.API.Lists.Add do
  def invoke(user, name) do
    timeline = Exrtm.Timeline.create(user)
    request  = Exrtm.API.create_request_param(user, [method: "rtm.lists.add", name: name, timeline: timeline])
    Exrtm.API.Lists.Base.handle_single_item(user, request)
  end
end

defmodule Exrtm.API.Lists.Delete do
  def invoke(user, list) do
    if list == nil do raise ExrtmError.new(message: "specified list is invalid.") end

    timeline = Exrtm.Timeline.create(user)
    request  = Exrtm.API.create_request_param(user, [method: "rtm.lists.delete", list_id: list.id, timeline: timeline])
    Exrtm.API.Lists.Base.handle_single_item(user, request)
  end
end
