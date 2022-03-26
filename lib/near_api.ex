defmodule NearApi do
  @moduledoc """
  NEAR RPC API
  """

  # AccessKeys
  defdelegate view_access_key(account_id, block_id \\ nil, public_key \\ nil),
    to: NearApi.RPC.AccessKeys

  defdelegate view_access_key_list(account_id, block_id \\ nil, public_key \\ nil),
    to: NearApi.RPC.AccessKeys

  # Accounts
  defdelegate view_account(account_id, block_id \\ nil), to: NearApi.RPC.Accounts
  defdelegate account_changes(account_id, block_id \\ nil), to: NearApi.RPC.Accounts

  # Contracts
  defdelegate view_code(account_id, block_id \\ nil), to: NearApi.RPC.Contracts
  defdelegate view_state(account_id, block_id \\ nil, prefix_base64 \\ nil), to: NearApi.RPC.Contracts

  defdelegate data_changes(account_ids, block_id \\ nil, key_prefix_base64 \\ nil),
    to: NearApi.RPC.Contracts

  defdelegate contract_code_changes(account_ids, block_id \\ nil), to: NearApi.RPC.Contracts

  defdelegate call_function(account_id, method_name, args_base64, block_id \\ nil),
    to: NearApi.RPC.Contracts

  # Block
  defdelegate block(block_id \\ nil, finality \\ "final"), to: NearApi.RPC.Block
  defdelegate changes_in_block_experimental(block_id \\ nil, finality \\ "final"), to: NearApi.RPC.Block

  # Chunk
  defdelegate chunk(chunk_id \\ nil, block_id \\ nil, shard_id \\ nil), to: NearApi.RPC.Chunk

  # Gas
  defdelegate gas_price(block_id \\ nil), to: NearApi.RPC.Gas

  # Network
  defdelegate status(), to: NearApi.RPC.Network
  defdelegate network_info(), to: NearApi.RPC.Network
  defdelegate validators(block_id \\ nil), to: NearApi.RPC.Network

  # Protocol
  defdelegate genesis_config(), to: NearApi.RPC.Protocol
  defdelegate protocol_config(block_id \\ nil), to: NearApi.RPC.Protocol

  # Transactions
  defdelegate send_transaction_async(tx), to: NearApi.RPC.Transactions
  defdelegate send_transaction_commit(tx), to: NearApi.RPC.Transactions
end
