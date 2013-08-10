defmodule Exrtm.Auth do
  @moduledoc """
  Provides initial setup and authentication related functionalities.
  """

  @doc """
  Setup key/secret parameters for accessing the API.
  if token is not available yet, use 'get\\_auth\\_url' and 'get_frob' methods to get the token.
  The acquired token can be reused later, by skipping frob authentication.
  """
  def init_api(key, secret, token // nil) do
    Exrtm.API.init_api(key, secret, token)
  end

  @doc """
  Get one-time frob for authentication.
  """
  def get_frob(user) do
    Exrtm.API.Auth.GetFrob.invoke(user)
  end

  @doc """
  Get an url to authenticate the specified frob.
  """
  def get_auth_url(user, permission, frob) do
    Exrtm.API.get_auth_url(user, permission, frob)
  end

  @doc """
  Get token using the authenticated frob.
  """
  def get_token(user, frob) do
    Exrtm.API.Auth.GetToken.invoke(user, frob)
  end
end