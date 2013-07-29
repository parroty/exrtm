defmodule Exrtm.Timeline do
  def create(user) do
    user |> Exrtm.API.Timelines.Create.invoke()
  end
end
