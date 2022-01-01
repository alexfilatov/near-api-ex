defmodule NearApi.Gas do
  @moduledoc """
  NEAR RPC - Gas API
  """
  import NearApi.Utils, only: [api_call_method: 2]

  @doc """
  Returns gas price for a specific block_height or block_hash.

  Using [nil] will return the most recent block's gas price.
  """
  @spec gas_price(block_id :: any) :: {:ok, body :: map} | NearApi.Errors.t()
  def gas_price(block_id \\ nil), do: api_call_method([block_id], "gas_price")
end
