alias Exrtm.Util.Xml.XmlNode

defmodule Exrtm.Task do
  @moduledoc """
  Represents the 'taskseries' of RTM API.
  """

  @doc """
  Returns all the registered tasks.
  """
  def find_all(user) do
    Exrtm.API.Tasks.GetList.invoke(user)
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
end
