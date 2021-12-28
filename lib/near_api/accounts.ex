defmodule NearApi.Accounts do
  @moduledoc """
  NEAR RPC - Accounts API
  """
  import NearApi.Utils, only: [api_call: 1]

  @doc """
  Returns basic account information
  """
  @spec view_account(
          account_id :: String.t(),
          block_id :: String.t()
        ) ::
          {:ok, body :: map}
          | {:error, error_message: error_message :: String.t(), response: response :: map}
  def view_account(account_id, block_id \\ nil) do
    payload = combine_payload("view_account", account_id, block_id)

    api_call(payload)
  end

  defp combine_payload(request_type, account_id, nil) do
    %{
      request_type: request_type,
      finality: "final",
      account_id: account_id
    }
  end

  defp combine_payload(request_type, account_id, block_id) do
    %{
      request_type: request_type,
      block_id: block_id,
      account_id: account_id
    }
  end
end
