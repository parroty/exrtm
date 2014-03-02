defmodule Exrtm.User do
  @moduledoc """
  An module to store the user authentication information
  """
  use ExActor.GenServer, export: :singleton   # The actor process will be locally registered

  defcall get, state: state, do: reply(state)
  defcast set(x), do: new_state(x)
end
