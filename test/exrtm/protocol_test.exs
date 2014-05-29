Code.require_file "../test_helper.exs", __DIR__

defmodule Exrtm.ProtocolTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias Exrtm.Record.List
  alias Exrtm.Record.Task

  def format(string, length) do
    string <> String.duplicate(" ", length - String.length(string))
  end

  test "Exrtm.puts for List" do
    list = %List{id: 1, name: "test_list"}
    assert capture_io(fn ->
      Exrtm.puts(list)
    end) == "test_list\n"
  end

  test "Exrtm.puts for Task" do
    task = %Task{id: 2, name: "test_task"}
    assert capture_io(fn ->
      Exrtm.puts(task)
    end) == format("test_task", 32) <> "\n"
  end

  test "Exrtm.puts for Task with tag-name" do
    task = %Task{id: 2, name: "test_task", tags: "tag"}
    assert capture_io(fn ->
      Exrtm.puts(task)
    end) == format("test_task(tag)", 32) <> "\n"
  end

  test "Exrtm.puts for Task with option length" do
    task = %Task{id: 2, name: "test_task"}
    assert capture_io(fn ->
      Exrtm.puts(task, [length: 64])
    end) == format("test_task", 64) <> "\n"
  end

  test "Exrtm.puts for Task list" do
    task1 = %Task{id: 2, name: "test_task1"}
    task2 = %Task{id: 3, name: "test_task2"}
    assert capture_io(fn ->
      Exrtm.puts([task1, task2])
    end) == format("test_task1", 32) <> "\n" <>
            format("test_task2", 32) <> "\n"
  end


  @list "[List]\n" <>
        "  archived = nil\n" <>
        "  deleted = nil\n" <>
        "  id = 1\n" <>
        "  locked = nil\n" <>
        "  name = test_list\n" <>
        "  position = nil\n" <>
        "  smart = nil\n" <>
        "  sort_order = nil\n"

  test "Exrtm.puts_detail for List" do
    list = %List{id: 1, name: "test_list"}
    assert capture_io(fn ->
      Exrtm.puts_detail(list)
    end) == @list
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
        "  url = nil\n"

  test "Exrtm.puts_detail for Task" do
    task = %Task{id: 2, series_id: 3, name: "test_task"}
    assert capture_io(fn ->
      Exrtm.puts_detail(task)
    end) == @task
  end

end