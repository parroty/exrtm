defmodule Exrtm.AuthTest do
  use ExUnit.Case
  import Mock

  @mock_user [key: "key", secret: "secret", token: "token"]

  test "init_api" do
    user = Exrtm.Auth.init_api("key", "secret", "token")
    assert(user == [key: "key", secret: "secret", token: "token"])
  end

  test "get_auth_url" do
    url = Exrtm.Auth.get_auth_url(@mock_user, "delete", "frob")
    assert(Regex.match?(~r/.+rememberthemilk.+api_key.+/, url))
  end

  test_with_mock "get_frob", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url) end] do
    response  = Exrtm.Auth.get_frob(@mock_user)
    assert(response == "0a56717c3561e53584f292bb7081a533c197270c")
  end

  test_with_mock "get_token", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url) end] do
    response  = Exrtm.Auth.get_token(@mock_user, "stub_frob")
    assert(response == "6410bde19b6dfb474fec71f186bc715831ea6842")
  end
end