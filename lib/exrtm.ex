defmodule Exrtm do
  @moduledoc """
  Provides access wrapper for remember the milk API.
  Refer to the following classes to operational functionalities

  - Exrtm.Auth
  - Exrtm.List
  - Exrtm.Task
  - Exrtm.Timeline

  """

  @doc """
  An utility method for displaying record information.
  """
  def puts(data) do
    Binary.Exrtm.puts(data)
  end
end
