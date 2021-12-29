defmodule NearApi.Contracts do
  @moduledoc """
  NEAR RPC - Contracts API
  """
  import NearApi.Utils, only: [api_call: 1, api_call_experimental: 2]
  import NearApi.Payload

  @doc """
  Returns the contract code (Wasm binary) deployed to the account.
  Please note that the returned code will be encoded in base64.
  """
  @spec view_code(account_id :: String.t(), block_id :: String.t()) ::
          {:ok, body :: map}
          | {:error, error_message: error_message :: String.t(), response: response :: map}
  def view_code(account_id, block_id \\ nil) do
    payload = payload("view_code", account_id, block_id)
    api_call(payload)
  end

  @doc """
  Returns the state (key value pairs) of a contract based on the key prefix (base64 encoded).
  Pass an empty string for `prefix_base64` if you would like to return the entire state.
  Please note that the returned state will be base64 encoded as well.
  """
  @spec view_state(account_id :: String.t(), block_id :: String.t()) ::
          {:ok, body :: map}
          | {:error, error_message: error_message :: String.t(), response: response :: map}
  def view_state(account_id, block_id \\ nil) do
    payload = payload("view_state", account_id, block_id) |> Map.put(:prefix_base64, "")
    api_call(payload)
  end
end
