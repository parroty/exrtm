defmodule Exrtm.HTTP do
  # TODO : error handling
  def get(url) do
    :inets.start
    {:ok, {_status, _headers, content}} = :httpc.request(binary_to_list(url))
    list_to_binary(content)
  end
end