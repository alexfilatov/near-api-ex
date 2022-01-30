defmodule NearApi.Wallet.RequestSignin do
  @moduledoc """
  Request Signin struct
  """

  @type t :: %__MODULE__{
          contract_id: String.t(),
          methond_names: [String.t()],
          success_url: String.t(),
          failure_url: String.t()
        }

  defstruct [:contract_id, :methond_names, :success_url, :failure_url]

  @doc """
  Wallet sign in URL builder
  Params are:
    `contract_id` - address of the wallet where smart contract in deployed
    `method_names` - list of all smart contract methods we need to give access
    `success_url` - redirect URL when successful login
    `failure_url` - redirect URL when failed login

  Function returns a tuple with sign in url and a key pair generated for creating smart contract access, e.g.:

    {
      "https://wallet.testnet.near.org/login?contract_id=smart_contract_address.testnet&failure_url=https%3A%2F%2Ffailure_url.com&public_key=336ttyrZRPSKSWESkbRx6fBe3DUEP1MMbJHMQ3Es9Cex&success_url=https%3A%2F%2Fsuccess_url.com",
      %NearApi.KeyPair{
        public_key: %NearApi.PublicKey{
          data: <<public key bitstring here>>,
          key_type: 0
        },
        secret_key: "secret key string here, Base58 encoded"
      }
    }

  Function generates a public key we'll use to create access for the smart contract.
  This puclic key will be returned in the success_url on successful sign in.

  When successful sign in the Wallet redirects back to `success_url` with additional params:
  e.g.:
    if `success_url` == "https://success_url.com"
    then redirect URL will be:
      https://success_url.com/?account_id=wallet_account.testnet&public_key=PUBLIC_KEY_32&all_keys=ED25519_ACCESS_KEY

  """
  @spec build_url(params :: map, net :: atom | String.t()) :: {url :: String.t(), key_pair :: NearApi.KeyPair.t()}
  def build_url(params, :mainnet), do: do_build(params, "https://wallet.near.org")
  def build_url(params, :testnet), do: do_build(params, "https://wallet.testnet.near.org")
  def build_url(params, wallet_base_url), do: do_build(params, wallet_base_url)

  defp do_build(
         %{contract_id: contract_id, method_names: method_names, success_url: success_url, failure_url: failure_url},
         wallet_base_url
       ) do
    key_pair = NearApi.KeyPair.from_random()
    public_key = B58.encode58(key_pair.public_key.data)

    query =
      %{
        success_url: success_url,
        failure_url: failure_url,
        contract_id: contract_id,
        public_key: public_key
      }
      |> URI.encode_query()
      |> append_method_names(method_names)

    url = [wallet_base_url, "/login?", query] |> Enum.join("")
    {url, key_pair}
  end

  defp do_build(%{contract_id: _, success_url: _, failure_url: _} = params, wallet_base_url) do
    Map.put(params, :method_names, []) |> do_build(wallet_base_url)
  end

  defp append_method_names(query, []), do: query

  defp append_method_names(query, [name | rest]) do
    append_method_names("#{query}&method_name[]=#{URI.encode(name)}", rest)
  end
end
