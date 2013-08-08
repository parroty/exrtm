ExUnit.start

defmodule Exrtm.Mock do
  @empty [url: "", response: ""]
  @default_patterns [
    [url: %r/.*rtm.auth.getFrob&.*/, response: "<frob>0a56717c3561e53584f292bb7081a533c197270c</frob>"],
    [url: %r/.*rtm.auth.getToken&.*/, response_file: "test/fixtures/rtm.auth.getToken"],
    [url: %r/.*rtm.timelines.create&.*/, response: "<timeline>12741021</timeline>"],
    [url: %r/.*rtm.lists.getList&.*/, response_file: "test/fixtures/rtm.lists.getList" ],
    [url: %r/.*rtm.lists.add&.*/, response: "<list id=\"987654321\" name=\"New List\" deleted=\"0\" locked=\"0\" archived=\"0\" position=\"0\" smart=\"0\"/>"],
    [url: %r/.*rtm.lists.delete&.*/, response_file: "test/fixtures/rtm.lists.delete" ],
    [url: %r/.*rtm.tasks.addTags&.*/, response_file: "test/fixtures/rtm.tasks.addTags" ],
    [url: %r/.*rtm.tasks.removeTags&.*/, response_file: "test/fixtures/rtm.tasks.removeTags" ],
    [url: %r/.*rtm.tasks.getList&.*/, response_file: "test/fixtures/rtm.tasks.getList" ],
    [url: %r/.*rtm.tasks.complete&.*/, response_file: "test/fixtures/rtm.tasks.complete" ],
    [url: %r/.*rtm.tasks.uncomplete&.*/, response_file: "test/fixtures/rtm.tasks.uncomplete" ],
    [url: %r/.*rtm.tasks.add&.*/, response_file: "test/fixtures/rtm.tasks.add" ],
    [url: %r/.*rtm.tasks.delete&.*/, response_file: "test/fixtures/rtm.tasks.delete" ],
    [url: %r/.*rtm.tasks.setPriority&.*/, response_file: "test/fixtures/rtm.tasks.setPriority" ]
  ]
  @error_patterns [
    [url: %r/.*rtm.tasks.add&.*/, response_file: "test/fixtures/rtm.tasks.add.invalid" ],
    [url: %r/.*rtm.tasks.getList&.*/, response_file: "test/fixtures/rtm.tasks.getList.invalid" ]
  ]

  # [error example]
  # <?xml version='1.0' encoding='UTF-8'?><rsp stat=\"fail\"><err code=\"320\" msg=\"list_id invalid or not provided\"/></rsp>"

  defp read_file(file_name) do
    {:ok, content} = File.read(file_name)
    content
  end

  def request(url) do
    do_request([@default_patterns], url)
  end

  def request_error(url) do
    do_request([@error_patterns, @default_patterns], url)
  end

  defp do_request(patterns_list, url) do
    matches         = Enum.map(patterns_list, fn(patterns) -> find_item(patterns, url) end)
    not_nil_matches = Enum.filter(matches, fn(x) -> x != nil end)

    if Enum.count(not_nil_matches) == 0 do
      raise "mock pattern specified in the test was not found."
    else
      item = Enum.first(not_nil_matches)
      if item[:response_file] do
        read_file(item[:response_file])
      else
        item[:response]
      end
    end
  end

  defp find_item(patterns, url) do
    Enum.find(patterns, fn(x) -> Regex.match?(x[:url], url) end)
  end
end

