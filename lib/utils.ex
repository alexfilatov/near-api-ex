defmodule NearApi.Utils do
  @moduledoc """
  NEAR API Utils module
  """

  def public_key do
    System.get_env("NEAR_PUBLIC_KEY")
  end
end
