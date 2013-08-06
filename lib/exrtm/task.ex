alias Exrtm.Util.Xml.XmlNode
alias Exrtm.Record.Task

defmodule Exrtm.Task do
  @moduledoc """
  Represents the 'taskseries' of RTM API.
  """

  @doc """
  Returns all the registered tasks.
  """
  def find_all(user) do
    lists = Exrtm.API.Tasks.GetList.invoke(user)
    List.flatten(Enum.map(lists, fn(e) -> parse_list(e) end))
  end

  @doc """
  Returns a task that maches the specified name.
  """
  def find(user, name) do
    tasks = find_all(user)
    Enum.find(tasks, fn(e) -> e.name == name end)
  end

  @doc """
  Creates a new task with the specified name.
  """
  def add(user, name) do
    Exrtm.API.Tasks.Add.invoke(user, name)
  end

  @doc """
  Deletes a specified list object.
  """
  def delete(user, task) do
    Exrtm.API.Tasks.Delete.invoke(user, task)
  end

  def parse_list(element) do
    list_id    = element |> XmlNode.attr("id")
    taskseries = element |> XmlNode.all("taskseries")
    Enum.map(taskseries, fn(e) -> parse_taskseries(e, list_id) end)
  end

  def parse_taskseries(element, list_id // nil) do
    chunks = Exrtm.Chunk.parse_chunks(element |> XmlNode.all("task"))

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
end
