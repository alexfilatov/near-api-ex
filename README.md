# NearApi 
[![Build Status](https://github.com/alexfilatov/near_api/workflows/CI/badge.svg?branch=main)](https://github.com/alexfilatov/near_api/actions?query=workflow%3ACI)
[![Coverage Status](https://coveralls.io/repos/github/alexfilatov/near_api/badge.svg?branch=main)](https://coveralls.io/github/alexfilatov/near_api?branch=main)
[![Hex pm](https://img.shields.io/hexpm/v/near_api.svg?style=flat)](https://hex.pm/packages/near_api)
[![Hex docs](http://img.shields.io/badge/hex.pm-docs-green.svg)](https://hexdocs.pm/near_api)
[![hex.pm downloads](https://img.shields.io/hexpm/dt/near_api.svg?style=flat)](https://hex.pm/packages/near_api)
[![Project license](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Last Updated](https://img.shields.io/github/last-commit/alexfilatov/near_api.svg)](https://github.com/alexfilatov/near_api/commits/master)

Elixir library for DApps development on the NEAR blockchain platform

## TOC

- [Installation](#installation)
- [Usage](#usage)
   - [Send Tokens](#send-tokens)
   - [Call Smart Contract Function](#call-smart-contract-function)
   - [Login with NEAR](#login-with-near)
   - [NEAR API RPC Functions](#near-api-rpc-functions)
     - [Access Keys](#access-keys)
     - [Accounts / Contracts](#accounts--contracts)
     - [Block / Chunk](#block--chunk)
     - [Gas](#gas)
     - [Protocol](#protocol)
     - [Network](#network)
     - [Transactions](#transactions)
    
## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be
installed by adding `near_api` to your list of dependencies in
`mix.exs`:

``` elixir
def deps do
  [
    {:near_api, "~> 0.1"}
  ]
end
```

### Configuration

```elixir
# config/config.exs

# Optional configuration of the hackney timeout
# Default value for :near_api is 50 seconds (hackney default value is 5 seconds)
# In case we need to timeout earlier we can configure this here.
config :near_api,
  recv_timeout: 50_000,  
  timeout: 50_000  
``` 

## Usage

### Send Tokens

In order to send token from one NEAR wallet to another NEAR wallet you need to have [FullAccess key](https://docs.near.org/docs/videos/accounts-keys#part-2---generating-and-adding-a-key-2fa-and-the-multisig-contract).

`NearApi.Account.send_money/3`

```elixir
# FullAccess key of the sender account:
public_key = "ed25519:BSKK2pFrGhbYQk14TT1hM3QDTXmg9KYSDSQcEzXrg8UV"
secret_key = "ed25519:zet4EX2cnVpjm3WorqY1yivD5ActGvTwt3aTVaehLrf8gnjFRBfFcta4DBxyLSRhj5RETvmWgJswvA7AaKiwb1P"
account_id = "mintbot.testnet"

key_pair = NearApi.KeyPair.key_pair(public_key, secret_key)
sender_account = NearApi.Account.build_account(account_id, key_pair)
receiver_wallet = "yellowpie.testnet"
amount = NearApi.Helpers.Monetary.near_to_yocto(0.5)

{:ok, result} = NearApi.Account.send_money(sender_account, receiver_wallet, amount)
```

📕[NearApi.Account.send_money/3 Livebook](https://github.com/alexfilatov/near_api/blob/main/notebooks/near_api/account.livemd)

### Call Smart Contract Function

This allows you to call a contract not only in a view mode.

`NearApi.Contract.call/4`

```elixir
public_key = "ed25519:iyDKRpjoscGsm4xtWzsh6NcaS4ujm3MLGhDw8EjXDsk"
secret_key = "ed25519:5yPGSe9VgCPvunjkoEgkqiNjnxV6Qjq7HveAi8UjWaiA"
account_id = "mintbot2.testnet"

key_pair = NearApi.KeyPair.key_pair(public_key, secret_key)
caller_account = NearApi.Account.build_account(account_id, key_pair)

params = %{
  token_id: "unique_id",
  receiver_id: caller_account.account_id,
  metadata: %{
    title: "The title of my NFT",
    description: "Really rare picture of the best ape in the world",
    media: "https://ipfs.io/ipfs/bafkreibwqtadnc2sp4dsl2kzd4jzal4dvyj5mlzs2ajsg6dmxlkuv5a65e",
    copies: 1
  }
}

{:ok, result} = NearApi.Contract.call(caller_account, "near_api.mintbot2.testnet", "nft_mint", params)

```

📕[NearApi.Contract.call/4 Livebook](https://github.com/alexfilatov/near_api/blob/main/notebooks/near_api/contract.livemd)


### Login with NEAR

This function generates a link that allows you to login with the NEAR protocol to your website.
The procedure of loggin in with NEAR is about of granting access to your NEAR wallet to NEAR Smart Contract of your website.
Technically, the procedure consists from 3 steps:
1. Generate locally a key pair of public and secret keys
2. Generate a link to NEAR wallet that adds new public key to the list of keys with _limited_ access to the NEAR Wallet
3. Open the NERA Wallet by this link and Grant access by clicking `Confirm` button

The function generates link for the `:mainnet`, `:testnet` and a custom wallet link.

```elixir

params = %{
  contract_id: "nft_test10.mintbot.testnet",
  success_url: "https://www.website.com/near/success.html",
  failure_url: "https://www.website.com/near/failure.html"
}

{url, key_pair} = NearApi.Wallet.RequestSignin.build_url(params, :testnet)

```
Result will be:
```elixir
{"https://wallet.testnet.near.org/login?contract_id=nft_test10.mintbot.testnet&failure_url=https%3A%2F%2Fwww.website.com%2Fnear%2Ffailure.html&public_key=7HPgkkjUj5FDXUF5aD1Xuc5tXcDVL1RA4TyufYuaei3S&success_url=https%3A%2F%2Fwww.website.com%2Fnear%2Fsuccess.html",
 %NearApi.KeyPair{
   public_key: %NearApi.PublicKey{
     data: <<93, 89, 16, 163, 44, 246, 170, 100, 163, 6, 123, 243, 32, 158, 119,
       134, 76, 122, 84, 240, 111, 237, 43, 233, 200, 67, 29, 195, 112, 118,
       251, 105>>,
     key_type: 0
   },
   secret_key: "88yVfF7tS3weyDpRPQZiTj8BzuF3UaPXEgvtduaiN57b"
 }}
```

`url` - the URL you need to pass the user to click

`key_pair` - the KeyPair, that contains the public_key used in the URL and the private_key, both of these you need to persist to sign transactions you're going to run against the user NEAR Wallet


## NEAR API RPC Functions

We used [Livebook](https://github.com/livebook-dev/livebook) for API documentation.
To see NEAR API in action please clone this repository and [run Livebook locally from your project folder](https://github.com/livebook-dev/livebook#escript) with corresponding `.livemd` file loaded. 

### Access Keys

Retrieve information about an account's access keys.

Near Docs: <a target="_blank" href="https://docs.near.org/docs/api/rpc/access-keys">NEAR API Docs: Access Keys</a>

📕[RPC.AccessKeys Livebook](https://github.com/alexfilatov/near_api/blob/main/notebooks/near_api/rpc/access_keys.livemd)

### Accounts / Contracts

View details about accounts and contracts as well as perform contract
calls.

Near Docs: <a target="_blank" href="https://docs.near.org/docs/api/rpc/contracts">NEAR API Docs: Accounts / Contracts</a>

📕[RPC.Accounts Livebook](https://github.com/alexfilatov/near_api/blob/main/notebooks/near_api/rpc/accounts.livemd),
📕[RPC.Contracts Livebook](https://github.com/alexfilatov/near_api/blob/main/notebooks/near_api/rpc/contracts.livemd)

### Block / Chunk 

Query the network and get details about specific blocks or chunks.

Near Docs: <a target="_blank" href="https://docs.near.org/docs/api/rpc/block-chunk">NEAR API Docs: Block / Chunk</a>

📕[RPC.Block Livebook](https://github.com/alexfilatov/near_api/blob/main/notebooks/near_api/rpc/block.livemd),
📕[RPC.Chunk Livebook](https://github.com/alexfilatov/near_api/blob/main/notebooks/near_api/rpc/chunk.livemd)

### Gas  

Get gas price for a specific block or hash.

Near Docs: <a target="_blank" href="https://docs.near.org/docs/api/rpc/gas">NEAR API Docs: Gas</a>

📕[RPC.Gas Livebook](https://github.com/alexfilatov/near_api/blob/main/notebooks/near_api/rpc/gas.livemd)

### Protocol

Retrieve current genesis and protocol configuration.

Near Docs: <a target="_blank" href="https://docs.near.org/docs/api/rpc/protocol">NEAR API Docs: Protocol</a>

📕[RPC.Protocol Livebook](https://github.com/alexfilatov/near_api/blob/main/notebooks/near_api/rpc/protocol.livemd)

### Network

Return status information for nodes and validators.

Near Docs: <a target="_blank" href="https://docs.near.org/docs/api/rpc/network">NEAR API Docs: Network</a>

📕[RPC.Network Livebook](https://github.com/alexfilatov/near_api/blob/main/notebooks/near_api/rpc/network.livemd)

### Transactions

Send transactions and query their status.

Near Docs: <a target="_blank" href="https://docs.near.org/docs/api/rpc/transactions">NEAR API Docs: Transactions</a>

📕[RPC.Transactions Livebook](https://github.com/alexfilatov/near_api/blob/main/notebooks/near_api/rpc/transactions.livemd)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alexfilatov/near_api.

1. Fork
2. Create Pull request

## License

    Copyright © 2021-present Alex Filatov <alex@alexfilatov.com>

    This work is free. You can redistribute it and/or modify it under the
    terms of the MIT License. See the LICENSE file for more details.

---

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc) and published on [HexDocs](https://hexdocs.pm). Once published, the docs can be found at <https://hexdocs.pm/near_api>.
