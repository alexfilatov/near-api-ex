defmodule NearApi.Utils do
  @moduledoc """
  NEAR API Utils module
  """
  alias NearApi.Errors

  @doc """
  Public Key retriever. :woof
  """
  def public_key do
    System.get_env("NEAR_PUBLIC_KEY")
  end

  @doc """
  Does the actual RPC call to the NEAR API and formats output
  """
  def api_call(payload) do
    case NearApi.HttpClient.api_call(payload) do
      %{"result" => %{"error" => error_message}} = response ->
        {:error, response: response, error_message: error_message}

      %{"error" => _error} = response ->
        Errors.render_error(response)

      body ->
        {:ok, body}
    end
  end
end
