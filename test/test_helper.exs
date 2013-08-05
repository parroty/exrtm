ExUnit.start

defmodule Exrtm.Mock do
  @empty [url: "", response: ""]
  @patterns [
    [url: %r/.*rtm.auth.getFrob.*/, response: "<frob>0a56717c3561e53584f292bb7081a533c197270c</frob>"],
    [url: %r/.*rtm.auth.getToken.*/, response_file: "test/fixtures/rtm.auth.getToken"],
    [url: %r/.*rtm.timelines.create.*/, response: "<timeline>12741021</timeline>"],
    [url: %r/.*rtm.lists.getList.*/, response_file: "test/fixtures/rtm.lists.getList" ],
    [url: %r/.*rtm.lists.add.*/, response: "<list id=\"987654321\" name=\"New List\" deleted=\"0\" locked=\"0\" archived=\"0\" position=\"0\" smart=\"0\"/>"],
    [url: %r/.*rtm.lists.delete.*/, response_file: "test/fixtures/rtm.lists.delete" ],
    [url: %r/.*rtm.tasks.add.*/, response_file: "test/fixtures/rtm.tasks.add" ],
    [url: %r/.*rtm.tasks.getList.*/, response_file: "test/fixtures/rtm.tasks.getList" ],
    [url: %r/.*rtm.tasks.delete.*/, response_file: "test/fixtures/rtm.tasks.delete" ]
  ]
  # [error example]
  # <?xml version='1.0' encoding='UTF-8'?><rsp stat=\"fail\"><err code=\"320\" msg=\"list_id invalid or not provided\"/></rsp>"

  # TODO : handle error case for more descriptive message
  def read_file(file_name) do
    {:ok, content} = File.read(file_name)
    content
  end

  def request(url) do
    item = Enum.find(@patterns, @empty, fn(x) -> Regex.match?(x[:url], url) end)
    if item[:response_file] do
      read_file(item[:response_file])
    else
      item[:response]
    end
  end
end

