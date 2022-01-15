defmodule NearApi.Contracts do
  @moduledoc """
  NEAR RPC - Contracts API
  """
  import NearApi.Helpers, only: [api_call: 1, api_call_method: 2]
  import NearApi.Payload

  @doc """
  Returns the contract code (Wasm binary) deployed to the account.
  Please note that the returned code will be encoded in base64.
  """
  @spec view_code(account_id :: String.t(), block_id :: String.t()) ::
          {:ok, body :: map} | NearApi.Errors.t()
  def view_code(account_id, block_id \\ nil) do
    payload = payload("view_code", account_id, block_id)
    api_call(payload)
  end

  @doc """
  Returns the state (key value pairs) of a contract based on the key prefix (base64 encoded).
  Pass an empty string for `prefix_base64` if you would like to return the entire state.
  Please note that the returned state will be base64 encoded as well.
  """
  @spec view_state(account_id :: String.t(), block_id :: String.t(), prefix_base64 :: String.t()) ::
          {:ok, body :: map} | NearApi.Errors.t()
  def view_state(account_id, block_id \\ nil, prefix_base64 \\ nil) do
    payload =
      payload("view_state", account_id, block_id) |> Map.put(:prefix_base64, prefix_base64 || "")

    api_call(payload)
  end

  @doc """
  Returns the state change details of a contract based on the key prefix (encoded to base64).
  Pass an empty string for this param if you would like to return all state changes.
  Warning: Experimental
  """
  @spec data_changes(
          account_ids :: String.t(),
          block_id :: String.t(),
          key_prefix_base64 :: String.t()
        ) :: {:ok, body :: map} | NearApi.Errors.t()
  def data_changes(account_ids, block_id \\ nil, key_prefix_base64 \\ nil)

  def data_changes(account_ids, block_id, key_prefix_base64)
      when is_binary(account_ids),
      do: data_changes([account_ids], block_id, key_prefix_base64)

  def data_changes(account_ids, block_id, key_prefix_base64) do
    payload =
      payload_experimental("data_changes", account_ids, block_id)
      |> Map.put(:key_prefix_base64, key_prefix_base64 || "")

    api_call_method(payload, "EXPERIMENTAL_changes")
  end

  @doc """
  Returns code changes made when deploying a contract. Change is returned is a base64 encoded WASM file.
  Warning: Experimental
  """
  @spec contract_code_changes(account_ids :: String.t(), block_id :: String.t()) ::
          {:ok, body :: map} | NearApi.Errors.t()
  def contract_code_changes(account_ids, block_id \\ nil)

  def contract_code_changes(account_ids, block_id) when is_binary(account_ids),
    do: data_changes([account_ids], block_id)

  def contract_code_changes(account_ids, block_id) do
    payload = payload_experimental("contract_code_changes", account_ids, block_id)
    api_call_method(payload, "EXPERIMENTAL_changes")
  end

  @doc """
  Allows you to call a contract method as a view function.
  """
  @spec call_function(account_id :: String.t(), method_name :: String.t(), block_id :: String.t()) ::
          {:ok, body :: map} | NearApi.Errors.t()
  def call_function(account_id, method_name, args_base64, block_id \\ nil) do
    payload =
      payload("call_function", account_id, block_id)
      |> Map.put(:method_name, method_name)
      |> Map.put(:args_base64, args_base64)

    api_call(payload)
  end
end
