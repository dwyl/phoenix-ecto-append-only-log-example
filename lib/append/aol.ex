defmodule Append.AOL do
  import Ecto.Changeset

  # macro way
  # user needs to...
  # 1 - call use MACRO_MODULE name in calling module
  # 2 - Call CallingModuleName.insert(params)
  # (not much effort on the users part)
  # def insert(attrs) do
  #   %__MODULE__{}
  #   |> __MODULE__.changeset(attrs)
  #   |> Repo.insert()
  # end

  # non macro way
  # user needs to...
  # 1 - Call ThisModuleName.insert(Module, params)
  # (again, not much effort on the users part)
  # Also, if the user is following new practices and has a context which handles
  # calling insert, they could (and I think should) have a function defined
  # which in turn calls this function. e.g.
  # defmodule MyApp.MyContext do
  #   def insert_user(attrs) do
  #     Append.AOL.insert(User, attrs)
  #   end
  # end
  # This would mean that they would just be calling...
  # MyApp.MyContext.insert_user(attrs)
  # so really no overhead at all
  # shrug emoji
  def insert(module, attrs) do
    module
    |> struct()
    |> module.changeset(attrs)
    # |> insert_entry_id()
    |> Append.Repo.insert()
  end

  # This function would handle adding the entry_id to the changeset. It's not
  # really needed for this example but it would be needed in a real app. See
  # comments in Append.Address for more info on this
  def insert_entry_id(%Ecto.Changeset{valid?: true} = changeset) do
    case get_field(changeset, :entry_id) do
      nil ->
        put_change(changeset, :entry_id, Ecto.UUID.generate())

      _ ->
        # may need to put an error here saying something like...
        # OI!!!!!! Don't try to generate your own entry_id...
        # But haven't really thought that far ahead. Also it isn't done in this
        # example anyway so didn't think it was needed.
        changeset
    end

  end

  def insert_entry_id(changeset), do: changeset
end