defmodule NearApi.Accounts do
  @moduledoc """
  NEAR RPC - Accounts API
  """
  import NearApi.Helpers, only: [api_call: 1, api_call_method: 2]
  import NearApi.Payload

  @doc """
  Returns basic account information
  """
  @spec view_account(account_id :: String.t(), block_id :: String.t()) ::
          {:ok, body :: map}
          | {:error, error_message: error_message :: String.t(), response: response :: map}
  def view_account(account_id, block_id \\ nil) do
    payload = payload("view_account", account_id, block_id)
    api_call(payload)
  end

  @doc """
  Returns account changes from transactions in a given account.
  Warning: Experimental
  """
  @spec account_changes(account_ids :: [String.t()], block_id :: String.t()) ::
          {:ok, body :: map}
          | {:error, error_message: error_message :: String.t(), response: response :: map}
  def account_changes(account_ids, block_id \\ nil) do
    payload = payload_experimental("account_changes", account_ids, block_id)
    api_call_method(payload, "EXPERIMENTAL_changes")
  end
end
