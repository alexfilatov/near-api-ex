defmodule NearApi.AccessKeys do
  @moduledoc """
  NEAR RPC - Access Keys API
  """
  import NearApi.Utils, only: [public_key: 0]
  alias NearApi.Errors

  @doc """
  Returns information about a single access key for given account from NEAR blockchain
  """
  @spec view_access_key(account_id :: string) ::
          {:ok, body :: map}
          | {:error, error_message: error_message :: string, response: response :: map}
  def view_access_key(account_id) do
    payload = %{
      request_type: "view_access_key",
      finality: "final",
      account_id: account_id,
      public_key: public_key()
    }

    case NearApi.HttpClient.api_call(payload) do
      %{"result" => %{"error" => error_message}} = response ->
        {:error, response: response, error_message: error_message}

      %{"error" => %{"name" => error_name}} = response ->
        Errors.render_error(response)

      body ->
        {:ok, body}
    end
  end
end
