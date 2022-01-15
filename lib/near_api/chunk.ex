defmodule NearApi.Chunk do
  @moduledoc """
  NEAR RPC - Chunk API
  """
  import NearApi.Helpers, only: [api_call_method: 2]

  @doc """
  Returns details of a specific chunk. You can run a block details query to get a valid chunk hash.
  """
  @spec chunk(chunk_id :: String.t(), block_id :: any, shard_id :: integer) ::
          {:ok, body :: map} | NearApi.Errors.t()
  def chunk(chunk_id \\ nil, block_id \\ nil, shard_id \\ nil) do
    payload = payload_chunk(chunk_id, block_id, shard_id)
    api_call_method(payload, "chunk")
  end

  defp payload_chunk(chunk_id, nil, nil), do: %{chunk_id: chunk_id}
  defp payload_chunk(nil, block_id, shard_id), do: %{block_id: block_id, shard_id: shard_id}
end
