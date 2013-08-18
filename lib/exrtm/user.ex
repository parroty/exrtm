defmodule Exrtm.User do
  @moduledoc """
  An module to store the user authentication information
  """

  use ExActor, export: :singleton   # The actor process will be locally registered

  defcall get, state: state, do: state
  defcast set(x), do: new_state(x)
end
