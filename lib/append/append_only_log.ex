defmodule Append.AppendOnlyLog do
  alias Append.Repo

  @moduledoc """
  Behaviour that defines functions for accessing and inserting data in an
  Append-Only database
  """

  @callback insert(struct) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}
  @callback get(integer) :: Ecto.Schema.t() | nil | no_return()
  @callback get_by(Keyword.t() | map) ::  Ecto.Schema.t() | nil | no_return()
  @callback update(Ecto.Schema.t(), struct) ::
              {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}

  defmacro __using__(_opts) do
    quote do
      @behaviour Append.AppendOnlyLog
      @before_compile unquote(__MODULE__)

      defoverridable Append.AppendOnlyLog
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def insert(attrs) do
        %__MODULE__{}
        |> __MODULE__.changeset(attrs)
        |> Repo.insert()
      end

      def get(id) do
        Repo.get(__MODULE__, id)
      end

      def get_by(clauses) do
        Repo.get_by(__MODULE__, clauses)
      end

      def update(%__MODULE__{} = item, attrs) do
      end
    end
  end
end
