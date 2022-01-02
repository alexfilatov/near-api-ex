defmodule NearApiTest do
  use ExUnit.Case

  setup do
    {:ok, functions: NearApi.__info__(:functions)}
  end

  describe "NearApi" do
    test "AccessKeys: module contains delegated functions", %{functions: functions} do
      refute functions -- [view_access_key: 3] == functions
      refute functions -- [view_access_key_list: 3] == functions
    end

    test "Accounts: module contains delegated functions", %{functions: functions} do
      refute functions -- [view_account: 2] == functions
      refute functions -- [account_changes: 2] == functions
    end

    test "Contracts: module contains delegated functions", %{functions: functions} do
      refute functions -- [view_code: 2] == functions
      refute functions -- [view_state: 3] == functions
      refute functions -- [data_changes: 3] == functions
      refute functions -- [contract_code_changes: 2] == functions
      refute functions -- [call_function: 4] == functions
    end

    test "Block: module contains delegated functions", %{functions: functions} do
      refute functions -- [block: 2] == functions
      refute functions -- [changes_in_block: 2] == functions
    end

    test "Chunk: module contains delegated functions", %{functions: functions} do
      refute functions -- [chunk: 3] == functions
    end

    test "Gas: module contains delegated functions", %{functions: functions} do
      refute functions -- [gas_price: 1] == functions
    end

    test "Network: module contains delegated functions", %{functions: functions} do
      refute functions -- [status: 0] == functions
      refute functions -- [network_info: 0] == functions
      refute functions -- [validators: 1] == functions
    end

    test "Protocol: module contains delegated functions", %{functions: functions} do
      refute functions -- [genesis_config: 0] == functions
      refute functions -- [protocol_config: 1] == functions
    end
  end
end
