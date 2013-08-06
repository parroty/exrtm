alias Exrtm.Util.Xml.XmlNode
alias Exrtm.Record.Task
alias Exrtm.Record.Chunk

defmodule Exrtm.API.Tasks.Base do
  @doc """
  handle requests which involves single task item like add and delete operations.
  """
  def handle_single_item(user, request) do
    response = Exrtm.API.do_request(user, request)
    list = XmlNode.from_string(response)
             |> XmlNode.first("//list")

    tasks = parse_task(list)
    count = Enum.count(tasks)
    if count > 1 do raise "expected single task, but #{count} tasks returned." end
    Enum.first(tasks)
  end

  @doc """
  handle requests which involves multiple task items like getList operations.
  """
  def handle_multiple_items(user, request) do
    response = Exrtm.API.do_request(user, request)
    list = XmlNode.from_string(response)
             |> XmlNode.first("//tasks")
             |> XmlNode.all("//list")

    List.flatten(Enum.map(list, fn(e) -> parse_task(e) end))
  end

  defp parse_task(element) do
    list_id    = element |> XmlNode.attr("id")
    taskseries = element |> XmlNode.all("taskseries")
    Enum.map(taskseries, fn(e) -> parse_taskseries(e, list_id) end)
  end

  defp parse_taskseries(element, list_id) do
    chunks = parse_chunks(element |> XmlNode.all("task"))

    Task.new(
      id:           element |> XmlNode.attr("id"),
      name:         element |> XmlNode.attr("name"),
      modified:     element |> XmlNode.attr("modified"),
      tags:         element |> XmlNode.first("tags") |> XmlNode.text,
      participants: element |> XmlNode.first("participants") |> XmlNode.text,
      url:          element |> XmlNode.attr("url"),
      created:      element |> XmlNode.attr("created"),
      source:       element |> XmlNode.attr("source"),
      rrule:        element |> XmlNode.first("rrule") |> XmlNode.text,
      list_id:      list_id,
      chunks:       chunks
    )
  end

  defp parse_chunks(elements) do
    Enum.map(elements, fn(e) -> parse_chunk(e) end)
  end

  defp parse_chunk(element) do
    Chunk.new(
      id:           element |> XmlNode.attr("id"),
      completed:    element |> XmlNode.attr("completed"),
      added:        element |> XmlNode.attr("added"),
      priority:     element |> XmlNode.attr("priority"),
      deleted:      element |> XmlNode.attr("deleted"),
      has_due_time: element |> XmlNode.attr("has_due_time"),
      estimate:     element |> XmlNode.attr("estimate"),
      due:          element |> XmlNode.attr("due")
    )
  end
end

defmodule Exrtm.API.Tasks.GetList do
  def invoke(user) do
    request  = Exrtm.API.create_request_param(user, [method: "rtm.tasks.getList"])
    Exrtm.API.Tasks.Base.handle_multiple_items(user, request)
  end
end

defmodule Exrtm.API.Tasks.Add do
  def invoke(user, name) do
    timeline = Exrtm.Timeline.create(user)
    request  = Exrtm.API.create_request_param(user, [method: "rtm.tasks.add", name: name, timeline: timeline])
    Exrtm.API.Tasks.Base.handle_single_item(user, request)
  end
end

defmodule Exrtm.API.Tasks.Delete do
  def invoke(user, task) do
    if task == nil do raise "specified task is invalid." end

    timeline = Exrtm.Timeline.create(user)
    Enum.map(task.chunks, fn(c) -> do_invoke(user, task, c, timeline) end)
    task
  end

  defp do_invoke(user, task, chunk, timeline) do
    request = Exrtm.API.create_request_param(user,
                [method: "rtm.tasks.delete", timeline: timeline, list_id: task.list_id,
                 taskseries_id: task.id, task_id: chunk.id])
    Exrtm.API.Tasks.Base.handle_single_item(user, request)
  end
end
