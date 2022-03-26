defmodule NearApi.Payload do
  @moduledoc """
  NEAR API payload functions
  """

  def payload(request_type, account_id, nil) do
    %{request_type: request_type, finality: "final", account_id: account_id}
  end

  def payload(request_type, account_id, "optimistic") do
    %{request_type: request_type, finality: "optimistic", account_id: account_id}
  end

  def payload(request_type, account_id, block_id) do
    %{request_type: request_type, block_id: block_id, account_id: account_id}
  end

  def payload_experimental(changes_type, account_ids, nil) do
    %{changes_type: changes_type, finality: "final", account_ids: account_ids}
  end

  def payload_experimental(changes_type, account_ids, "optimistic") do
    %{changes_type: changes_type, finality: "optimistic", account_ids: account_ids}
  end

  def payload_experimental(changes_type, account_ids, block_id) do
    %{changes_type: changes_type, block_id: block_id, account_ids: account_ids}
  end
end
