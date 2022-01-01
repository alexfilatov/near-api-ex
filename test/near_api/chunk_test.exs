defmodule NearApi.ChunkTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  alias NearApi.Chunk, as: API

  setup do
    System.put_env("NEAR_NODE_URL", "https://rpc.testnet.near.org")
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes/chunk")
    :ok
  end

  describe ".chunk" do
    test "success: when block_id (hash) and shard_id" do
      use_cassette "chunk/success_block_hash_shard" do
        {:ok, body} = API.chunk(nil, "D5XjP8e59MSGpaaQzDP7wBiD5BrfeaS9ZHsp6DW9Cre", 3)
        assert body["id"] == "dontcare"
        assert body["jsonrpc"] == "2.0"
        assert body["result"]["author"]
        assert body["result"]["header"]
        assert is_list(body["result"]["receipts"])
        refute body["result"]["error"]
      end
    end

    test "success: when chunk_id (chunk_hash)" do
      use_cassette "chunk/success_chunk_hash" do
        chunk_hash = "B8WmAS9bAnAzcVyMhp2NMXWPxSyfZPefujQTwUDP89f6"
        {:ok, body} = API.chunk(chunk_hash)
        assert body["id"] == "dontcare"
        assert body["jsonrpc"] == "2.0"
        assert body["result"]["author"]
        assert body["result"]["header"]["chunk_hash"] == chunk_hash
        assert is_list(body["result"]["receipts"])
        refute body["result"]["error"]
      end
    end

    test "error: chunk with with wrong block_id" do
      use_cassette "chunk/error_unknown_chunk" do
        chunk_id = "8H9Bop1P4LtZMr4Xkne5CQHcnmiJFWzF77F4v3kMtYw1"
        {:error, error} = API.chunk(chunk_id)
        assert error.error_cause == "UNKNOWN_CHUNK"
        assert String.match?(error.error_description, ~r/Chunk Missing/)
      end
    end
  end
end
