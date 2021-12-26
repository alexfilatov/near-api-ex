defmodule NearApi do
  @moduledoc """
  NEAR RPC API
  """

  defdelegate view_access_key(account_id), to: NearApi.AccessKeys

  defdelegate view_access_key_list(account_id), to: NearApi.AccessKeys
end
