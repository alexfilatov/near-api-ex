defmodule NearApi.AccountsTest do
  use ExUnit.Case
  alias NearApi.Accounts, as: API

  setup do
    System.put_env("NEAR_PUBLIC_KEY", "ed25519:H9k5eiU4xXS3M4z8HzKJSLaZdqGdGwBG49o7orNC4eZW")
    System.put_env("NEAR_NODE_URL", "https://rpc.testnet.near.org")
  end

  describe ".view_account" do
    test "success: view_account with finality: final" do
      {:ok, body} = API.view_account("client.chainlink.testnet")
      assert body["id"] == "dontcare"
      assert body["jsonrpc"] == "2.0"
      assert body["result"]["amount"]
      assert body["result"]["locked"]
      assert body["result"]["code_hash"]
      assert body["result"]["storage_usage"]
      assert body["result"]["storage_paid_at"]
      assert body["result"]["block_height"]
      assert body["result"]["block_hash"]
      refute body["result"]["error"]
    end

    test "success: view_account with block_id" do
      block_id = "AseZCt1TxexkYcBX6hwH9KyK9pzGRYzwautpQbbqwLB5"
      {:ok, body} = API.view_account("client.chainlink.testnet", block_id)
      assert body["id"] == "dontcare"
      assert body["jsonrpc"] == "2.0"
      assert body["result"]["block_hash"] == block_id
      refute body["result"]["error"]
    end
  end

  describe ".account_changes (experimental)" do
    test "success: account_changes with finality: final" do
      {:ok, body} = API.account_changes(["client.chainlink.testnet"])
      assert body["id"] == "dontcare"
      assert body["jsonrpc"] == "2.0"
      assert body["result"]["block_hash"]
      assert is_list(body["result"]["changes"])

      refute body["result"]["error"]
    end

    test "success: account_changes with block_id" do
      block_id = "AseZCt1TxexkYcBX6hwH9KyK9pzGRYzwautpQbbqwLB5"
      {:ok, body} = API.view_account("client.chainlink.testnet", block_id)
      assert body["id"] == "dontcare"
      assert body["jsonrpc"] == "2.0"
      assert body["result"]["block_hash"] == block_id
      refute body["result"]["error"]
    end
  end
end
