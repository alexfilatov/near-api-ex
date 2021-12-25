defmodule NearApi.AccessKeysTest do
  use ExUnit.Case
  alias NearApi.AccessKeys, as: API

  setup do
    System.put_env("NEAR_PUBLIC_KEY", "ed25519:H9k5eiU4xXS3M4z8HzKJSLaZdqGdGwBG49o7orNC4eZW")
    System.put_env("NEAR_NODE_URL", "https://rpc.testnet.near.org")
  end

  describe ".view_access_key" do
    test "returns access key of an account" do
      assert API.view_access_key("client.chainlink.testnet")["id"] == "dontcare"
    end
  end
end
