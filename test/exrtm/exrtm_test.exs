defmodule ExrtmTest do
  use ExUnit.Case
  import Mock

  @mock_user [key: "key", secret: "secret", token: "token"]

  test "init_api" do
    user = Exrtm.init_api("key", "secret", "token")
    assert(user == [key: "key", secret: "secret", token: "token"])
  end

  test "get_auth_url" do
    url = Exrtm.get_auth_url(@mock_user, "delete", "frob")
    assert(Regex.match?(%r/.+rememberthemilk.+api_key.+/, url))
  end

  test_with_mock "get_frob", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url) end] do
    response  = Exrtm.get_frob(@mock_user)
    assert(response == "0a56717c3561e53584f292bb7081a533c197270c")
  end
end