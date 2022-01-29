defmodule NearApi.Action do
  @moduledoc """
  NEAR [Action](https://www.near-sdk.io/zero-to-hero/beginner/actions).
  """
  alias __MODULE__

  @typedoc """
  All the details needed to encode an instruction.
  """
  @type t :: %__MODULE__{
          program: NearApi.key() | nil,
          accounts: [Account.t()],
          data: binary | nil
        }

  defstruct [
    :data,
    :program,
    accounts: []
  ]

  @doc """
  List of all available Actions for NEAR Transaction, indexed
  Please do not change the indexes or swap places - these indexes are hardcoded in the NEAR blockchain and very important for the Borsh serialization
  """
  def enum_map do
    %{
      0 => NearApi.Actions.CreateAccount,
      1 => NearApi.Actions.DeployAccount,
      2 => NearApi.Actions.FunctionCall,
      3 => NearApi.Actions.Transfer,
      4 => NearApi.Actions.Stake,
      5 => NearApi.Actions.AddKey,
      6 => NearApi.Actions.DeleteKey,
      7 => NearApi.Actions.DeleteAccount
    }
  end
end
