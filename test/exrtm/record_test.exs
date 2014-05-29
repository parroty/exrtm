Code.require_file "../test_helper.exs", __DIR__

defmodule Exrtm.RecordTest do
  use ExUnit.Case

  alias Exrtm.Record.List
  alias Exrtm.Record.Task

  @list "[List]\n" <>
        "  archived = nil\n" <>
        "  deleted = nil\n" <>
        "  id = 1\n" <>
        "  locked = nil\n" <>
        "  name = test_list\n" <>
        "  position = nil\n" <>
        "  smart = nil\n" <>
        "  sort_order = nil"

  test "IO.puts for List" do
    list = %List{id: 1, name: "test_list"}
    assert Exrtm.Record.stringify_object(list, List) == @list
  end

  @task "[Task]\n" <>
        "  added = nil\n" <>
        "  completed = nil\n" <>
        "  created = nil\n" <>
        "  deleted = nil\n" <>
        "  due = nil\n" <>
        "  estimate = nil\n" <>
        "  has_due_time = nil\n" <>
        "  id = 2\n" <>
        "  list_id = nil\n" <>
        "  modified = nil\n" <>
        "  name = test_task\n" <>
        "  participants = nil\n" <>
        "  postponed = nil\n" <>
        "  priority = nil\n" <>
        "  rrule = nil\n" <>
        "  series_id = 3\n" <>
        "  source = nil\n" <>
        "  tags = nil\n" <>
        "  url = nil"

  test "IO.puts for Task" do
    task = %Task{id: 2, series_id: 3, name: "test_task"}
    assert Exrtm.Record.stringify_object(task, Task) == @task
  end
end


