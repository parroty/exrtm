Code.require_file "../test_helper.exs", __DIR__

defmodule Exrtm.ListTest do
  use ExUnit.Case
  import Mock

  @mock_user [key: "key", secret: "secret", token: "token"]

  test_with_mock "alive_all", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url) end] do
    response  = Exrtm.List.alive_all(@mock_user)
    assert(Enum.count(response) == 7)
    assert(Enum.first(response).name == "Inbox")
  end

  test_with_mock "find", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url) end] do
    response = Exrtm.List.find(@mock_user, "New List")
    assert(response.name == "New List")
  end

  test_with_mock "add", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url) end] do
    response = Exrtm.List.add(@mock_user, "New List")
    assert(response.name == "New List")
  end
end
