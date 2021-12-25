defmodule NearApi.AccessKeys do
  @moduledoc """
  NEAR RPC - Access Keys API
  """
  import NearApi.Utils, only: [public_key: 0]

  @doc """
  Returns information about a single access key for given account from NEAR blockchain
  """
  def view_access_key(account_id) do
    payload = %{
      request_type: "view_access_key",
      finality: "final",
      account_id: account_id,
      public_key: public_key()
    }

    NearApi.HttpClient.api_call(payload)
  end
end
