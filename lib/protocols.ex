defprotocol Binary.Exrtm do
  def puts(data, options)
  def puts_detail(data, options)
end

defimpl Binary.Exrtm, for: List do
  def puts(data, options) do
    Enum.each(data, fn(x) -> Binary.Exrtm.puts(x, options) end)
  end

  def puts_detail(data, options) do
    Enum.each(data, fn(x) -> Binary.Exrtm.puts_detail(x, options) end)
  end
end

defimpl Binary.Exrtm, for: Exrtm.Record.Task do
  import ExPrintf

  def puts(data, options) do
    length = options[:length]
    name   = data.name || ""
    tags   = if empty?(data.tags), do: "", else: "(#{data.tags})"

    printf("%-#{length}s%s\n", [name <> tags, data.due || ""])
  end

  def puts_detail(data, _options) do
    IO.puts Exrtm.Record.stringify_object(data, Exrtm.Record.Task)
  end

  defp empty?(value) do
    value == nil || value == ""
  end
end

defimpl Binary.Exrtm, for: Exrtm.Record.List do
  def puts(data, _options) do
    IO.puts "#{data.name}"
  end

  def puts_detail(data, _options) do
    IO.puts Exrtm.Record.stringify_object(data, Exrtm.Record.List)
  end
end
