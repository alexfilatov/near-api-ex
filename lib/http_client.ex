defmodule NearApi.HttpClient do
  use HTTPoison.Base
  require Logger
  @retry_attempts 2

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

  defp perform_call(method, payload, retry_attempt \\ 0)

  defp perform_call(method, payload, retry_attempt) when retry_attempt < @retry_attempts do
    params_encoded = NearApi.HttpClient.params(method, payload) |> Jason.encode!()
    recv_timeout = Application.get_env(:near_api, :recv_timeout, 50_000)
    timeout = Application.get_env(:near_api, :timeout, 50_000)

    case NearApi.HttpClient.post("/", params_encoded, [], recv_timeout: recv_timeout, timeout: timeout) do
      {:ok, response} ->
        response.body

      {:error, %HTTPoison.Error{reason: :timeout}} ->
        Logger.warn(
          "#{__MODULE__}: Timeout making a transaciton call: #{inspect({method, payload})}; attempt: #{retry_attempt}"
        )

        perform_call(method, payload, retry_attempt + 1)

      error ->
        error
    end
  end

  defp perform_call(method, payload, retry_attempt) do
    Logger.error("#{__MODULE__}: Aborted retrying calls to NEAR API because of timeouts")
    {:error, :timeouted_after_multiple_retries}
  end

  defp endpoint_url do
    System.get_env("NEAR_NODE_URL")
  end
end
