# NearApi 
[![Build Status](https://github.com/alexfilatov/near_api/workflows/CI/badge.svg?branch=main)](https://github.com/alexfilatov/near_api/actions?query=workflow%3ACI) 
[![Hex pm](https://img.shields.io/hexpm/v/near_api.svg?style=flat)](https://hex.pm/packages/near_api) 
[![hex.pm downloads](https://img.shields.io/hexpm/dt/near_api.svg?style=flat)](https://hex.pm/packages/near_api)
[![Project license](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

Elixir library for DApps development on the NEAR blockchain platform

*Currently in active development, so not recommended to use in
production*

-   [Installation](#installation)
-   [Usage](#usage)
    -   [Access Keys](#access-keys)
    -   [Accounts / Contracts](#accounts--contracts)
    -   [Block / Chunk](#block--chunk)
    -   [Gas](#gas)
    -   [Protocol](#protocol)
    -   [Network](#network)
    -   [Transactions (In Progress)](#transactions-in-progress)
    -   [Sandbox (Backlog)](#sandbox-backlog)
    
## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be
installed by adding `near_api` to your list of dependencies in
`mix.exs`:

``` elixir
def deps do
  [
    {:near_api, "~> 0.1.4"}
  ]
end
```

## Usage

We used [Livebook](https://github.com/livebook-dev/livebook) for API documentation.
To see NEAR API in action please clone this repository and [run Livebook locally from your project folder](https://github.com/livebook-dev/livebook#escript) with corresponding `.livemd` file loaded. 

### Access Keys

Retrieve information about an account's access keys.

Near Docs: <a target="_blank" href="https://docs.near.org/docs/api/rpc/access-keys">NEAR API Docs: Access Keys</a>

[Livebook](https://github.com/alexfilatov/near_api/blob/main/notebooks/near_api_access_keys.livemd)

### Accounts / Contracts

View details about accounts and contracts as well as perform contract
calls.

Near Docs: <a target="_blank" href="https://docs.near.org/docs/api/rpc/contracts">NEAR API Docs: Accounts / Contracts</a>

TBD: [Livebook](#)

### Block / Chunk 

Query the network and get details about specific blocks or chunks.

Near Docs: <a target="_blank" href="https://docs.near.org/docs/api/rpc/block-chunk">NEAR API Docs: Block / Chunk</a>

TBD: [Livebook](#)

### Gas  

Get gas price for a specific block or hash.

Near Docs: <a target="_blank" href="https://docs.near.org/docs/api/rpc/gas">NEAR API Docs: Gas</a>

TBD: [Livebook](#)

### Protocol

Retrieve current genesis and protocol configuration.

Near Docs: <a target="_blank" href="https://docs.near.org/docs/api/rpc/protocol">NEAR API Docs: Protocol</a>

TBD: [Livebook](#)

### Network

Return status information for nodes and validators.

Near Docs: <a target="_blank" href="https://docs.near.org/docs/api/rpc/network">NEAR API Docs: Network</a>

TBD: [Livebook](#)

### Transactions (In Progress)

Send transactions and query their status.

Near Docs: <a target="_blank" href="https://docs.near.org/docs/api/rpc/transactions">NEAR API Docs: Transactions</a>

TBD: [Livebook](#)

### Sandbox (Backlog)

Patch state on a local sandbox node.

Near Docs: <a target="_blank" href="https://docs.near.org/docs/api/rpc/sandbox">NEAR API Docs: Sandbox</a>

TBD: [Livebook](#)


## Development

It is recommended to run local sandbox node for faster development and run automated tests.
To install nearcore sandbox locally do the following from the project root:

```shell
cd bin && ./install_sandbox.sh
```

The sandbox will be installed into git-ignored directory `test/sandbox`. 
To run sandbox node, run from the project root directory:

```shell
cd bin && ./run_sandbox.sh
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alexfilatov/near_api.

1. Fork
2. Create Pull request

---

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc) and published on [HexDocs](https://hexdocs.pm). Once published, the docs can be found at <https://hexdocs.pm/near_api>.
