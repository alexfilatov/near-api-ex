defmodule NearApi.RPC.Block do
  @moduledoc """
  NEAR RPC - Block API
  """
  import NearApi.Helpers, only: [api_call_method: 2]

  @doc """
  Queries network and returns block for given height or hash.
  You can also use `finality` param to return latest block details.
  """
  @spec block(block_id :: String.t(), finality :: String.t()) ::
          {:ok, body :: map} | NearApi.RPC.Errors.t()
  def block(block_id \\ nil, finality \\ "final") do
    payload = payload_block(block_id, finality)
    api_call_method(payload, "block")
  end

  @doc """
  Queries network and returns block for given height or hash.
  You can also use `finality` param to return latest block details.
  Warning: Experimental!
  """
  @spec changes_in_block(block_id :: String.t(), finality :: String.t()) ::
          {:ok, body :: map} | NearApi.RPC.Errors.t()
  def changes_in_block(block_id \\ nil, finality \\ "final") do
    payload = payload_block(block_id, finality)
    api_call_method(payload, "EXPERIMENTAL_changes_in_block")
  end

  defp payload_block(nil, finality), do: %{finality: finality}
  defp payload_block(block_id, _finality), do: %{block_id: block_id}
end
