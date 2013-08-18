Code.require_file "../test_helper.exs", __DIR__

defmodule Exrtm.TimelineTest do
  use ExUnit.Case
  import Mock

  @mock_user [key: "key", secret: "secret", token: "token"]

  setup_all do
    Exrtm.User.start
    Exrtm.User.set(@mock_user)
  end

  test_with_mock "Exrtm.Timeline.create", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url) end] do
    response  = Exrtm.Timeline.create
    assert(response == "12741021")
  end
end
