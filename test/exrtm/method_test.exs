defmodule Exrtm.MethodTest do
  use ExUnit.Case
  import Mock

  @mock_user [key: "key", secret: "secret", token: "token"]

  @echo_verify [pre_condition: "rtm.test.echo", expected_match: "api_key=key"]
  test_with_mock "execute general method call", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url, @echo_verify) end] do
    response = Exrtm.call(@mock_user, [method: "rtm.test.echo", api_key: @mock_user[:key]])
    assert(response == "<method>rtm.test.echo</method>")
  end

  test_with_mock "execute tasks.getList with general method call", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url) end] do
    response = Exrtm.call(@mock_user, [method: "rtm.tasks.getList", api_key: @mock_user[:key]])
    assert(response =~ ~r/list id="876543210/)
  end
end