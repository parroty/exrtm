Code.require_file "../test_helper.exs", __DIR__

defmodule Exrtm.MD5Test do
  use ExUnit.Case

  test "hexdigest for normal string" do
    assert(Exrtm.MD5.hexdigest("elixir") == "74b565865a192cc8693c530d48eb383a")
  end

  test "hexdigest for empty string" do
    assert(Exrtm.MD5.hexdigest("") == "d41d8cd98f00b204e9800998ecf8427e")
  end

end
