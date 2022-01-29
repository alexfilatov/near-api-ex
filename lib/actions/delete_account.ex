defmodule NearApi.Actions.DeleteAccount do
  @moduledoc """
  Transaction Actions

  DeleteAccount
  """
  @type t :: %__MODULE__{action_code: integer, beneficiary_id: String.t()}

  use Borsh,
    schema: [
      action_code: :u8,
      beneficiary_id: :string
    ]

  defstruct [:beneficiary_id, action_code: 7]
end
