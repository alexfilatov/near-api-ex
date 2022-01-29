defmodule NearApi.Account do
  @moduledoc """
  NearApi [accounts]().
  """

  @typedoc """

  """
  @type t :: %__MODULE__{
          signer?: boolean(),
          writable?: boolean(),
          key: NearApi.key() | nil
        }

  defstruct [
    :key,
    signer?: false,
    writable?: false
  ]
end
