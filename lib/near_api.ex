defmodule NearApi do
  @moduledoc """
  NEAR RPC API
  """

  # AccessKeys
  defdelegate view_access_key(account_id, block_id \\ nil, public_key \\ nil),
    to: NearApi.AccessKeys

  defdelegate view_access_key_list(account_id, block_id \\ nil, public_key \\ nil),
    to: NearApi.AccessKeys

  # Accounts
  defdelegate view_account(account_id, block_id \\ nil), to: NearApi.Accounts
  defdelegate account_changes(account_id, block_id \\ nil), to: NearApi.Accounts

  # Contracts
  defdelegate view_code(account_id, block_id \\ nil), to: NearApi.Contracts
  defdelegate view_state(account_id, block_id \\ nil, prefix_base64 \\ nil), to: NearApi.Contracts

  defdelegate data_changes(account_ids, block_id \\ nil, key_prefix_base64 \\ nil),
    to: NearApi.Contracts

  defdelegate contract_code_changes(account_ids, block_id \\ nil), to: NearApi.Contracts

  defdelegate call_function(account_id, method_name, args_base64, block_id \\ nil),
    to: NearApi.Contracts

  # Block
  defdelegate block(block_id \\ nil, finality \\ "final"), to: NearApi.Block
  defdelegate changes_in_block(block_id \\ nil, finality \\ "final"), to: NearApi.Block

  # Chunk
  defdelegate chunk(chunk_id \\ nil, block_id \\ nil, shard_id \\ nil), to: NearApi.Chunk

  # Gas
  defdelegate gas_price(block_id \\ nil), to: NearApi.Gas

  # Network
  defdelegate status(), to: NearApi.Network
  defdelegate network_info(), to: NearApi.Network
  defdelegate validators(block_id \\ nil), to: NearApi.Network

  # Protocol
  defdelegate genesis_config(), to: NearApi.Protocol
  defdelegate protocol_config(block_id \\ nil), to: NearApi.Protocol
end
