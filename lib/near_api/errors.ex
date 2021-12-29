defmodule NearApi.Errors do
  @moduledoc """
  NEAR API Error handlers: Access Keys
  """

  @spec render_error(error_response :: map) ::
          {:error,
           %{
             error_message: error_message :: String.t(),
             error_type: error_type :: String.t(),
             error_cause: error_cause :: String.t(),
             error_code: error_code :: integer,
             error_description: error_description :: String.t(),
             response: response :: String.t()
           }}
  def render_error(
        %{
          "error" => %{
            "name" => error_type,
            "message" => error_message,
            "code" => error_code,
            "data" => error_description,
            "cause" => %{
              "name" => error_cause
            }
          }
        } = response
      ) do
    {:error,
     %{
       error_message: error_message,
       error_type: error_type,
       error_cause: error_cause,
       error_code: error_code,
       error_description: error_description,
       response: response
     }}
  end
end
