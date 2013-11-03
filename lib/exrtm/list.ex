defmodule Exrtm.List do
  @moduledoc """
  Provides 'list' related functionalities.
  """

  @doc """
  Returns all the registered lists.
  """
  def get_list do
    Exrtm.API.Lists.GetList.invoke
  end

  @doc """
  Returns a list that maches the specified name.
  """
  def get_by_name(name) do
    lists = get_list
    Enum.find(lists, fn(e) -> e.name == name end)
  end

  @doc """
  Creates a new list with the specified name.
  """
  def add(name) do
    Exrtm.API.Lists.Add.invoke(name)
  end

  @doc """
  Deletes a specified list object.
  """
  def delete(list) do
    Exrtm.API.Lists.Delete.invoke(list)
  end
end
