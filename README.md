# NearApi [![Build Status](https://github.com/alexfilatov/near_api/workflows/CI/badge.svg?branch=main)](https://github.com/alexfilatov/near_api/actions?query=workflow%3ACI) [![Hex pm](https://img.shields.io/hexpm/v/near_api.svg?style=flat)](https://hex.pm/packages/near_api) [![hex.pm downloads](https://img.shields.io/hexpm/dt/near_api.svg?style=flat)](https://hex.pm/packages/near_api)

Elixir library for DApps development on the NEAR blockchain platform

*Currently in active development, so not recommended to use in
production*

-   [Installation](#installation)
-   [Usage](#usage)
    -   [Access Keys (In Progress)](#access-keys-in-progress)
    -   [Accounts / Contracts
        (Backlog)](#accounts-contracts-backlog)
    -   [Block / Chunk (Backlog)](#block-chunk-backlog)
    -   [Gas (Backlog)](#gas-backlog)
    -   [Protocol (Backlog)](#protocol-backlog)
    -   [Network (Backlog)](#network-backlog)
    -   [Transactions (Backlog)](#transactions-backlog)
    -   [Sandbox (Backlog)](#sandbox-backlog)
    
## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be
installed by adding `near_api` to your list of dependencies in
`mix.exs`:

``` elixir
def deps do
  [
    {:near_api, "~> 0.1.0"}
  ]
end
```

## Usage

### Access Keys (In Progress)

<a target="_blank" href="https://docs.near.org/docs/api/rpc/access-keys">NEAR API Docs: Access Keys</a>

Retrieve information about an account's access keys.

### Accounts / Contracts (Backlog)

<a target="_blank" href="https://docs.near.org/docs/api/rpc/contracts">NEAR API Docs: Accounts / Contracts</a>

View details about accounts and contracts as well as perform contract
calls.

### Block / Chunk (Backlog)

<a target="_blank" href="https://docs.near.org/docs/api/rpc/block-chunk">NEAR API Docs: Block / Chunk</a>

Query the network and get details about specific blocks or chunks.

### Gas (Backlog)

<a target="_blank" href="https://docs.near.org/docs/api/rpc/gas">NEAR API Docs: Gas</a>

Get gas price for a specific block or hash.

### Protocol (Backlog)

<a target="_blank" href="https://docs.near.org/docs/api/rpc/protocol">NEAR API Docs: Protocol</a>

Retrieve current genesis and protocol configuration.

### Network (Backlog)

<a target="_blank" href="https://docs.near.org/docs/api/rpc/network">NEAR API Docs: Network</a>

Return status information for nodes and validators.

### Transactions (Backlog)

<a target="_blank" href="https://docs.near.org/docs/api/rpc/transactions">NEAR API Docs: Transactions</a>

Send transactions and query their status.

### Sandbox (Backlog)

<a target="_blank" href="https://docs.near.org/docs/api/rpc/sandbox">NEAR API Docs: Sandbox</a>

Patch state on a local sandbox node.

--- 
Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc) and published on [HexDocs](https://hexdocs.pm). Once published, the docs can be found at <https://hexdocs.pm/near_api>.
