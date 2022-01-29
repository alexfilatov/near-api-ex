defmodule NearApi.Actions.DeleteKey do
  @moduledoc """
  Transaction Actions

  DeleteKey
  """
  @type t :: %__MODULE__{action_code: integer, public_key: NearApi.PublicKey.t()}

  use Borsh,
    schema: [
      action_code: :u8,
      public_key: :borsh
    ]

  defstruct [:public_key, action_code: 6]
end
