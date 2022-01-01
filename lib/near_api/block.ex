defmodule NearApi.Block do
  @moduledoc """
  NEAR RPC - Block API
  """
  import NearApi.Utils, only: [api_call: 1, api_call_experimental: 2]
  import NearApi.Payload

  @doc """
  Returns the contract code (Wasm binary) deployed to the account.
  Please note that the returned code will be encoded in base64.
  """
  @spec block(block_id :: String.t()) :: {:ok, body :: map} | NearApi.Errors.t()
  def block(block_id \\ nil) do
    payload = payload(nil, nil, block_id)
    api_call(payload)
  end
end
