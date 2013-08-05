alias Exrtm.Util.Xml.XmlNode

defmodule Exrtm.API.Lists.GetList do
  def invoke(user) do
    request  = [method: "rtm.lists.getList", api_key: user[:key], auth_token: user[:token]]
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
    request  = [method: "rtm.lists.add", api_key: user[:key], auth_token: user[:token], name: name, timeline: timeline]
    response = Exrtm.API.do_request(user, request)
    parse_result(response)
  end

  def parse_result(response) do
    doc = XmlNode.from_string(response)
    doc |> XmlNode.first("//list")
        |> Exrtm.List.parse_list
  end
end
