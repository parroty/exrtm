alias Exrtm.Util.Xml.XmlNode

defmodule Exrtm.API do
  @moduledoc """
  Provides initial infrastractures to call remember the milk APIs.
  """

  @rtm_uri   "http://www.rememberthemilk.com"
  @rest_path "/services/rest/"
  @auth_path "/services/auth/"
  @perms     ["read", "write", "delete"]

  def init_api(key, secret, token) do
    user = [key: key, secret: secret, token: token]
    Exrtm.User.start
    Exrtm.User.set(user)
    user
  end

  def initialize(user, method) do
    [method: method, api_key: user[:key]]
  end

  def get_auth_url(user, permission, frob) do
    params = [api_key: user[:key], perms: permission, frob: frob]
    @rtm_uri <> @auth_path <> do_make_url(user[:secret], params)
  end

  def do_request(user, request) do
    url = @rtm_uri <> @rest_path <> do_make_url(user[:secret], request)
    response = Exrtm.Util.HTTP.get(url)

    stat = XmlNode.from_string(response)
            |> XmlNode.first("//rsp")
            |> XmlNode.attr("stat")

    if stat == "fail" do
      raise ExrtmError.new(message: "Error returned from the server. [response] " <> response)
    else
      response
    end
  end

  def create_request_param(user \\ nil, params) do
    [api_key: user[:key], auth_token: user[:token]] ++ params
  end

  defp do_make_url(secret, params) do
    query_params = URI.encode_query(params)
    signature    = sign(secret, params)

    "?#{query_params}&api_sig=#{signature}"
  end

  defp sign(secret, params) do
    concatinated_params = Enum.map(Keyword.keys(params), fn(x) -> "#{atom_to_binary(x)}#{params[x]}" end)
    joined_param_str    = Enum.join(Enum.sort(concatinated_params))

    Exrtm.Util.MD5.hexdigest("#{secret}#{joined_param_str}")
  end
end
