defmodule NearApi.Account do
  @moduledoc """
  NearApi Account struct
  Contains account_id, e.g. `hellowworld.testnet`, and KeyPair (with public and secret keys)
  """

  @type t :: %__MODULE__{
          account_id: String.t(),
          key_pair: NearApi.KeyPair.t() | nil
        }

  defstruct [
    :account_id,
    :key_pair
  ]

  @doc """
  Send money from one Near account to another.
  Technically this is a wrapper around `Transfer` transaction
    `from_account` - an account strut NearApi.Account where `account_id` and `key_pair`
      - `key_pair` must be FullAccess key and Transfers only available with this permissions level
    `receiver_id` - string value of the Near account ID, e.g. helloworld.testnet
    `amount` - as String because in Yocto
  """
  @spec send_money(from_account :: NearApi.Account.t(), receiver_id :: String.t(), amount :: String.t()) ::
          {:ok, body :: map} | NearApi.RPC.Errors.t()
  def send_money(from_account, receiver_id, amount) do
    actions = [%NearApi.Actions.Transfer{deposit: amount}]
    {:ok, tx} = NearApi.Transaction.create_transaction(from_account, receiver_id, actions)

    tx
    |> NearApi.Transaction.payload(from_account.key_pair)
    |> NearApi.RPC.Transactions.send_transaction_commit()
  end

  def build_account(account_id, key_pair) do
    %__MODULE__{account_id: account_id, key_pair: key_pair}
  end
end
