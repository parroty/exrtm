
defmodule Exrtm.Record do
  @moduledoc """
  An module that contains set of record objects
  """

  defmodule Task do
    defstruct id: nil, series_id: nil, name: nil, tags: nil, modified: nil, participants: nil,
              url: nil, created: nil, source: nil, rrule: nil, list_id: nil,
              completed: nil, added: nil, postponed: nil,
              priority: nil, deleted: nil, has_due_time: nil,
              estimate: nil, due: nil
  end

  defmodule List do
    defstruct id: nil, name: nil, deleted: nil, locked: nil,
              archived: nil, position: nil, smart: nil, sort_order: nil
  end

  def stringify_object(object, type) do
    keys   = type.__struct__ |> Map.keys |> Enum.filter(&(&1 != :__struct__))
    values = Map.to_list(object)
    chars  = Enum.map(keys, fn(key) -> "  #{key} = #{get_value(values, key)}" end)

    # (ex.) use "Task" as name for "Exrtm.Record.Task".
    original_name = to_string(type)
    display_name  = String.split(original_name, ".") |> Enum.reverse |> Enum.at(0)

    "[#{display_name}]\n" <> Enum.join(chars, "\n")
  end

  defp get_value(values, key) do
    do_get_value(Keyword.get(values, key))
  end

  defp do_get_value(value) when value == nil   do "nil" end
  defp do_get_value(value) when is_list(value) do "[#{Enum.count(value)} items]" end
  defp do_get_value(value)                     do value end
end

