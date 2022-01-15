defmodule NearApi.AccessKeys do
  @moduledoc """
  NEAR RPC - Access Keys API
  """
  import NearApi.Helpers, only: [public_key: 0, api_call: 1]

  @doc """
  Returns information about a single access key for given account.
  If permission of the key is FunctionCall, it will return more details such as the allowance, receiver_id, and method_names.
  """
  @spec view_access_key(
          account_id :: String.t(),
          block_id :: String.t(),
          public_key :: String.t()
        ) ::
          {:ok, body :: map}
          | {:error, error_message: error_message :: String.t(), response: response :: map}
  def view_access_key(account_id, block_id \\ nil, public_key \\ nil) do
    payload = combine_payload("view_access_key", account_id, block_id, public_key)

    api_call(payload)
  end

  @doc """
  Returns all access keys for a given account
  """
  @spec view_access_key_list(
          account_id :: String.t(),
          block_id :: String.t(),
          public_key :: String.t()
        ) ::
          {:ok, body :: map}
          | {:error, error_message: error_message :: String.t(), response: response :: map}
  def view_access_key_list(account_id, block_id \\ nil, public_key \\ nil) do
    payload = combine_payload("view_access_key_list", account_id, block_id, public_key)

    api_call(payload)
  end

  defp combine_payload(request_type, account_id, nil, public_key) do
    %{
      request_type: request_type,
      finality: "final",
      account_id: account_id,
      public_key: public_key || public_key()
    }
  end

  defp combine_payload(request_type, account_id, block_id, public_key) do
    %{
      request_type: request_type,
      block_id: block_id,
      account_id: account_id,
      public_key: public_key || public_key()
    }
  end
end
