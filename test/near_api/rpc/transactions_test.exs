defmodule NearApi.RPC.TransactionsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  alias NearApi.RPC.Transactions, as: API

  setup do
    System.put_env("NEAR_NODE_URL", "http://127.0.0.1:50055")
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes/transactions")

    auth = %{
      account_id: "mintbot.test.near",
      public_key: "ed25519:FNvKCD97TFRt8JUTRdJCS96bURY5yXbeqoJGbCbm1hSc",
      secret_key: "ed25519:3PJpbMt1mm38EFQXLu4dNdcVVgCn5cNqhALf13a4MCwvvu2YF23TospudPmCfPd4ADC4o7gm1w6M6wd6LVqEZSFn"
    }

    sender_id = auth.account_id
    receiver_id = "hello.mintbot.test.near"

    # hardcoded access_key API response:
    key = %{
      "id" => "dontcare",
      "jsonrpc" => "2.0",
      "result" => %{
        "block_hash" => "AUmuuRGPnMjMgcRcMreCgNqhWGnSvfkYyHRCsCvgbFYX",
        "block_height" => 6281,
        "nonce" => 460_000_003,
        "permission" => "FullAccess"
      }
    }

    block_hash_raw = key["result"]["block_hash"]
    nonce = key["result"]["nonce"] + 1

    block_hash = B58.decode58!(block_hash_raw)

    transfer = %NearApi.Actions.Transfer{deposit: 500_000_000_000_000_000_000}
    NearApi.Actions.FunctionCall
    key_pair = NearApi.KeyPair.from_string(auth.secret_key)

    public_key = key_pair.public_key

    tx = %NearApi.Transaction{
      signer_id: sender_id,
      receiver_id: receiver_id,
      nonce: nonce,
      public_key: public_key,
      block_hash: block_hash,
      actions: [transfer]
    }

    payload = NearApi.Transaction.payload(tx, key_pair)

    {:ok, transaction_payload: payload}
  end

  describe ".send_transaction_async" do
    test "success: block_height", %{transaction_payload: transaction_payload} do
      use_cassette "send_transaction_async/success" do
        {:ok, body} = API.send_transaction_async(transaction_payload)
        assert body["id"] == "dontcare"
        assert body["jsonrpc"] == "2.0"
        assert String.length(body["result"]) == 44
      end
    end
  end

  describe ".send_transaction_await" do
    test "success: block_height", %{transaction_payload: transaction_payload} do
      use_cassette "send_transaction_commit/success" do
        {:ok, body} = API.send_transaction_commit(transaction_payload)
        assert body["id"] == "dontcare"
        assert body["jsonrpc"] == "2.0"
        refute body["result"]["error"]
      end
    end
  end
end
