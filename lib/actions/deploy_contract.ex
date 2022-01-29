defmodule NearApi.Actions.DeployContract do
  @moduledoc """
  Transaction Actions

  DeployContract
  """
  @type t :: %__MODULE__{action_code: integer, code: integer}

  use Borsh,
    schema: [
      action_code: :u8,
      code: :u8
    ]

  defstruct [:code, action_code: 1]
end
