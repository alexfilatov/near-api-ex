defmodule NearApi.AccessKeys do
  @moduledoc """
  NEAR RPC - Access Keys API
  """
  import NearApi.Utils, only: [public_key: 0]
  alias NearApi.Errors

  @doc """
  Returns information about a single access key for given account from NEAR blockchain
  """
  @spec view_access_key(account_id :: String.t()) ::
          {:ok, body :: map}
          | {:error, error_message: error_message :: String.t(), response: response :: map}
  def view_access_key(account_id) do
    payload = %{
      request_type: "view_access_key",
      finality: "final",
      account_id: account_id,
      public_key: public_key()
    }

    api_call(payload)
  end

  @spec view_access_key_list(account_id :: String.t()) ::
          {:ok, body :: map}
          | {:error, error_message: error_message :: String.t(), response: response :: map}
  def view_access_key_list(account_id) do
    payload = %{
      request_type: "view_access_key_list",
      finality: "final",
      account_id: account_id,
      public_key: public_key()
    }

    api_call(payload)
  end

  defp api_call(payload) do
    case NearApi.HttpClient.api_call(payload) do
      %{"result" => %{"error" => error_message}} = response ->
        {:error, response: response, error_message: error_message}

      %{"error" => _error} = response ->
        Errors.render_error(response)

      body ->
        {:ok, body}
    end
  end
end
