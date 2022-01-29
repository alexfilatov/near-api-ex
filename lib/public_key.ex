defmodule NearApi.PublicKey do
  @moduledoc """
  NEAR [Action](https://www.near-sdk.io/zero-to-hero/beginner/actions).
  """
  alias __MODULE__

  @ed25519_curve 0

  use Borsh,
    schema: [
      key_type: :u8,
      data: [32]
    ]

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

  def from_string(encoded_key) do
    encoded_key |> String.split(":") |> compose_key()
  end

  defp compose_key([curve, key]), do: compose_key([key])
  defp compose_key([key]), do: %__MODULE__{key_type: @ed25519_curve, data: B58.decode58!(key)}
end
