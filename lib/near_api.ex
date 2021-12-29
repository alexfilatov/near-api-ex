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

  defdelegate contract_code_changes(account_ids, block_id \\ nil, key_prefix_base64 \\ nil),
    to: NearApi.Contracts
end
