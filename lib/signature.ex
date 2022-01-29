defmodule NearApi.Signature do
  @moduledoc """
  NEAR transaction signature struct
  Borsh enabled
  """
  require Logger

  @type t :: %__MODULE__{
          key_type: integer,
          data: binary
        }

  use Borsh,
    schema: [
      key_type: :u8,
      data: [64]
    ]

  defstruct [
    :key_type,
    :data
  ]
end
