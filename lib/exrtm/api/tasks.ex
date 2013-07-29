alias Exrtm.Xml.XmlNode

defmodule Exrtm.API.Tasks.GetList do
  def invoke(user) do
    request  = [method: "rtm.tasks.getList", api_key: user[:key], auth_token: user[:token]]
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
    request  = [method: "rtm.tasks.add", api_key: user[:key], auth_token: user[:token], name: name, timeline: timeline]
    response = Exrtm.API.do_request(user, request)
    parse_result(response)
  end

  # TODO : align with tasks.getList
  def parse_result(response) do
    doc = XmlNode.from_string(response)
    doc |> XmlNode.first("//list")
        |> Exrtm.Task.parse_list
        |> Enum.first
  end
end

defmodule Exrtm.API.Tasks.Delete do
  def invoke(user, task) do
    timeline = Exrtm.Timeline.create(user)
    if task != nil do
      items = Enum.map(task.chunks, fn(c) -> do_invoke(user, task, c, timeline) end)
      Enum.count(items)
    else
      0
    end
  end

  defp do_invoke(user, task, chunk, timeline) do
    request = [method: "rtm.tasks.delete", api_key: user[:key],
               auth_token: user[:token], timeline: timeline,
               list_id: task.list_id, taskseries_id: task.id,
               task_id: chunk.id]
    response = Exrtm.API.do_request(user, request)
    parse_result(response)
  end

  def parse_result(response) do
    doc = XmlNode.from_string(response)
    doc |> XmlNode.first("//list")
        |> Exrtm.Task.parse_list
        |> Enum.first
  end
end
