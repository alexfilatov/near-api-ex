defmodule NearApi.RPC.Transactions do
  @moduledoc """
  NEAR RPC - Transactions API
  """
  import NearApi.Helpers, only: [api_call_method: 2]

  @doc """
  Sends a transaction and immediately returns transaction hash.
  tx - Base64 encoded transaction
  """
  @spec send_transaction_commit(tx :: String.t()) :: {:ok, body :: map} | NearApi.RPC.Errors.t()
  def send_transaction_commit(tx), do: api_call_method([tx], "broadcast_tx_commit")

  @doc """
  Sends a transaction and immediately returns transaction hash.
  tx - Base64 encoded transaction
  """
  @spec send_transaction_async(tx :: String.t()) :: {:ok, body :: map} | NearApi.RPC.Errors.t()
  def send_transaction_async(tx), do: api_call_method([tx], "broadcast_tx_async")
end
