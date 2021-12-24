defmodule NearApi.HttpClient do
  use HTTPoison.Base

  def process_request_url(url) do
    endpoint_url() <> url
  end

  def process_response_body(body) do
    Jason.decode!(body)
  end

  def process_request_headers(headers) do
    headers ++ ["Content-Type": "application/json"]
  end

  def api_call(payload) do
    params_encoded = NearApi.HttpClient.params("query", payload) |> Jason.encode!()

    case NearApi.HttpClient.post("/", params_encoded) do
      {:ok, response} -> response.body
      error -> error
    end
  end

  @doc """
  Wraps payload into
  """
  def params(method, payload) do
    %{
      id: "dontcare",
      jsonrpc: "2.0",
      method: method,
      params: payload
    }
  end

  defp endpoint_url do
    System.get_env("NEAR_NODE_URL")
  end
end
