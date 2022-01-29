defmodule NearApi.Actions.FunctionCall do
  @moduledoc """
  Transaction Actions

  FunctionCall
  """
  @type t :: %__MODULE__{
          action_code: integer,
          method_name: String.t(),
          args: String.t(),
          gas: integer,
          amount: integer
        }

  use Borsh,
    schema: [
      action_code: :u8,
      method_name: :string,
      args: :string,
      gas: :u64,
      amount: :u128
    ]

  defstruct [:action_code, :method_name, :args, :gas, :amount, action_code: 2]
end
