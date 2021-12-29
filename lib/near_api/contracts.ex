defmodule NearApi.Contracts do
  @moduledoc """
  NEAR RPC - Contracts API
  """
  import NearApi.Utils, only: [api_call: 1, api_call_experimental: 2]

  @doc """
  Returns the contract code (Wasm binary) deployed to the account.
  Please note that the returned code will be encoded in base64.
  """
  @spec view_code(account_id :: String.t(), block_id :: String.t()) ::
          {:ok, body :: map}
          | {:error, error_message: error_message :: String.t(), response: response :: map}
  def view_code(account_id, block_id \\ nil) do
    payload = payload_view_code("view_code", account_id, block_id)
    api_call(payload)
  end

  defp payload_view_code(request_type, account_id, nil) do
    %{request_type: request_type, finality: "final", account_id: account_id}
  end

  defp payload_view_code(request_type, account_id, block_id) do
    %{request_type: request_type, block_id: block_id, account_id: account_id}
  end
end
