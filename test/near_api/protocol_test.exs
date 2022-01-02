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
end
