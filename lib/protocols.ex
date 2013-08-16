defprotocol Binary.Exrtm do
  def puts(data, options)
end

defimpl Binary.Exrtm, for: List do
  def puts(data, options) do
    Enum.each(data, fn(x) -> Binary.Exrtm.puts(x, options) end)
  end
end

defimpl Binary.Exrtm, for: Exrtm.Record.Task do
  def puts(data, options) do
    IO.puts Enum.join(:io_lib.format("~-#{options[:length]}s~s", remove_nil([data.name, data.due])), "")
  end

  def remove_nil(list) do
    Enum.map(list, fn(item) ->
      if item == nil do
        ""
      else
        item
      end
    end)
  end
end

defimpl Binary.Exrtm, for: Exrtm.Record.List do
  def puts(data, _options) do
    IO.puts "#{data.name}"
  end
end
