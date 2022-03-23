defmodule NearApi.AccountTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Mock
  alias NearApi.Account, as: API

  def access_key_response do
    {:ok,
     %{
       "id" => "dontcare",
       "jsonrpc" => "2.0",
       "result" => %{
         "block_hash" => "DFW5CW9VjCzt8SAWpn4qiA5cABuFRHHNnBqrSYiLKiL",
         "block_height" => 85_743_304,
         "nonce" => 85_460_152_000_019,
         "permission" => "FullAccess"
       }
     }}
  end

  setup do
    public_key = "ed25519:Brrr2pFrGhbY4444TT1hM3QsEXR59KYSDSQcEzwww8UV"
    secret_key = "ed25519:zet4EX2cnVpjm3WorqY1yivD5ActGvTwt3aTVaehLrf8gnjFRBfFcta4DBxyLSRhj5RETvmWgJswvA7A1111111"
    account_id = "mintbot.testnet"

    System.put_env("NEAR_NODE_URL", "https://rpc.testnet.near.org")
    ExVCR.Config.cassette_library_dir("test/fixture/vcr_cassettes/near_api/accounts")
    key_pair = NearApi.KeyPair.key_pair(public_key, secret_key)
    from_account = NearApi.Account.build_account(account_id, key_pair)
    {:ok, from_account: from_account}
  end

  describe ".send_money" do
    test "success: returns details of the transaction", %{from_account: from_account} do
      with_mock NearApi.RPC.AccessKeys, view_access_key: fn _, _, _ -> access_key_response end do
        use_cassette "send_money/success" do
          amount = NearApi.Helpers.Monetary.near_to_yocto(2)
          {:ok, result} = API.send_money(from_account, "yellowpie.testnet", amount)

          assert result["id"] == "dontcare"
          assert result["result"]["receipts_outcome"]
          assert result["result"]["status"]["SuccessValue"]
          assert result["result"]["transaction_outcome"]
        end
      end
    end
  end
end
