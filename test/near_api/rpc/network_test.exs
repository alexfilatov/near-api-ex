defmodule NearApi.RPC.NetworkTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  alias NearApi.RPC.Network, as: API

  setup do
    System.put_env("NEAR_NODE_URL", "https://rpc.testnet.near.org")
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes/network")
    :ok
  end

  describe ".status" do
    test "success" do
      use_cassette "status/success" do
        {:ok, body} = API.status()
        assert body["id"] == "dontcare"
        assert body["jsonrpc"] == "2.0"
        assert body["result"]["chain_id"] == "testnet"
        assert body["result"]["version"]["version"]
        assert body["result"]["version"]["build"]
        assert is_list(body["result"]["validators"])
        refute body["result"]["error"]
      end
    end
  end

  describe ".network_info" do
    test "success" do
      use_cassette "network_info/success" do
        {:ok, body} = API.network_info()
        assert body["id"] == "dontcare"
        assert body["jsonrpc"] == "2.0"
        assert is_list(body["result"]["active_peers"])
        assert is_list(body["result"]["known_producers"])
        assert body["result"]["peer_max_count"]
        refute body["result"]["error"]
      end
    end
  end

  describe ".validators" do
    test "success" do
      use_cassette "validators/success" do
        {:ok, body} = API.validators()
        assert body["id"] == "dontcare"
        assert body["jsonrpc"] == "2.0"
        assert is_list(body["result"]["current_validators"])
        refute body["result"]["error"]
      end
    end
  end
end
