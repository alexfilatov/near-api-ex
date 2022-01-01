defmodule NearApi.GasTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  alias NearApi.Gas, as: API

  setup do
    System.put_env("NEAR_NODE_URL", "https://rpc.testnet.near.org")
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes/gas")
    :ok
  end

  describe ".gas_price" do
    test "success: block_height" do
      use_cassette "gas_price/success_block_height" do
        block_height = 77_289_947
        {:ok, body} = API.gas_price(block_height)
        assert body["id"] == "dontcare"
        assert body["jsonrpc"] == "2.0"
        assert body["result"]["gas_price"]
        refute body["result"]["error"]
      end
    end

    test "success: when block_hash" do
      use_cassette "gas_price/success_block_hash" do
        block_id = "D5XjP8e59MSGpaaQzDP7wBiD5BrfeaS9ZHsp6DW9Cre"
        {:ok, body} = API.gas_price(block_id)
        assert body["id"] == "dontcare"
        assert body["jsonrpc"] == "2.0"
        assert body["result"]["gas_price"]
        refute body["result"]["error"]
      end
    end

    test "success: gas_price with null" do
      use_cassette "gas_price/success_null" do
        {:ok, body} = API.gas_price()
        assert body["id"] == "dontcare"
        assert body["jsonrpc"] == "2.0"
        assert body["result"]["gas_price"]
        refute body["result"]["error"]
      end
    end
  end
end
