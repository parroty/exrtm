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
  Field length can be specified as options, and its default is 32.
  """
  def puts(data, options // [length: 32]) do
    Binary.Exrtm.puts(data, options)
  end
end
