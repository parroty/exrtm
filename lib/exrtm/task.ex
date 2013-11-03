defmodule Exrtm.Task do
  @moduledoc """
  Provides 'task' related functionalities.
  """

  @doc """
  Returns all the registered tasks.
  """
  def get_list(filter // "status:incomplete") do
    Exrtm.API.Tasks.GetList.invoke(filter)
  end

  @doc """
  Returns a task that maches the specified name.
  """
  def get_by_name(name) do
    tasks = get_list
    Enum.find(tasks, fn(e) -> e.name == name end)
  end

  @doc """
  Creates a new task with the specified name.
  """
  def add(name) do
    Exrtm.API.Tasks.Add.invoke(name)
  end

  @doc """
  Deletes the specified task.
  """
  def delete(task) do
    Exrtm.API.Tasks.Delete.invoke(task)
  end

  @doc """
  Completes the specified task.
  """
  def complete(task) do
    Exrtm.API.Tasks.Complete.invoke(task)
  end

  @doc """
  Uncompletes the specified task.
  """
  def uncomplete(task) do
    Exrtm.API.Tasks.Uncomplete.invoke(task)
  end

  @doc """
  Add tags to the specified task. 'tags' is comma delimited list of tags.
  """
  def add_tags(task, tags) do
    Exrtm.API.Tasks.AddTags.invoke(task, tags)
  end

  @doc """
  Remove tags from the specified task. 'tags' is comma delimited list of tags.
  """
  def remove_tags(task, tags) do
    Exrtm.API.Tasks.RemoveTags.invoke(task, tags)
  end

  @doc """
  Set priority for the specified task.
  Priority can be '1', '2', '3', and other value is taken as 'no priority'.
  """
  def set_priority(task, priority) do
    Exrtm.API.Tasks.SetPriority.invoke(task, priority)
  end

  @doc """
  Set name for the specified task.
  """
  def set_name(task, name) do
    Exrtm.API.Tasks.SetName.invoke(task, name)
  end

  @doc """
  Postpone the specified task.
  """
  def postpone(task) do
    Exrtm.API.Tasks.Postpone.invoke(task)
  end

  @doc """
  Set URL for the specified task.
  """
  def set_url(task, url) do
    Exrtm.API.Tasks.SetURL.invoke(task, url)
  end

  @doc """
  Set recurrence pattern for the specified task.
  """
  def set_recurrence(task, recurrence) do
    Exrtm.API.Tasks.SetRecurrence.invoke(task, recurrence)
  end

  @doc """
  Move the priority of the specified task.
  direction can be either 'up' or 'down'.
  """
  def move_priority(task, direction) do
    Exrtm.API.Tasks.MovePriority.invoke(task, direction)
  end


  @doc """
  Set due date of the the specified task.
  If due has time along with date, specify '1' for 'has_due_time'.
  If parse date needs to be skipped, specify '0' for 'parse'.
  """
  def set_due_date(task, due, has_due_time // "0", parse // "1") do
    Exrtm.API.Tasks.SetDueDate.invoke(task, due, has_due_time, parse)
  end
end
