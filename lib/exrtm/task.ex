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
  Deletes the specified task.
  """
  def delete(user, task) do
    Exrtm.API.Tasks.Delete.invoke(user, task)
  end

  @doc """
  Completes the specified task.
  """
  def complete(user, task) do
    Exrtm.API.Tasks.Complete.invoke(user, task)
  end

  @doc """
  Uncompletes the specified task.
  """
  def uncomplete(user, task) do
    Exrtm.API.Tasks.Uncomplete.invoke(user, task)
  end

  @doc """
  Add tags to the specified task. 'tags' is comma delimited list of tags.
  """
  def add_tags(user, task, tags) do
    Exrtm.API.Tasks.AddTags.invoke(user, task, tags)
  end

  @doc """
  Remove tags from the specified task. 'tags' is comma delimited list of tags.
  """
  def remove_tags(user, task, tags) do
    Exrtm.API.Tasks.RemoveTags.invoke(user, task, tags)
  end

  @doc """
  Set priority for the specified task.
  Priority can be '1', '2', '3', and other value is taken as 'no priority'.
  """
  def set_priority(user, task, priority) do
    Exrtm.API.Tasks.SetPriority.invoke(user, task, priority)
  end

  @doc """
  Set name for the specified task.
  """
  def set_name(user, task, name) do
    Exrtm.API.Tasks.SetName.invoke(user, task, name)
  end
end
