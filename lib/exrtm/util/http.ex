defmodule Exrtm.Util.HTTP do
  @doc """
  Get the content of the specified URL.
  """
  def get(url) do
    :inets.start
    {result, response} = :httpc.request(:binary.bin_to_list(url))

    if result == :ok do
      {_status, _headers, content} = response
      iodata_to_binary(content)
    else
      raise %ExrtmError{message: "http request failed - [url] " <> url}
    end
  end
end
