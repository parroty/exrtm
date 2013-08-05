alias Exrtm.Util.Xml.XmlNode

defmodule Exrtm.API.Lists.Base do
  def do_invoke(user, request) do
    response = Exrtm.API.do_request(user, request)
    parse_one_list_result(response)
  end

  defp parse_one_list_result(response) do
    doc = XmlNode.from_string(response)
    doc |> XmlNode.first("//list")
        |> Exrtm.List.parse_list
  end
end

defmodule Exrtm.API.Lists.GetList do
  def invoke(user) do
    request  = Exrtm.API.create_request_param(user, [method: "rtm.lists.getList"])
    response = Exrtm.API.do_request(user, request)
    parse_result(response)
  end

  def parse_result(response) do
    doc = XmlNode.from_string(response)
    doc |> XmlNode.first("//lists")
        |> XmlNode.all("//list")
  end
end

defmodule Exrtm.API.Lists.Add do
  def invoke(user, name) do
    timeline = Exrtm.Timeline.create(user)
    request  = Exrtm.API.create_request_param(user, [method: "rtm.lists.add", name: name, timeline: timeline])
    Exrtm.API.Lists.Base.do_invoke(user, request)
  end
end

defmodule Exrtm.API.Lists.Delete do
  def invoke(user, list) do
    if list == nil do raise "specified list is invalid." end

    timeline = Exrtm.Timeline.create(user)
    request  = Exrtm.API.create_request_param(user, [method: "rtm.lists.delete", list_id: list.id, timeline: timeline])
    Exrtm.API.Lists.Base.do_invoke(user, request)
  end
end
