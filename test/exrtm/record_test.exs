Code.require_file "../test_helper.exs", __DIR__

defmodule Exrtm.RecordTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias Exrtm.Record.List
  alias Exrtm.Record.Task
  alias Exrtm.Record.Chunk

  @list "[List]\n" <>
        "  id = 1\n" <>
        "  name = test_list\n" <>
        "  deleted = nil\n" <>
        "  locked = nil\n" <>
        "  archived = nil\n" <>
        "  position = nil\n" <>
        "  smart = nil\n" <>
        "  sort_order = nil\n"

  test "IO.puts for List" do
    list = List.new(id: 1, name: "test_list")
    assert capture_io(fn ->
      IO.puts list
    end) == @list
  end

  @task "[Task]\n" <>
        "  id = 2\n" <>
        "  name = test_task\n" <>
        "  tags = nil\n" <>
        "  modified = nil\n" <>
        "  participants = nil\n" <>
        "  url = nil\n" <>
        "  created = nil\n" <>
        "  source = nil\n" <>
        "  rrule = nil\n" <>
        "  chunks = [2 items]\n" <>
        "  list_id = nil\n"

  test "IO.puts for Task" do
    task = Task.new(id: 2, name: "test_task", chunks: [Chunk.new, Chunk.new])
    assert capture_io(fn ->
      IO.puts task
    end) == @task
  end
end


