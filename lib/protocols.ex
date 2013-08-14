defprotocol Binary.Exrtm do
  def puts(data)
end

defimpl Binary.Exrtm, for: List do
  def puts(data) do
    Enum.each(data, fn(x) -> Binary.Exrtm.puts(x) end)
  end
end

defimpl Binary.Exrtm, for: Exrtm.Record.Task do
  def puts(data) do
    IO.puts "#{data.name}"
  end
end

defimpl Binary.Exrtm, for: Exrtm.Record.List do
  def puts(data) do
    IO.puts "#{data.name}"
  end
end
