alias Exrtm.Util.Xml.XmlNode

defmodule Exrtm.Task do
  @moduledoc """
  Provides 'task' related functionalities.
  """

  @doc """
  Returns all the registered tasks.
  """
  def get_list(user) do
    Exrtm.API.Tasks.GetList.invoke(user)
  end

  @doc """
  Returns a task that maches the specified name.
  """
  def get_by_name(user, name) do
    tasks = get_list(user)
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
