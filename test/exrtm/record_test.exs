Code.require_file "../test_helper.exs", __DIR__

defmodule Exrtm.RecordTest do
  use ExUnit.Case

  alias Exrtm.Record.List
  alias Exrtm.Record.Task

  @list "[List]\n" <>
        "  id = 1\n" <>
        "  name = test_list\n" <>
        "  deleted = nil\n" <>
        "  locked = nil\n" <>
        "  archived = nil\n" <>
        "  position = nil\n" <>
        "  smart = nil\n" <>
        "  sort_order = nil"

  test "IO.puts for List" do
    list = List.new(id: 1, name: "test_list")
    assert Exrtm.Record.stringify_object(list, List) == @list
  end

  @task "[Task]\n" <>
        "  id = 2\n" <>
        "  series_id = 3\n" <>
        "  name = test_task\n" <>
        "  tags = nil\n" <>
        "  modified = nil\n" <>
        "  participants = nil\n" <>
        "  url = nil\n" <>
        "  created = nil\n" <>
        "  source = nil\n" <>
        "  rrule = nil\n" <>
        "  list_id = nil\n" <>
        "  completed = nil\n" <>
        "  added = nil\n" <>
        "  postponed = nil\n" <>
        "  priority = nil\n" <>
        "  deleted = nil\n" <>
        "  has_due_time = nil\n" <>
        "  estimate = nil\n" <>
        "  due = nil"

  test "IO.puts for Task" do
    task = Task.new(id: 2, series_id: 3, name: "test_task")
    assert Exrtm.Record.stringify_object(task, Task) == @task
  end
end


