alias Exrtm.Util.Xml.XmlNode

defmodule Exrtm.List do
  @moduledoc """
  Provides 'list' related functionalities.
  """

  @doc """
  Returns all the registered lists.
  """
  def get_list(user) do
    Exrtm.API.Lists.GetList.invoke(user)
  end

  @doc """
  Returns a list that maches the specified name.
  """
  def get_by_name(user, name) do
    lists = get_list(user)
    Enum.find(lists, fn(e) -> e.name == name end)
  end

  @doc """
  Creates a new list with the specified name.
  """
  def add(user, name) do
    Exrtm.API.Lists.Add.invoke(user, name)
  end

  @doc """
  Deletes a specified list object.
  """
  def delete(user, list) do
    Exrtm.API.Lists.Delete.invoke(user, list)
  end
end
