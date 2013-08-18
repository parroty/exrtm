alias Exrtm.Util.Xml.XmlNode

defmodule Exrtm.API.Timelines.Create do
  def invoke do
    user = Exrtm.User.get
    request  = [method: "rtm.timelines.create", api_key: user[:key], auth_token: user[:token]]
    response = Exrtm.API.do_request(user, request)
    parse_result(response)
  end

  def parse_result(response) do
    XmlNode.from_string(response)
      |> XmlNode.first("//timeline")
      |> XmlNode.text
  end
end
