ExUnit.start

defmodule Exrtm.Mock do
  use ExUnit.Case

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
    [url: %r/.*rtm.tasks.setPriority&.*/, response_file: "test/fixtures/rtm.tasks.setPriority" ],
    [url: %r/.*rtm.tasks.setName&.*/, response_file: "test/fixtures/rtm.tasks.setName" ]
  ]
  @error_patterns [
    [url: %r/.*rtm.tasks.add&.*/, response_file: "test/fixtures/rtm.tasks.add.invalid" ],
    [url: %r/.*rtm.tasks.getList&.*/, response_file: "test/fixtures/rtm.tasks.getList.invalid" ]
  ]

  def request(url, assertion // nil) do
    do_request([@default_patterns], url, assertion)
  end

  def request_error(url, assertion // nil) do
    do_request([@error_patterns, @default_patterns], url, assertion)
  end

  defp read_file(file_name) do
    case File.read(file_name) do
      {:ok, content} ->
        content
      {:error, _content} ->
        raise "file not found : file_name = #{file_name}"
    end
  end

  defp do_request(patterns_list, url, assertion) do
    matches         = Enum.map(patterns_list, fn(patterns) -> find_item(patterns, url) end)
    not_nil_matches = Enum.filter(matches, fn(x) -> x != nil end)

    if assertion != nil do
      verify_url_assertion(url, assertion)
    end

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

  # verify request url to contain certain string (used to verify outgoing command)
  # TODO : needs more proper description format, like jasmine's spyOn.
  defp verify_url_assertion(url, assertion) do
    if String.contains?(url, assertion[:pre_condition]) do
      assert(String.contains?(url, assertion[:expected_match]),
        "expected string '#{url} to contain '#{assertion[:expected_match]}', but didn't.")
    end
  end

  defp find_item(patterns, url) do
    Enum.find(patterns, fn(x) -> Regex.match?(x[:url], url) end)
  end
end

