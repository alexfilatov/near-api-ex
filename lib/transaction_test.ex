defmodule NearApi.TransactionTest do
  def send_money(receiver_id \\ "nft.localtest.test.near", amount \\ 10) do
    auth = %{
      account_id: "bob.yellowpie.testnet",
      public_key: "ed25519:J5fZndQhLyTzwMvnYx9uxhQwEA34i4gFNP9VzdP4SocR",
      secret_key: "ed25519:3LTcwoy1uyq9gDjkKrh5TSRHdvULSFHcqvBpJY1mXJCd4tuQGrMXeizaw71G3BhG1mT2qZU1vvDecRRJzzeJjwWm"
    }

    sender_id = auth.account_id
    receiver_id = "yellowpie.testnet"

    {:ok, key} = NearApi.RPC.AccessKeys.view_access_key(sender_id, nil, auth.public_key)

    block_hash_raw = key["result"]["block_hash"]
    nonce = key["result"]["nonce"] + 1
#    block_hash_raw = "8JTDVUSpV97EjZ6xLFefLHWtyynaw5YEiWvfWHNtYTpF"
#    nonce = 76491755000037

    block_hash = B58.decode58!(block_hash_raw)

    action = %NearApi.Actions.Transfer{deposit: 500_000_000_000_000_000_000}
    key_pair = NearApi.KeyPair.key_pair(auth.public_key, auth.secret_key)

    public_key = key_pair.public_key

    tx = %NearApi.Transaction{
      signer_id: sender_id,
      receiver_id: receiver_id,
      nonce: nonce,
      public_key: public_key,
      block_hash: block_hash,
      actions: [action]
    }

    payload = NearApi.Transaction.payload(tx, key_pair)

    NearApi.Transactions.send_transaction_commit(payload)
  end
end
