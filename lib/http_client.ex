defmodule NearApi.HttpClient do
  use HTTPoison.Base

  @doc """
  Performs a "query" call to NEAR RPC API
  """
  def api_call(payload) do
    perform_call("query", payload)
  end

  @doc """
  Performs a "method" call to NEAR RPC API
  """
  def api_call_method(payload, method) do
    perform_call(method, payload)
  end

  def process_request_url(url) do
    endpoint_url() <> url
  end

  def process_response_body(body) do
    Jason.decode!(body)
  end

  def process_request_headers(headers) do
    headers ++ ["Content-Type": "application/json"]
  end

  @doc """
  Wraps payload into the NEAR query structure
  """
  def params(method, payload) do
    %{
      id: "dontcare",
      jsonrpc: "2.0",
      method: method,
      params: payload
    }
  end

  defp perform_call(method, payload) do
    params_encoded = NearApi.HttpClient.params(method, payload) |> Jason.encode!()

    case NearApi.HttpClient.post("/", params_encoded) do
      {:ok, response} -> response.body
      error -> error
    end
  end

  defp endpoint_url do
    System.get_env("NEAR_NODE_URL")
  end
end
