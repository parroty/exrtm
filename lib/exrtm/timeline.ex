defmodule Exrtm.Timeline do
  @moduledoc """
  Represents the 'timeline' of RTM API.
  """

  @doc """
  Creates a new timeline.
  """
  def create do
    Exrtm.API.Timelines.Create.invoke
  end
end
