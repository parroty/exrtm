defmodule Exrtm do
  def init_api(key, secret, token // nil) do
    Exrtm.API.init_api(key, secret, token)
  end

  def get_auth_url(user, permission, frob) do
    Exrtm.API.get_auth_url(user, permission, frob)
  end

  def get_frob(user) do
    Exrtm.API.Auth.GetFrob.invoke(user)
  end

  def get_token(user, frob) do
    Exrtm.API.Auth.GetToken.invoke(user, frob)
  end
end
