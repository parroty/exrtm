defmodule Exrtm.API.Methods do
  @moduledoc """
  Provides basic processing for general API call interface.
  """

  def invoke(user, params) do
    request = Exrtm.API.create_request_param(user, params)
    Exrtm.API.do_request(user, request)
  end
end