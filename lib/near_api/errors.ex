defmodule NearApi.Errors do
  @moduledoc """
  NEAR API Error handlers: Access Keys
  """

  @spec render_error(error_response :: map) ::
          {:error,
           %{
             error_message: error_message :: string,
             error_name: error_name :: string,
             error_code: error_code :: integer,
             error_description: error_description :: string,
             response: response :: string
           } :: map}
  def render_error(
        %{
          "error" => %{
            "name" => error_name,
            "message" => error_message,
            "code" => error_code,
            "data" => error_description
          }
        } = response
      ) do
    {:error,
     %{
       error_message: error_message,
       error_name: error_name,
       error_code: error_code,
       error_description: error_description,
       response: response
     }}
  end
end
