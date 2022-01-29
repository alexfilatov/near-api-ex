defmodule NearApi.RPC.Protocol do
  @moduledoc """
  NEAR RPC - Protocol API
  """
  import NearApi.Helpers, only: [api_call_method: 2]

  @doc """
  Returns current genesis configuration.
  """
  @spec genesis_config() :: {:ok, body :: map} | NearApi.RPC.Errors.t()
  def genesis_config(), do: api_call_method(nil, "EXPERIMENTAL_genesis_config")

  @doc """
  Returns most recent protocol configuration or a specific queried block.
  Useful for finding current storage and transaction costs.
  """
  @spec protocol_config(block_id :: any, finality :: String.t()) ::
          {:ok, body :: map} | NearApi.RPC.Errors.t()
  def protocol_config(block_id \\ nil, finality \\ "final") do
    payload = payload(block_id, finality)
    api_call_method(payload, "EXPERIMENTAL_protocol_config")
  end

  defp payload(nil, finality), do: %{finality: finality}
  defp payload(block_id, _finality), do: %{block_id: block_id}
end
