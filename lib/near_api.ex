defmodule NearApi do
  @moduledoc """
  NEAR RPC API
  """

  @doc """
  Returns information about a single access key for given account from NEAR blockchain

  ## Examples

    iex> System.put_env("NEAR_PUBLIC_KEY", "ed25519:H9k5eiU4xXS3M4z8HzKJSLaZdqGdGwBG49o7orNC4eZW")
    iex> System.put_env("NEAR_NODE_URL", "https://rpc.testnet.near.org")
    iex> NearApi.view_access_key("client.chainlink.testnet")["id"]
    "dontcare"
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

  defp public_key do
    System.get_env("NEAR_PUBLIC_KEY")
  end
end
