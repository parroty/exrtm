alias Exrtm.Util.Xml.XmlNode

defmodule Exrtm.API do
  @rtm_uri   "http://www.rememberthemilk.com"
  @rest_path "/services/rest/"
  @auth_path "/services/auth/"
  @perms     ["read", "write", "delete"]

  def init_api(key, secret, token) do
    [key: key, secret: secret, token: token]
  end

  def initialize(user, method) do
    [method: method, api_key: user[:key]]
  end

  def get_auth_url(user, permission, frob) do
    params = [["api_key", user[:key]], ["perms", permission], ["frob", frob]]
    @rtm_uri <> @auth_path <> do_make_url(user[:secret], params)
  end

  def do_request(user, request) do
    url = @rtm_uri <> make_url(user[:secret], request)
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

  def create_request_param(user, params) do
    [api_key: user[:key], auth_token: user[:token]] ++ params
  end

  defp make_url(secret, request) do
    params = Enum.map(Keyword.keys(request), fn(x) -> [atom_to_binary(x), request[x]] end)
    @rest_path <> do_make_url(secret, params)
  end

  defp do_make_url(secret, params) do
    params_for_url = Enum.map(params, fn(x) -> Enum.join(x, "=") end)
    params_in_str  = Enum.join(Enum.sort(params_for_url), "&")
    signature      = sign(secret, params)

    "?#{params_in_str}&api_sig=#{signature}"
  end

  defp sign(secret, params) do
    joined_key_values = Enum.map(params, fn(x) -> Enum.join(x, "") end)
    joined_param_str  = Enum.join(Enum.sort(joined_key_values))

    Exrtm.Util.MD5.hexdigest("#{secret}#{joined_param_str}")
  end
end
