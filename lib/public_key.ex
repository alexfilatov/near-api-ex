defmodule NearApi.PublicKey do
  @moduledoc """
  NEAR [Action](https://www.near-sdk.io/zero-to-hero/beginner/actions).
  """
  alias __MODULE__

  use Borsh,
    schema: %{
      key_type: :u8,
      data: :string
    }

  @typedoc """
  Type of the public key struct
  """
  @type t :: %__MODULE__{
          key_type: integer,
          data: String.t()
        }

  defstruct [
    :key_type,
    :data
  ]
end
