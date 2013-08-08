defmodule Exrtm.Util.HTTP do
  def get(url) do
    :inets.start
    {result, response} = :httpc.request(binary_to_list(url))

    if result == :ok do
      {_status, _headers, content} = response
      list_to_binary(content)
    else
      raise ExrtmError.new(message: "http request failed - [url] " <> url)
    end
  end
end
