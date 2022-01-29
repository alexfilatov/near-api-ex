defmodule NearApi.Actions.AddKey do
  @moduledoc """
  Transaction Actions

  AddKey
  """
  @type t :: %__MODULE__{action_code: integer, public_key: NearApi.PublicKey.t(), access_key: NearApi.AccessKey.t()}

  use Borsh,
    schema: [
      action_code: :u8,
      public_key: :borsh,
      access_key: :borsh
    ]

  defstruct [:public_key, :access_key, action_code: 5]
end
