defmodule NearApi.AccessKeysTest do
  use ExUnit.Case
  alias NearApi.AccessKeys, as: API

  setup do
    System.put_env("NEAR_PUBLIC_KEY", "ed25519:H9k5eiU4xXS3M4z8HzKJSLaZdqGdGwBG49o7orNC4eZW")
    System.put_env("NEAR_NODE_URL", "https://rpc.testnet.near.org")
  end

  describe ".view_access_key" do
    test "success: returns access key of an account, finality is final" do
      {:ok, body} = API.view_access_key("client.chainlink.testnet")
      assert body["id"] == "dontcare"
      assert body["jsonrpc"] == "2.0"
      assert body["result"]["block_hash"]
      assert body["result"]["block_height"]
      assert body["result"]["nonce"]
      assert body["result"]["permission"]
      refute body["result"]["error"]
    end

    test "success: returns access key of an account for given block_id" do
      block_id = "AseZCt1TxexkYcBX6hwH9KyK9pzGRYzwautpQbbqwLB5"
      {:ok, body} = API.view_access_key("client.chainlink.testnet", block_id)
      assert body["id"] == "dontcare"
      assert body["jsonrpc"] == "2.0"
      assert body["result"]["block_hash"] == block_id
      refute body["result"]["error"]
    end

    test "error: returns access key of an account" do
      {:error, response: response, error_message: _error_message} =
        API.view_access_key("client.chainlink22.testnet")

      assert response["id"] == "dontcare"
      assert response["result"]["error"]
    end

    test "error: use wrong access key" do
      access_key = "ed25519:H9k5eiU4xXS3M4z8HzKJSLaZdqGdGwBG49o7orNC4eZ1"

      {:error, response: response, error_message: _error_message} =
        API.view_access_key("client.chainlink.testnet", nil, access_key)

      assert response["id"] == "dontcare"

      assert response["result"]["error"] ==
               "access key #{access_key} does not exist while viewing"
    end

    test "error: parse error" do
      {:error, error} = API.view_access_key("client.chainlink__.testnet")

      assert error.error_code == -32700
      assert error.error_message == "Parse error"
      assert error.error_description
      assert error.error_name == "REQUEST_VALIDATION_ERROR"
    end
  end

  describe ".view_access_key_list" do
    test "success: returns all access keys for a given account, finality: final" do
      {:ok, body} = API.view_access_key_list("client.chainlink.testnet")
      assert body["id"] == "dontcare"
      assert body["jsonrpc"] == "2.0"
      assert is_list(body["result"]["keys"])

      a_key = List.first(body["result"]["keys"])
      assert Map.has_key?(a_key, "public_key")
      assert Map.has_key?(a_key, "access_key")

      access_key = a_key["access_key"]
      assert Map.has_key?(access_key, "nonce")
      assert Map.has_key?(access_key, "permission")

      refute body["result"]["error"]
    end

    test "success: returns all access keys for a given account for given block_id" do
      block_id = "AseZCt1TxexkYcBX6hwH9KyK9pzGRYzwautpQbbqwLB5"
      {:ok, body} = API.view_access_key_list("client.chainlink.testnet", block_id)
      assert body["id"] == "dontcare"
      assert body["jsonrpc"] == "2.0"
      assert body["result"]["block_hash"] == block_id
      refute body["result"]["error"]
    end

    test "error: given wrong block_id" do
      block_id = "AseZCt1TxexkYcBX6hwH9KyK9pzGRYzwautpQbbqwLB1"
      {:error, error} = API.view_access_key_list("client.chainlink.testnet", block_id)
      assert error.error_code == -32000
      assert error.error_message == "Server error"
      assert String.match?(error.error_description, ~r/DB Not Found Error/)
      assert error.error_name == "HANDLER_ERROR"
    end
  end
end
