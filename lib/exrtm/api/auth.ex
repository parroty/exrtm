alias Exrtm.Util.Xml.XmlNode

defmodule Exrtm.API.Auth do
  defmodule GetFrob do
    def invoke(user) do
      request  = [method: "rtm.auth.getFrob", api_key: user[:key]]
      response = Exrtm.API.do_request(user, request)
      parse_result(response)
    end

    defp parse_result(response) do
      XmlNode.from_string(response)
         |> XmlNode.first("//frob")
         |> XmlNode.text
    end
  end

  defmodule GetToken do
    def invoke(user, frob) do
      request  = [method: "rtm.auth.getToken", api_key: user[:key], frob: frob]
      response = Exrtm.API.do_request(user, request)
      parse_result(response)
    end

    defp parse_result(response) do
      XmlNode.from_string(response)
        |> XmlNode.first("//token")
        |> XmlNode.text
    end
  end
end