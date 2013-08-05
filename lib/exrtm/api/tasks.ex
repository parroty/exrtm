alias Exrtm.Util.Xml.XmlNode

defmodule Exrtm.API.Tasks.Base do
  def do_invoke(user, request) do
    response = Exrtm.API.do_request(user, request)
    parse_one_list_result(response)
  end

  defp parse_one_list_result(response) do
    doc = XmlNode.from_string(response)
    doc |> XmlNode.first("//list")
        |> Exrtm.Task.parse_list
        |> Enum.first
  end
end

defmodule Exrtm.API.Tasks.GetList do
  def invoke(user) do
    request  = Exrtm.API.create_request_param(user, [method: "rtm.tasks.getList"])
    response = Exrtm.API.do_request(user, request)
    parse_result(response)
  end

  def parse_result(response) do
    doc = XmlNode.from_string(response)
    doc |> XmlNode.first("//tasks")
        |> XmlNode.all("//list")
  end
end

defmodule Exrtm.API.Tasks.Add do
  def invoke(user, name) do
    timeline = Exrtm.Timeline.create(user)
    request  = Exrtm.API.create_request_param(user, [method: "rtm.tasks.add", name: name, timeline: timeline])
    Exrtm.API.Tasks.Base.do_invoke(user, request)
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
    Exrtm.API.Tasks.Base.do_invoke(user, request)
  end
end
