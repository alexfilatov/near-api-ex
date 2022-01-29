defmodule NearApi.KeyPair do
  @moduledoc """
  Key pair functionality for Ed25519 curve: generating key pairs, encoding key pairs, signing and verifying.
  """
  alias __MODULE__

  @typedoc """
  Type of the key pair struct
  """
  @type t :: %__MODULE__{
          public_key: String.t(),
          secret_key: String.t()
        }

  defstruct [
    :public_key,
    :secret_key
  ]

  @doc """
  Create Key Pair from public and secret keys
  """
  def key_pair(public_key, secret_key) do
    secret_key
    |> from_string()
    |> Map.put(:public_key, NearApi.PublicKey.from_string(public_key))
  end

  @doc """
  Create Key Pair from a B58 encoded secret key
  """
  def from_string(encoded_secret_key) do
    encoded_secret_key |> String.split(":") |> compose_key_pair()
  end

  defp compose_key_pair([curve, encoded_secret_key]), do: compose_key_pair([encoded_secret_key])

  defp compose_key_pair([encoded_secret_key]) do
    <<seed::binary-size(32), _::binary>> = B58.decode58!(encoded_secret_key)
    {_, derived_public_key} = Ed25519.generate_key_pair(seed)

    %__MODULE__{
      public_key: NearApi.PublicKey.from_string(B58.encode58(derived_public_key)),
      secret_key: encoded_secret_key
    }
  end

  @doc """
  Sign a message with a secret key
  Secret key must be
  """
  def signature(msg, %__MODULE__{secret_key: encoded_secret_key}) do
    <<seed::binary-size(32), _::binary>> = B58.decode58!(encoded_secret_key)

    Ed25519.signature(msg, seed)
  end
end
