defmodule Exrtm.Timeline do
  @moduledoc """
  Represents the 'timeline' of RTM API.
  """

  @doc """
  Creates a new timeline.
  """
  def create(user) do
    user |> Exrtm.API.Timelines.Create.invoke()
  end
end
