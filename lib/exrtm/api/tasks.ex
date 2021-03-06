alias Exrtm.Util.Xml.XmlNode
alias Exrtm.Record.Task

defmodule Exrtm.API.Tasks do
  @moduledoc """
  Provides basic processing for task API.
  """

  defmodule Base do
    @doc """
    Handle requests which involves single item like add and delete operations.
    """
    def process_single_item(user, request) do
      response = Exrtm.API.do_request(user, request)
      list = XmlNode.from_string(response)
               |> XmlNode.first("//list")

      tasks = parse_list(list)
      count = Enum.count(tasks)
      if count > 1 do raise %ExrtmError{message: "expected single task, but #{count} tasks returned."} end
      Enum.at(tasks, 0)
    end

    @doc """
    Handle requests which involves multiple items like getList operations.
    """
    def process_multiple_items(user, request) do
      response = Exrtm.API.do_request(user, request)
      list = XmlNode.from_string(response)
               |> XmlNode.first("//tasks")
               |> XmlNode.all("//list")

      List.flatten(Enum.map(list, fn(e) -> parse_list(e) end))
    end

    defp parse_list(element) do
      list_id    = element |> XmlNode.attr("id")
      taskseries = element |> XmlNode.all("taskseries")
      List.flatten(Enum.map(taskseries, fn(e) -> parse_taskseries(e, list_id) end))
    end

    defp parse_taskseries(element, list_id) do
      tasks = parse_tasks(element |> XmlNode.all("task"))
      Enum.map(tasks, fn(task) ->
        %{task |
          series_id:     element |> XmlNode.attr("id"),
          name:          element |> XmlNode.attr("name"),
          modified:      element |> XmlNode.attr("modified"),
          tags:          element |> XmlNode.first("tags") |> parse_tags,
          participants:  element |> XmlNode.first("participants") |> XmlNode.text,
          url:           element |> XmlNode.attr("url"),
          created:       element |> XmlNode.attr("created"),
          source:        element |> XmlNode.attr("source"),
          rrule:         element |> XmlNode.first("rrule") |> XmlNode.text,
          list_id:       list_id
        }
      end)
    end

    defp parse_tags(element) do
      tags = element |> XmlNode.all("//tag")
      Enum.join(Enum.map(tags, fn(tag) -> tag |> XmlNode.text end), ",")
    end

    defp parse_tasks(elements) do
      Enum.map(elements, fn(e) -> parse_task(e) end)
    end

    defp parse_task(element) do
      %Task{
        id:           element |> XmlNode.attr("id"),
        completed:    element |> XmlNode.attr("completed"),
        added:        element |> XmlNode.attr("added"),
        priority:     element |> XmlNode.attr("priority"),
        deleted:      element |> XmlNode.attr("deleted"),
        has_due_time: element |> XmlNode.attr("has_due_time"),
        estimate:     element |> XmlNode.attr("estimate"),
        due:          element |> XmlNode.attr("due"),
        postponed:    element |> XmlNode.attr("postponed")
      }
    end
  end

  defmodule Operations do
    @moduledoc """
    Provides basic processing for a certain task operation
    """

    def invoke(task, method, options \\ []) do
      if task == nil do raise %ExrtmError{message: "specified task is invalid."} end

      user = Exrtm.User.get
      timeline = Exrtm.Timeline.create()
      request  = Exrtm.API.create_request_param(user,
                  [method: method, timeline: timeline, list_id: task.list_id,
                   taskseries_id: task.series_id, task_id: task.id])
      Exrtm.API.Tasks.Base.process_single_item(user, request ++ options)
    end
  end

  defmodule GetList do
    def invoke(filter) do
      params = [method: "rtm.tasks.getList"]
      if filter != "" do params = params ++ [filter: filter] end

      user = Exrtm.User.get
      request = Exrtm.API.create_request_param(user, params)
      Exrtm.API.Tasks.Base.process_multiple_items(user, request)
    end
  end

  defmodule Add do
    def invoke(name) do
      user = Exrtm.User.get
      timeline = Exrtm.Timeline.create
      request  = Exrtm.API.create_request_param(user, [method: "rtm.tasks.add", name: name, timeline: timeline])
      Exrtm.API.Tasks.Base.process_single_item(user, request)
    end
  end

  defmodule Delete do
    def invoke(task) do
      Exrtm.API.Tasks.Operations.invoke(task, "rtm.tasks.delete")
    end
  end

  defmodule Complete do
    def invoke(task) do
      Exrtm.API.Tasks.Operations.invoke(task, "rtm.tasks.complete")
    end
  end

  defmodule Uncomplete do
    def invoke(task) do
      Exrtm.API.Tasks.Operations.invoke(task, "rtm.tasks.uncomplete")
    end
  end

  defmodule AddTags do
    def invoke(task, tags) do
      Exrtm.API.Tasks.Operations.invoke(task, "rtm.tasks.addTags", [tags: tags])
    end
  end

  defmodule RemoveTags do
    def invoke(task, tags) do
      Exrtm.API.Tasks.Operations.invoke(task, "rtm.tasks.removeTags", [tags: tags])
    end
  end

  defmodule SetPriority do
    def invoke(task, priority) do
      Exrtm.API.Tasks.Operations.invoke(task, "rtm.tasks.setPriority", [priority: priority])
    end
  end

  defmodule SetName do
    def invoke(task, name) do
      Exrtm.API.Tasks.Operations.invoke(task, "rtm.tasks.setName", [name: name])
    end
  end

  defmodule Postpone do
    def invoke(task) do
      Exrtm.API.Tasks.Operations.invoke(task, "rtm.tasks.postpone")
    end
  end

  defmodule SetURL do
    def invoke(task, url) do
      Exrtm.API.Tasks.Operations.invoke(task, "rtm.tasks.setURL", [url: url])
    end
  end

  defmodule SetRecurrence do
    def invoke(task, recurrence) do
      Exrtm.API.Tasks.Operations.invoke(task, "rtm.tasks.setRecurrence", [repeat: recurrence])
    end
  end

  defmodule MovePriority do
    def invoke(task, direction) do
      Exrtm.API.Tasks.Operations.invoke(task, "rtm.tasks.movePriority", [direction: direction])
    end
  end

  defmodule SetDueDate do
    def invoke(task, due, has_due_time, parse) do
      Exrtm.API.Tasks.Operations.invoke(task, "rtm.tasks.setDueDate",
                                        [due: due, has_due_time: has_due_time, parse: parse])
    end
  end
end