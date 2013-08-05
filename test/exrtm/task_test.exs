Code.require_file "../test_helper.exs", __DIR__

defmodule Exrtm.TaskTest do
  use ExUnit.Case
  import Mock

  @mock_user [key: "key", secret: "secret", token: "token"]

  test_with_mock "find_all", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url) end] do
    tasks = Exrtm.Task.find_all(@mock_user)
    assert(Enum.count(tasks) == 2)

    task = Enum.first(tasks)
    assert(task.id           == "123456789")
    assert(task.name         == "Get Bananas")
    assert(task.modified     == "2006-05-07T10:19:54Z")
    assert(task.tags         == nil)
    assert(task.participants == nil)
    assert(task.url          == "http://www.example.com")
    assert(task.created      == "2006-05-07T10:19:54Z")
    assert(task.source       == "api")
    assert(task.rrule        == "FREQ=DAILY;INTERVAL=1")
    assert(task.list_id      == "876543210")

    assert(Enum.count(task.chunks) == 1)

    chunk = Enum.first(task.chunks)
    assert(chunk.id           == "987654321")
    assert(chunk.completed    == "")
    assert(chunk.added        == "2006-05-07T10:19:54Z")
    assert(chunk.priority     == "N")
    assert(chunk.deleted      == "")
    assert(chunk.has_due_time == "0")
    assert(chunk.estimate     == "")
    assert(chunk.due          == "")
  end

  test_with_mock "find", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url) end] do
    task = Exrtm.Task.find(@mock_user, "2ndTask")
    assert(task.id == "234567891")
  end

  test_with_mock "add", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url) end] do
    task = Exrtm.Task.add(@mock_user, "Get Bananas")
    assert(task.id      == "987654321")
    assert(task.name    == "Get Bananas")
    assert(task.list_id == "876543210")
  end

  test_with_mock "delete valid task", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url) end] do
    task   = Exrtm.Task.find(@mock_user, "Get Bananas")
    result = Exrtm.Task.delete(@mock_user, task)

    assert(result != nil)
  end

  test_with_mock "delete invalid tasks throws exception", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url) end] do
    assert_raise RuntimeError, fn ->
      Exrtm.Task.delete(@mock_user, nil)
    end
  end
end
