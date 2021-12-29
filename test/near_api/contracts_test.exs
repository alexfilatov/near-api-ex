defmodule NearApi.ContractsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  alias NearApi.Contracts, as: API

  setup do
    System.put_env("NEAR_PUBLIC_KEY", "ed25519:H9k5eiU4xXS3M4z8HzKJSLaZdqGdGwBG49o7orNC4eZW")
    System.put_env("NEAR_NODE_URL", "https://rpc.testnet.near.org")
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes/contracts")

    :ok
  end

  describe ".view_code" do
    test "success: view_code with finality: final" do
      use_cassette "view_code_success" do
        {:ok, body} = API.view_code("client.chainlink.testnet")
        assert body["id"] == "dontcare"
        assert body["jsonrpc"] == "2.0"

        assert body["result"]["code_base64"]
        assert body["result"]["code_base64"] |> Base.decode64!() |> is_bitstring()

        assert body["result"]["hash"]
        assert body["result"]["block_height"]
        assert body["result"]["block_hash"]
        refute body["result"]["error"]
      end
    end

    test "success: view_code with block_id" do
      block_id = "8H9Bop1P4LtZMr4Xkne5CQHcnmiJFWzF77F4v3kMtYwT"
      {:ok, body} = API.view_code("client.chainlink.testnet", block_id)
      assert body["result"]["block_hash"] == block_id
      refute body["result"]["error"]
    end

    test "error: view_code with with wrong block_id" do
      block_id = "8H9Bop1P4LtZMr4Xkne5CQHcnmiJFWzF77F4v3kMtYw1"
      use_cassette "view_code_error" do
        {:error, error} = API.view_code("client.chainlink.testnet", block_id)
        assert String.match?(error.error_description, ~r/DB Not Found Error/)
      end
    end
  end
end
