defmodule Exrtm.Util.MD5 do
  @doc """
  Calculate the MD5 of the specified string in hexadecimal format.
  """
  def hexdigest(string) do
    hash = :crypto.hash(:md5, string)
    list = Enum.map(:binary.bin_to_list(hash), fn(x) -> padding(x) end)
    Enum.join(list, "")
  end

  defp padding(number) when number == 0 do
    "00"
  end

  defp padding(number) when number < 16 do
    "0" <> to_s(number)
  end

  defp padding(number) do
    to_s(number)
  end

  defp to_s(number) do
    String.downcase(integer_to_binary(number, 16))
  end
end

