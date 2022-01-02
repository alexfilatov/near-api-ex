defmodule NearApi.Network do
  @moduledoc """
  NEAR RPC - Network API
  """
  import NearApi.Utils, only: [api_call_method: 2]

  @doc """
  Returns general status of a given node (sync status, nearcore node version, protocol version, etc),
  and the current set of validators.
  """
  @spec status() :: {:ok, body :: map} | NearApi.Errors.t()
  def status(), do: api_call_method(nil, "status")

  @doc """
  Returns general status of a given node (sync status, nearcore node version, protocol version, etc),
  and the current set of validators.
  """
  @spec network_info() :: {:ok, body :: map} | NearApi.Errors.t()
  def network_info(), do: api_call_method(nil, "network_info")
end
