Code.require_file "../test_helper.exs", __DIR__

defmodule RTM.HTTPTest do
  use ExUnit.Case

  @url "http://www.rememberthemilk.com/services/rest/"
  @response "<?xml version=\'1.0\' encoding=\'UTF-8\'?><rsp stat=\"fail\"><err code=\"112\" msg=\"Method &quot;&quot; not found\"/></rsp>"

  # temporary comments out for avoiding to hit network
  # test "request http" do
  #   assert(RTM.HTTP.get(@url) == @response)
  # end

end
