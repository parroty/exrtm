Code.require_file "../test_helper.exs", __DIR__

defmodule Exrtm.HTTPTest do
  use ExUnit.Case

  @url "http://www.rememberthemilk.com/services/rest/"
  @response "<?xml version=\'1.0\' encoding=\'UTF-8\'?><rsp stat=\"fail\"><err code=\"112\" msg=\"Method &quot;&quot; not found\"/></rsp>"

  # These tests are temporary commented out for avoiding to hit network. Uncomment when necessary.

  # test "request http succeeds" do
  #   assert(Exrtm.Util.HTTP.get(@url) == @response)
  # end

  # test "request http fails with invalid url" do
  #   assert_raise ExrtmError, fn ->
  #     Exrtm.Util.HTTP.get("http://invalidsomeurl.com")
  #   end
  # end
end
