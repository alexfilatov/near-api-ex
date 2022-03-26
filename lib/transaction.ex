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
    ]

  defstruct [
    :signer_id,
    :public_key,
    :nonce,
    :receiver_id,
    :block_hash,
    :actions
  ]

  @doc """
  Creates a NearApi.Transaction struct, not serialized
  Parameters:
    `from_account` - an account strut NearApi.Account where `account_id` and `key_pair`
    `receiver_id` - NEAR account ID who we are sending tokens, e.g. `helloworld.near`
    `actions` - a list of transaction actions, e.g. NearApi.Actions.FunctionCall or NearApi.Actions.Transfer
  """
  @spec create_transaction(from_account :: NearApi.Account.t(), receiver_id :: String.t(), actions :: list) ::
          {:ok, NearApi.Transaction.t()} | {:error, :error_retrieving_access_key}
  def create_transaction(from_account, receiver_id, actions) do
    public_key = from_account.key_pair.public_key
    public_key_encoded = B58.encode58(from_account.key_pair.public_key.data)
    account_id = from_account.account_id

    with {:ok, key} <- NearApi.RPC.AccessKeys.view_access_key(account_id, nil, public_key_encoded) do
      block_hash_raw = key["result"]["block_hash"]
      nonce = key["result"]["nonce"] + 1

      block_hash = B58.decode58!(block_hash_raw)

      {:ok,
       %NearApi.Transaction{
         signer_id: account_id,
         receiver_id: receiver_id,
         nonce: nonce,
         public_key: public_key,
         block_hash: block_hash,
         actions: actions
       }}
    else
      error ->
        Logger.error("#{__MODULE__}: Cannot retrieve access key: #{inspect(error)}")
        {:error, :error_retrieving_access_key}
    end
  end

  def sign_and_serialise(tx, key_pair) do
    serialised_tx = borsh_encode(tx)
    serialized_tx_hash = :crypto.hash(:sha256, serialised_tx)
    signature = NearApi.KeyPair.signature(serialized_tx_hash, key_pair)

    st = %NearApi.SignedTransaction{transaction: tx, signature: %NearApi.Signature{key_type: 0, data: signature}}
    NearApi.SignedTransaction.borsh_encode(st)
  end

  def payload(tx, key_pair) do
    tx
    |> sign_and_serialise(key_pair)
    |> Base.encode64(padding: false)
  end
end
