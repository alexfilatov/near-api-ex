defmodule NearApi.Block do
  @moduledoc """
  NEAR RPC - Block API
  """
  import NearApi.Utils, only: [api_call: 1, api_call_method: 2]

  @doc """
  """
  @spec block(block_id :: String.t(), finality :: String.t()) :: {:ok, body :: map} | NearApi.Errors.t()
  def block(block_id \\ nil, finality \\ "final") do
    payload = payload_block(block_id)
    api_call_method(payload, "block")
  end

  defp payload_block(nil, finality \\ "final"), do: %{finality: finality}
  defp payload_block(block_id, _finality), do: %{block_id: block_id}
end
