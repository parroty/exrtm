Code.require_file "../test_helper.exs", __DIR__

defmodule Exrtm.ListTest do
  use ExUnit.Case
  import Mock

  @mock_user [key: "key", secret: "secret", token: "token"]

  setup_all do
    Exrtm.User.start
    Exrtm.User.set(@mock_user)
  end

  test_with_mock "get_list", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url) end] do
    response  = Exrtm.List.get_list
    assert(Enum.count(response) == 7)
    assert(Enum.first(response).name == "Inbox")
  end

  test_with_mock "get_by_name", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url) end] do
    response = Exrtm.List.get_by_name("New List")
    assert(response.name == "New List")
  end

  test_with_mock "add", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url) end] do
    response = Exrtm.List.add("New List")
    assert(response.name == "New List")
  end

  test_with_mock "delete valid list", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url) end] do
    list   = Exrtm.List.get_by_name("New List")
    result = Exrtm.List.delete(list)

    assert(result != nil)
  end

  test_with_mock "delete invalid list throws exception", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url) end] do
    assert_raise ExrtmError, fn ->
      Exrtm.List.delete(nil)
    end
  end
end
