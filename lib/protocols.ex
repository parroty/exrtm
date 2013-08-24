defprotocol Binary.Exrtm do
  def puts(data, options)
end

defimpl Binary.Exrtm, for: List do
  def puts(data, options) do
    Enum.each(data, fn(x) -> Binary.Exrtm.puts(x, options) end)
  end
end

defimpl Binary.Exrtm, for: Exrtm.Record.Task do
  import ExPrintf

  def puts(data, options) do
    length = options[:length]
    printf("%-#{length}s%s\n", [data.name || "", data.due || ""])
  end
end

defimpl Binary.Exrtm, for: Exrtm.Record.List do
  def puts(data, _options) do
    IO.puts "#{data.name}"
  end
end
