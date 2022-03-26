defmodule NearApi.ContractTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Mock
  alias NearApi.Contract, as: API

  def access_key_response do
    {:ok,
     %{
       "id" => "dontcare",
       "jsonrpc" => "2.0",
       "result" => %{
         "block_hash" => "EQsSwfsfkRcvD5pnt6H7vFLM2tfiP8pnXf52q8JZho11",
         "block_height" => 85_945_252,
         "nonce" => 85_945_162_000_000,
         "permission" => %{
           "FunctionCall" => %{
             "allowance" => "250000000000000000000000",
             "method_names" => [],
             "receiver_id" => "nft_test10.mintbot.testnet"
           }
         }
       }
     }}
  end

  setup do
    auth = %{
      account_id: "yellowpie.testnet",
      public_key: "ed25519:EgQang5jVZga1FJFydNjkVFh7EN4btRHujRgJYzHkjbT",
      secret_key: "ed25519:9A7Np1hMKbBqroDpu2wWGQiFuiedsxg8uAGvx43pvyXo"
    }

    System.put_env("NEAR_NODE_URL", "https://rpc.testnet.near.org")
    ExVCR.Config.cassette_library_dir("test/fixture/vcr_cassettes/near_api/contract")
    key_pair = NearApi.KeyPair.key_pair(auth.public_key, auth.secret_key)
    caller_account = NearApi.Account.build_account(auth.account_id, key_pair)
    {:ok, caller_account: caller_account}
  end

  describe ".call" do
    test "success: makes a FunctionCall transaction", %{caller_account: caller_account} do
      with_mock NearApi.RPC.AccessKeys, view_access_key: fn _, _, _ -> access_key_response() end do
        use_cassette "call/success" do
          params = %{
            token_id: "very_long_and_unique_token_id",
            receiver_id: caller_account.account_id,
            metadata: %{
              title: "NFT for #{caller_account.account_id}",
              description: "NFT for #{caller_account.account_id} by Mintbot",
              media: "https://ipfs.io/ipfs/bafkreibwqtadnc2sp4dsl2kzd4jzal4dvyj5mlzs2ajsg6dmxlkuv5a65e",
              copies: 1
            }
          }

          {:ok, result} = API.call(caller_account, "nft_test10.mintbot.testnet", "nft_mint", params)

          assert result["id"] == "dontcare"
          assert result["result"]["receipts_outcome"]
          assert result["result"]["status"]["SuccessValue"]
          assert result["result"]["transaction_outcome"]
        end
      end
    end
  end
end
