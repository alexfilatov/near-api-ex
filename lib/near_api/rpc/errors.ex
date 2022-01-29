defmodule NearApi.RPC.Errors do
  @moduledoc """
  NEAR API Error handlers: Access Keys
  """
  alias __MODULE__

  @type t ::
          {:error,
           %{
             error_message: String.t(),
             error_type: String.t(),
             error_cause: String.t(),
             error_code: integer,
             error_description: String.t(),
             response: map
           }}

  @spec render_error(error_response :: map) :: Errors.t()
  def render_error(
        %{
          "error" => %{
            "name" => error_type,
            # TODO: could be deprecated
            "message" => error_message,
            # TODO: could be deprecated
            "code" => error_code,
            # TODO: could be deprecated
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
