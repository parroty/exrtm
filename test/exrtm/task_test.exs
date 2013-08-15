Code.require_file "../test_helper.exs", __DIR__

defmodule Exrtm.TaskTest do
  use ExUnit.Case
  import Mock

  @mock_user [key: "key", secret: "secret", token: "token"]

  test_with_mock "get task list", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url) end] do
    tasks = Exrtm.Task.get_list(@mock_user)
    assert(Enum.count(tasks) == 2)

    task = Enum.first(tasks)
    assert(task.series_id    == "123456789")
    assert(task.name         == "Get Bananas")
    assert(task.modified     == "2006-05-07T10:19:54Z")
    assert(task.tags         == "")
    assert(task.participants == nil)
    assert(task.url          == "http://www.example.com")
    assert(task.created      == "2006-05-07T10:19:54Z")
    assert(task.source       == "api")
    assert(task.rrule        == "FREQ=DAILY;INTERVAL=1")
    assert(task.list_id      == "876543210")

    assert(task.id           == "987654321")
    assert(task.completed    == "")
    assert(task.added        == "2006-05-07T10:19:54Z")
    assert(task.priority     == "N")
    assert(task.deleted      == "")
    assert(task.has_due_time == "0")
    assert(task.estimate     == "")
    assert(task.due          == "")
  end

  test_with_mock "get task list with invalid token fails", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request_error(url) end] do
    assert_raise ExrtmError, fn ->
      Exrtm.Task.get_list(@mock_user)
    end
  end

  test_with_mock "get task by the name", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url) end] do
    task = Exrtm.Task.get_by_name(@mock_user, "2ndTask")
    assert(task.id        == "765432109")
    assert(task.series_id == "234567891")
  end

  test_with_mock "add task", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url) end] do
    task = Exrtm.Task.add(@mock_user, "Get Bananas")
    assert(task.id        == "123456789")
    assert(task.series_id == "987654321")
    assert(task.name      == "Get Bananas")
    assert(task.list_id   == "876543210")
  end

  test_with_mock "add task fails with invalid response", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request_error(url) end] do
    assert_raise ExrtmError, fn ->
      Exrtm.Task.add(@mock_user, "Get Bananas")
    end
  end

  test_with_mock "delete valid task", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url) end] do
    task   = Exrtm.Task.get_by_name(@mock_user, "Get Bananas")
    result = Exrtm.Task.delete(@mock_user, task)

    assert(result.deleted != "")
  end

  test_with_mock "delete invalid task throws exception", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url) end] do
    assert_raise ExrtmError, fn ->
      Exrtm.Task.delete(@mock_user, nil)
    end
  end

  test_with_mock "completes task", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url) end] do
    task   = Exrtm.Task.get_by_name(@mock_user, "Get Bananas")
    result = Exrtm.Task.complete(@mock_user, task)

    assert(result.completed != "")
  end

  test_with_mock "uncompletes task", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url) end] do
    task   = Exrtm.Task.get_by_name(@mock_user, "Get Bananas")
    result = Exrtm.Task.uncomplete(@mock_user, task)

    assert(result.completed == "")
  end

  @add_tags_verify [pre_condition: "rtm.tasks.addTags", expected_match: "tags=coffee,good,mmm"]
  test_with_mock "add tags", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url, @add_tags_verify) end] do
    task   = Exrtm.Task.get_by_name(@mock_user, "Get Bananas")
    result = Exrtm.Task.add_tags(@mock_user, task, "coffee,good,mmm")

    assert(result.tags  == "coffee,good,mmm")
  end

  @remove_tags_verify [pre_condition: "rtm.tasks.removeTags", expected_match: "tags=good"]
  test_with_mock "remove tags", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url, @remove_tags_verify) end] do
    task   = Exrtm.Task.get_by_name(@mock_user, "Get Bananas")
    result = Exrtm.Task.remove_tags(@mock_user, task, "good")

    assert(result.tags  == "coffee,mmm")
  end

  test_with_mock "set priority", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url) end] do
    task   = Exrtm.Task.get_by_name(@mock_user, "Get Bananas")
    result = Exrtm.Task.set_priority(@mock_user, task, "2")

    assert(result.priority == "2")
  end

  test_with_mock "set name", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url) end] do
    task   = Exrtm.Task.get_by_name(@mock_user, "Get Bananas")
    result = Exrtm.Task.set_name(@mock_user, task, "Get Coffee")

    assert(result.name == "Get Coffee")
  end

  test_with_mock "postpone", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url) end] do
    task   = Exrtm.Task.get_by_name(@mock_user, "Get Bananas")
    result = Exrtm.Task.postpone(@mock_user, task)

    assert(result.postponed == "1")
  end

  @set_url_verify [pre_condition: "rtm.tasks.setURL", expected_match: "http://www.myfavoritecoffeeplace.com/"]
  test_with_mock "set url", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url, @set_url_verify) end] do
    task   = Exrtm.Task.get_by_name(@mock_user, "Get Bananas")
    result = Exrtm.Task.set_url(@mock_user, task, "http://www.myfavoritecoffeeplace.com/")

    assert(result.url == "http://www.myfavoritecoffeeplace.com/")
  end

  @set_recurrence_verify [pre_condition: "rtm.tasks.setRecurrence", expected_match: "repeat=daily"]
  test_with_mock "set recurrence", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url, @set_recurrence_verify) end] do
    task   = Exrtm.Task.get_by_name(@mock_user, "Get Bananas")
    result = Exrtm.Task.set_recurrence(@mock_user, task, "daily")

    assert(result.rrule == "FREQ=DAILY;INTERVAL=1")
  end

  @move_priority_verify [pre_condition: "rtm.tasks.movePriority", expected_match: "direction=down"]
  test_with_mock "move priority", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url, @move_priority_verify) end] do
    task   = Exrtm.Task.get_by_name(@mock_user, "Get Bananas")
    result = Exrtm.Task.move_priority(@mock_user, task, "down")

    assert(result.priority == "3")
  end

  @set_due_date_verify [pre_condition: "rtm.tasks.setDueDate", expected_match: "due=2006-05-09T14:00:00Z"]
  test_with_mock "set due date", Exrtm.Util.HTTP, [get: fn(url) -> Exrtm.Mock.request(url, @set_due_date_verify) end] do
    task   = Exrtm.Task.get_by_name(@mock_user, "Get Bananas")
    result = Exrtm.Task.set_due_date(@mock_user, task, "2006-05-09T14:00:00Z", "1")

    assert(result.due == "2006-05-09T14:00:00Z")
  end
end
