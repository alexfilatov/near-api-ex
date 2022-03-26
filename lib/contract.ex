defmodule NearApi.Contract do
  @moduledoc """
  NearApi Contract struct
  Contains account, contract_id, and params for the contract call
  """

  @type t :: %__MODULE__{
          account: NearApi.Account.t(),
          contract_id: String.t(),
          params: map()
        }

  @gas 300_000_000_000_000

  defstruct [
    :account,
    :contract_id,
    :params
  ]

  @doc """
  Function to call a NEAR Contract method.
    `account` - an account strut NearApi.Account where `account_id` and `key_pair`
      - `key_pair` should contain public_key
    `contract_id` - string value of the Near Contract ID, e.g. `nft.mintbot.near`
    `method` - string value of the contract method, e.g. `mint_nft`
    `args` - arguments for the `method` of the contract
  """
  @spec call(caller_account :: NearApi.Account.t(), contract_id :: String.t(), method :: String.t(), params :: map) ::
          {:ok, body :: map} | NearApi.RPC.Errors.t()
  def call(caller_account, contract_id, method, args) do
    args_encoded = Jason.encode!(args)

    action = %NearApi.Actions.FunctionCall{
      method_name: method,
      args: args_encoded,
      gas: @gas,
      amount: 0
    }

    {:ok, tx} = NearApi.Transaction.create_transaction(caller_account, contract_id, [action])


    tx
    |> NearApi.Transaction.payload(caller_account.key_pair)
    |> NearApi.RPC.Transactions.send_transaction_commit()
  end
end
