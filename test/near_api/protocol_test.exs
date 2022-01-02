defmodule NearApi.ProtocolTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  alias NearApi.Protocol, as: API

  setup do
    System.put_env("NEAR_NODE_URL", "https://rpc.testnet.near.org")
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes/protocol")
    :ok
  end

  describe ".genesis_config" do
    test "success: block_height" do
      use_cassette "genesis_config/success" do
        {:ok, body} = API.genesis_config()
        assert body["id"] == "dontcare"
        assert body["jsonrpc"] == "2.0"
        assert body["result"]["genesis_time"]
        assert body["result"]["genesis_height"]
        refute body["result"]["error"]
      end
    end
  end

  describe ".protocol_config" do
    test "success: finality" do
      use_cassette "protocol_config/success_finality" do
        {:ok, body} = API.protocol_config()
        assert body["id"] == "dontcare"
        assert body["jsonrpc"] == "2.0"
        assert body["result"]["genesis_time"]
        assert body["result"]["genesis_height"]
        assert body["result"]["chain_id"]
        refute body["result"]["error"]
      end
    end

    test "success: block_id" do
      use_cassette "protocol_config/success_block" do
        block_id = "F4xEAQHe1fUwDzyha759UTr1WF8ozVukZdioVAb9yWGa"
        {:ok, body} = API.protocol_config(block_id)
        assert body["id"] == "dontcare"
        assert body["jsonrpc"] == "2.0"
        assert body["result"]["genesis_time"]
        assert body["result"]["genesis_height"]
        refute body["result"]["error"]
      end
    end
  end
end
