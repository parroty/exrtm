Code.require_file "../test_helper.exs", __DIR__

defmodule Exrtm.ProtocolTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias Exrtm.Record.List
  alias Exrtm.Record.Task
  alias Exrtm.Record.Chunk

  test "Exrtm.puts for List" do
    list = List.new(id: 1, name: "test_list")
    assert capture_io(fn ->
      Exrtm.puts(list)
    end) == "test_list\n"
  end

  test "Exrtm.puts for Task" do
    task = Task.new(id: 2, name: "test_task", chunks: [Chunk.new, Chunk.new])
    assert capture_io(fn ->
      Exrtm.puts(task)
    end) == "test_task\n"
  end

  test "Exrtm.puts for Task list" do
    task1 = Task.new(id: 2, name: "test_task1", chunks: [Chunk.new, Chunk.new])
    task2 = Task.new(id: 3, name: "test_task2", chunks: [Chunk.new, Chunk.new])
    assert capture_io(fn ->
      Exrtm.puts([task1, task2])
    end) == "test_task1\ntest_task2\n"
  end
end