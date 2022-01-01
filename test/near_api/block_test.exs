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
      use_cassette "block/success" do
        {:ok, body} = API.block()
        assert body["id"] == "dontcare"
        assert body["jsonrpc"] == "2.0"
        refute body["result"]["error"]
        assert body["result"]["author"]
        assert body["result"]["header"]
        assert body["result"]["chunks"]
      end
    end

    test "success: block with block_id" do
      use_cassette "block/success_block_id" do
        block_id = "DnhS8YtJQkJ9jT2nCmLNa7R38neWKmUfK6BqgBmBo3Y7"
        {:ok, body} = API.block(block_id)
        assert body["result"]["header"]["hash"] == block_id
        refute body["result"]["error"]
      end
    end

    test "error: block with with wrong block_id" do
      use_cassette "block/error" do
        block_id = "8H9Bop1P4LtZMr4Xkne5CQHcnmiJFWzF77F4v3kMtYw1"
        {:error, error} = API.block(block_id)
        assert error.error_cause == "UNKNOWN_BLOCK"
        assert String.match?(error.error_description, ~r/DB Not Found Error/)
      end
    end
  end

  describe ".changes_in_block_experimental" do
    test "success: changes_in_block_experimental with finality: final" do
      use_cassette "changes_in_block_experimental/success" do
        {:ok, body} = API.changes_in_block()
        assert body["id"] == "dontcare"
        assert body["jsonrpc"] == "2.0"
        assert body["result"]["block_hash"]
        assert is_list(body["result"]["changes"])
        refute body["result"]["error"]
      end
    end

    test "success: changes_in_block_experimental with block_id" do
      use_cassette "changes_in_block_experimental/success_block_id" do
        block_id = "125iE9QcZjL4n34pZP8MoByevgaziz93oYV2a6W6pJUX"
        {:ok, body} = API.changes_in_block(block_id)
        assert body["result"]["block_hash"] == block_id
        refute body["result"]["error"]
      end
    end
  end
end
