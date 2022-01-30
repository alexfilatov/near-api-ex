defmodule NearApi.Wallet.RequestSigninTest do
  use ExUnit.Case
  alias NearApi.Wallet.RequestSignin, as: Subject

  describe ".build_url" do
    test "success: builds url and key_pair" do
      params = %{
        contract_id: "contract.testnet",
        method_names: ["add", "delete"],
        success_url: "https://success_url.com",
        failure_url: "https://failure_url.com"
      }

      {url, key_pair} = Subject.build_url(params, :mainnet)
      uri = URI.parse(url)

      # TODO: these should go to their own test:
      assert %NearApi.KeyPair{public_key: pk, secret_key: sk} = key_pair
      assert %NearApi.PublicKey{data: data, key_type: kt} = pk
      assert is_bitstring(data)
      assert kt == 0

      assert uri.host == "wallet.near.org"
      assert uri.path == "/login"
      assert uri.query

      decoded_query = URI.decode_query(uri.query)

      assert decoded_query["contract_id"] == "contract.testnet"
      assert decoded_query["success_url"] == "https://success_url.com"
      assert decoded_query["failure_url"] == "https://failure_url.com"
      assert decoded_query["methodNames[]"] == "delete" # URI cannot parse arrays from URL
      assert String.match?(uri.query, ~r/methodNames\[\]=add&methodNames\[\]=delete/)
    end

    test "success: builds url without method_names and key_pair" do
      params = %{
        contract_id: "contract.testnet",
        success_url: "https://success_url.com",
        failure_url: "https://failure_url.com"
      }

      {url, key_pair} = Subject.build_url(params, :testnet)
      uri = URI.parse(url)

      assert uri.host == "wallet.testnet.near.org"

      decoded_query = URI.decode_query(uri.query)

      assert decoded_query["contract_id"] == "contract.testnet"
      assert decoded_query["success_url"] == "https://success_url.com"
      assert decoded_query["failure_url"] == "https://failure_url.com"
      refute decoded_query["methodNames[]"]
      refute String.match?(uri.query, ~r/methodNames/)
    end

    test "success: custom wallet_base_url" do
      params = %{
        contract_id: "contract.testnet",
        success_url: "https://success_url.com",
        failure_url: "https://failure_url.com"
      }

      {url, key_pair} = Subject.build_url(params, "https://localhost:12345")
      uri = URI.parse(url)

      assert uri.host == "localhost"
    end
  end
end
