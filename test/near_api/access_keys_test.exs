defmodule NearApi.AccessKeysTest do
  use ExUnit.Case
  alias NearApi.AccessKeys, as: API

  setup do
    System.put_env("NEAR_PUBLIC_KEY", "ed25519:H9k5eiU4xXS3M4z8HzKJSLaZdqGdGwBG49o7orNC4eZW")
    System.put_env("NEAR_NODE_URL", "https://rpc.testnet.near.org")
  end

  describe ".view_access_key" do
    test "success: returns access key of an account" do
      {:ok, body} = API.view_access_key("client.chainlink.testnet")
      assert body["id"] == "dontcare"
      assert body["jsonrpc"] == "2.0"
      assert body["result"]["block_hash"]
      assert body["result"]["block_height"]
      assert body["result"]["nonce"]
      assert body["result"]["permission"]
      refute body["result"]["error"]
    end

    test "error: returns access key of an account" do
      {:error, response: response, error_message: error_message} =
        API.view_access_key("client.chainlink22.testnet")

      assert response["id"] == "dontcare"
      assert response["result"]["error"]
    end

    test "error: parse error" do
      {:error, error} = API.view_access_key("client.chainlink__.testnet")

      assert error.error_code == -32700
      assert error.error_message == "Parse error"
      assert error.error_description
      assert error.error_name == "REQUEST_VALIDATION_ERROR"
    end
  end
end
