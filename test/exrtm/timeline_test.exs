Code.require_file "../test_helper.exs", __DIR__

defmodule Exrtm.TimelineTest do
  use ExUnit.Case
  import Mock

  @mock_user [key: "key", secret: "secret", token: "token"]

  test_with_mock "Exrtm.Timeline.create", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url) end] do
    response  = Exrtm.Timeline.create(@mock_user)
    assert(response == "12741021")
  end
end
