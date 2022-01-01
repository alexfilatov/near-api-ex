defmodule NearApi.BlockTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  alias NearApi.Block, as: API

  setup do
    System.put_env("NEAR_NODE_URL", "https://rpc.testnet.near.org")
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes/block")
    :ok
  end

  describe ".block" do
    test "success: block with finality: final" do
#      use_cassette "block/success" do
        {:ok, body} = API.view_code("client.chainlink.testnet")
        assert body["id"] == "dontcare"
        assert body["jsonrpc"] == "2.0"

        assert body["result"]["code_base64"] |> Base.decode64!() |> is_bitstring()

        assert body["result"]["hash"]
        assert body["result"]["block_height"]
        assert body["result"]["block_hash"]
        refute body["result"]["error"]
#      end
    end

    test "success: block with block_id" do
      use_cassette "block/success_block_id" do
        block_id = "8H9Bop1P4LtZMr4Xkne5CQHcnmiJFWzF77F4v3kMtYwT"
        {:ok, body} = API.view_code("client.chainlink.testnet", block_id)
        assert body["result"]["block_hash"] == block_id
        refute body["result"]["error"]
      end
    end

    test "error: block with with wrong block_id" do
      use_cassette "block/error" do
        block_id = "8H9Bop1P4LtZMr4Xkne5CQHcnmiJFWzF77F4v3kMtYw1"
        {:error, error} = API.view_code("client.chainlink.testnet", block_id)
        assert error.error_cause == "UNKNOWN_BLOCK"
        assert String.match?(error.error_description, ~r/DB Not Found Error/)
      end
    end
  end

  describe ".changes_in_block_experimental" do
    test "success: changes_in_block_experimental with finality: final" do
      use_cassette "changes_in_block_experimental/success" do
        {:ok, body} = API.view_state("yellowpie.testnet")
        assert body["id"] == "dontcare"
        assert body["jsonrpc"] == "2.0"
        assert body["result"]["block_height"]
        assert body["result"]["block_hash"]
        assert is_list(body["result"]["proof"])
        assert is_list(body["result"]["values"])
        refute body["result"]["error"]
      end
    end

    test "success: changes_in_block_experimental with block_id" do
      use_cassette "changes_in_block_experimental/success_block_id" do
        block_id = "F4xEAQHe1fUwDzyha759UTr1WF8ozVukZdioVAb9yWGa"
        {:ok, body} = API.view_state("yellowpie.testnet", block_id)
        assert body["result"]["block_hash"] == block_id
        refute body["result"]["error"]
      end
    end

    test "error: changes_in_block_experimental state is too large" do
      use_cassette "changes_in_block_experimental/error_too_large" do
        {:error, error} = API.view_state("client.chainlink.testnet")
        assert error.error_cause == "TOO_LARGE_CONTRACT_STATE"
        assert error.error_code == -32000

        assert error.error_description ==
                 "State of contract client.chainlink.testnet is too large to be viewed"

        assert error.error_message == "Server error"
        assert error.error_type == "HANDLER_ERROR"
      end
    end
  end
end
