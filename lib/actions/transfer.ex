defmodule NearApi.Actions.Transfer do
  @moduledoc """
  Transaction Actions

  Transfer
  """
  @type t :: %__MODULE__{deposit: integer }

  use Borsh, schema: [deposit: :u128]

  defstruct [:deposit]
end
