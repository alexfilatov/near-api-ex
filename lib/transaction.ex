defmodule NearApi.Transaction do
  @moduledoc """
  Create NEAR [transactions](https://docs.near.org/docs/tutorials/create-transactions) here
  """
  require Logger

  @type t :: %__MODULE__{
          signer_id: String.t(),
          receiver_id: String.t(),
          nonce: integer,
          public_key: NearApi.PublicKey.t(),
          block_hash: binary,
          actions: [NearApi.Action.t()]
        }

  use Borsh,
    schema: [
      signer_id: :string,
      public_key: :borsh,
      nonce: :u64,
      receiver_id: :string,
      block_hash: [32],
      actions: [:borsh]
    ],
    enum_map: NearApi.Action.enum_map()

  @typedoc """
  Transaction struct
  """

  defstruct [
    :signer_id,
    :public_key,
    :nonce,
    :receiver_id,
    :block_hash,
    :actions
  ]

  def sign_and_serialise(tx, key_pair) do
    serialised_tx = borsh_encode(tx)
    serialized_tx_hash = :crypto.hash(:sha256, serialised_tx)
    signature = NearApi.KeyPair.signature(serialized_tx_hash, key_pair)

    st = %NearApi.SignedTransaction{transaction: tx, signature: %NearApi.Signature{key_type: 0, data: signature}}
    NearApi.SignedTransaction.borsh_encode(st)
  end

  def payload(tx, key_pair) do
    sign_and_serialise(tx, key_pair) |> Base.encode64(padding: false)
  end
end
