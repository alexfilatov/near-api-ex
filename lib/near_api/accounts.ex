defmodule NearApi.Accounts do
  @moduledoc """
  NEAR RPC - Accounts API
  """
  import NearApi.Utils, only: [api_call: 1, api_call_experimental: 2]

  @doc """
  Returns basic account information
  """
  @spec view_account(account_id :: String.t(), block_id :: String.t()) ::
          {:ok, body :: map}
          | {:error, error_message: error_message :: String.t(), response: response :: map}
  def view_account(account_id, block_id \\ nil) do
    payload = payload_view_account("view_account", account_id, block_id)
    api_call(payload)
  end

  defp payload_view_account(request_type, account_id, nil) do
    %{request_type: request_type, finality: "final", account_id: account_id}
  end

  defp payload_view_account(request_type, account_id, block_id) do
    %{request_type: request_type, block_id: block_id, account_id: account_id}
  end

  @doc """
  Returns account changes from transactions in a given account.
  Warning: Experimental
  """
  @spec account_changes(account_ids :: [String.t()], block_id :: String.t()) ::
          {:ok, body :: map}
          | {:error, error_message: error_message :: String.t(), response: response :: map}
  def account_changes(account_ids, block_id \\ nil) do
    payload = payload_account_changes("account_changes", account_ids, block_id)
    api_call_experimental(payload, "EXPERIMENTAL_changes")
  end

  defp payload_account_changes(changes_type, account_ids, nil) do
    %{changes_type: changes_type, account_ids: account_ids, finality: "final"}
  end

  defp payload_account_changes(changes_type, account_ids, block_id) do
    %{changes_type: changes_type, account_ids: account_ids, block_id: block_id}
  end
end
