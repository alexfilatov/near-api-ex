defmodule NearApi.Actions.Stake do
  @moduledoc """
  Transaction Actions

  Stake
  """
  @type t :: %__MODULE__{action_code: integer, stake: integer, public_key: NearApi.PublicKey.t()}

  use Borsh,
    schema: [
      action_code: :u8,
      stake: :u128,
      public_key: :borsh
    ]

  defstruct [:public_key, :stake, action_code: 4]
end
