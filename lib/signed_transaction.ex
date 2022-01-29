defmodule NearApi.SignedTransaction do
  @moduledoc """
  NEAR transaction signature struct
  Borsh enabled
  """
  require Logger

  @type t :: %__MODULE__{
          transaction: binary,
          signature: binary
        }

  defstruct [
    :transaction,
    :signature
  ]

  use Borsh,
    schema: [
      transaction: :borsh,
      signature: :borsh
    ]
end
