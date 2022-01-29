defmodule NearApi.Actions.CreateAccount do
  @moduledoc """
  Transaction Actions

  CreateAccount
  """
  @type t :: %__MODULE__{action_code: integer}

  use Borsh,
    schema: [
      action_code: :u8
    ]

  defstruct action_code: 0
end
