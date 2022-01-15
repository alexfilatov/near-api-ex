defmodule Borsh do
  @moduledoc """
  BORSH, binary serializer for security-critical projects.

  Borsh stands for `Binary` `Object` `Representation` `Serializer` for `Hashing`.
  It is meant to be used in security-critical projects as it prioritizes consistency, safety, speed;
  and comes with a strict specification.

  This is Elixir implementation of the serializer.

  Official specification: https://github.com/near/borsh#specification
  """

  defmacro __using__(opts) do
    schema = opts[:schema]

    quote do
      def is_borsh, do: true

      def borsh_schema do
        unquote(schema)
      end

      @doc """
      Encodes objects according to the schema into the bytestring
      """
      @spec borsh_encode(obj :: keyword) :: bitstring()
      def borsh_encode(obj) do
        {_, res} =
          Enum.map_reduce(borsh_schema, [], fn schema_item, acc ->
            {schema_item, [[extract_encode_item(obj, schema_item)] | acc]}
          end)

        res |> Enum.reverse() |> List.flatten() |> :erlang.list_to_binary()
      end

      defp extract_encode_item(obj, {key, format}) do
        value = Map.get(obj, key)
        encode_item(value, {key, format})
      end

      @doc """
      When we see :borsh type, we:
      - check the obj[key] for borsh schema
      - execute borsh_encode of the following structure passing there obj[key] as obj
      """
      defp encode_item(value, {key, format}) when format === [:borsh] do
        [
          # 4bytes binary length of the List
          value |> length() |> binarify(32),
          # binarified list items
          Enum.map(value, fn i ->
            i.__struct__.borsh_encode(i)
          end)
        ]
      end

      defp encode_item(value, {key, format}) when format === :borsh do
        value.__struct__.borsh_encode(value)
      end

      # bytestring
      defp encode_item(value, {key, size}) when is_integer(size) and is_integer(value) do
        binarify(value, size)
      end

      defp encode_item(value, {key, size}) when is_integer(size) and is_binary(value) do
        encode_item(value, {key, :string})
      end

      defp encode_item(value, {key, size})
           when size in [:u8, :u16, :u32, :u64, :u128, :u256, :u512] and is_binary(value) do
        value |> String.to_integer() |> encode_item({key, size})
      end

      defp encode_item(value, {key, unsigned_size})
           when unsigned_size in [:u8, :u16, :u32, :u64, :u128, :u256, :u512] do
        size = convert_size(unsigned_size)
        binarify(value, size)
      end

      defp encode_item(string_value, {key, :string}) do
        # 4 bytes of the string length
        header = string_value |> byte_size() |> binarify()
        [header, string_value]
      end

      defp binarify(int_value, size \\ 32) do
        <<int_value::size(size)-integer-unsigned-little>>
      end

      defp convert_size(size) do
        size |> Atom.to_string() |> String.slice(1..3) |> String.to_integer()
      end
    end
  end
end
