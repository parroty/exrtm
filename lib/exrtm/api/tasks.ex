alias Exrtm.Util.Xml.XmlNode
alias Exrtm.Record.Task
alias Exrtm.Record.Chunk

defmodule Exrtm.API.Tasks do
  defmodule Base do
    @moduledoc """
    Provides basic processing for task API.
    """

    @doc """
    Handle requests which involves single item like add and delete operations.
    """
    def process_single_item(user, request) do
      response = Exrtm.API.do_request(user, request)
      list = XmlNode.from_string(response)
               |> XmlNode.first("//list")

      tasks = parse_task(list)
      count = Enum.count(tasks)
      if count > 1 do raise ExrtmError.new(message: "expected single task, but #{count} tasks returned.") end
      Enum.first(tasks)
    end

    @doc """
    Handle requests which involves multiple items like getList operations.
    """
    def process_multiple_items(user, request) do
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
        tags:         element |> XmlNode.first("tags") |> parse_tags,
        participants: element |> XmlNode.first("participants") |> XmlNode.text,
        url:          element |> XmlNode.attr("url"),
        created:      element |> XmlNode.attr("created"),
        source:       element |> XmlNode.attr("source"),
        rrule:        element |> XmlNode.first("rrule") |> XmlNode.text,
        list_id:      list_id,
        chunks:       chunks
      )
    end

    defp parse_tags(element) do
      tags = element |> XmlNode.all("//tag")
      Enum.join(Enum.map(tags, fn(tag) -> tag |> XmlNode.text end), ",")
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

  defmodule Operations do
    @moduledoc """
    Provides basic processing for a certain task operation
    """

    def invoke(user, task, method, options // []) do
      if task == nil do raise ExrtmError.new(message: "specified task is invalid.") end

      timeline = Exrtm.Timeline.create(user)
      tasks = Enum.map(task.chunks, fn(chunk) -> do_invoke(user, task, chunk, timeline, method, options) end)
      Enum.first(tasks)
    end

    defp do_invoke(user, task, chunk, timeline, method, options) do
      request = Exrtm.API.create_request_param(user,
                  [method: method, timeline: timeline, list_id: task.list_id,
                   taskseries_id: task.id, task_id: chunk.id])
      Exrtm.API.Tasks.Base.process_single_item(user, request ++ options)
    end
  end

  defmodule GetList do
    def invoke(user) do
      request  = Exrtm.API.create_request_param(user, [method: "rtm.tasks.getList"])
      Exrtm.API.Tasks.Base.process_multiple_items(user, request)
    end
  end

  defmodule Add do
    def invoke(user, name) do
      timeline = Exrtm.Timeline.create(user)
      request  = Exrtm.API.create_request_param(user, [method: "rtm.tasks.add", name: name, timeline: timeline])
      Exrtm.API.Tasks.Base.process_single_item(user, request)
    end
  end

  defmodule Delete do
    def invoke(user, task) do
      Exrtm.API.Tasks.Operations.invoke(user, task, "rtm.tasks.delete")
    end
  end

  defmodule Complete do
    def invoke(user, task) do
      Exrtm.API.Tasks.Operations.invoke(user, task, "rtm.tasks.complete")
    end
  end

  defmodule Uncomplete do
    def invoke(user, task) do
      Exrtm.API.Tasks.Operations.invoke(user, task, "rtm.tasks.uncomplete")
    end
  end

  defmodule AddTags do
    def invoke(user, task, tags) do
      Exrtm.API.Tasks.Operations.invoke(user, task, "rtm.tasks.addTags", [tags: tags])
    end
  end

  defmodule RemoveTags do
    def invoke(user, task, tags) do
      Exrtm.API.Tasks.Operations.invoke(user, task, "rtm.tasks.removeTags", [tags: tags])
    end
  end

  defmodule SetPriority do
    def invoke(user, task, priority) do
      Exrtm.API.Tasks.Operations.invoke(user, task, "rtm.tasks.setPriority", [priority: priority])
    end
  end

  defmodule SetName do
    def invoke(user, task, name) do
      Exrtm.API.Tasks.Operations.invoke(user, task, "rtm.tasks.setName", [name: name])
    end
  end
end