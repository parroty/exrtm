alias Exrtm.Xml.XmlNode

defmodule Exrtm.API.Auth.GetFrob do
  def invoke(user) do
    request  = [method: "rtm.auth.getFrob", api_key: user[:key]]
    response = Exrtm.API.do_request(user, request)
    parse_result(response)
  end

  def parse_result(response) do
    doc = XmlNode.from_string(response)
    doc |> XmlNode.first("//frob") |> XmlNode.text
  end
end

defmodule Exrtm.API.Auth.GetToken do
  def invoke(user, frob) do
    request  = [method: "rtm.auth.getToken", api_key: user[:key], frob: frob]
    response = Exrtm.API.do_request(user, request)
    parse_result(response)
  end

  def parse_result(response) do
    doc = XmlNode.from_string(response)
    doc |> XmlNode.first("//token") |> XmlNode.text
  end
end
