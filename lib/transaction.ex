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
      block_hash: 32,
      actions: [:borsh]
    ]

  @typedoc """
  Transaction struct
  """

  defstruct [
    :signer_id,
    :receiver_id,
    :nonce,
    :public_key,
    :block_hash,
    :actions
  ]
end
