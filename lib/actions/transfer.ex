defmodule NearApi.Actions.Transfer do
  @moduledoc """
  Transaction Actions

  Transfer
  """
  @type t :: %__MODULE__{deposit: integer, action_code: integer}

  use Borsh,
    schema: [
      action_code: :u8,
      deposit: :u128
    ]

  defstruct [:deposit, action_code: 3]
end
