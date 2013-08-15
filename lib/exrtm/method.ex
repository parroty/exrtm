defmodule Exrtm.Method do
  @moduledoc """
  Provides general API call interface.
  """

  @doc """
  Call the API with the specified parameter and returns the XML response.
  """
  def call(user, params) do
    Exrtm.API.Methods.invoke(user, params)
  end
end
