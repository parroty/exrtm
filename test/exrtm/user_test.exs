Code.require_file "../test_helper.exs", __DIR__

defmodule Exrtm.UserTest do
  use ExUnit.Case

  @mock_user [key: "key", secret: "secret", token: "token"]

  test "set user variable" do
    Exrtm.User.start
    Exrtm.User.set(@mock_user)

    assert(Exrtm.User.get == @mock_user)
  end
end