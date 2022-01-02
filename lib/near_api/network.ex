defmodule NearApi.Network do
  @moduledoc """
  NEAR RPC - Network API
  """
  import NearApi.Utils, only: [api_call_method: 2]

  @doc """
  """
  @spec status() :: {:ok, body :: map} | NearApi.Errors.t()
  def status(), do: api_call_method(nil, "status")
end
