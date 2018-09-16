# phoenix-ecto-append-only-log-example
📝 A step-by-step example for how build a Phoenix (Elixir) App where all data is immutable (append only) and accountability is guaranteed.

## Why?

## What?

## Who?

## How?

### Before you start

Make sure you have installed on your machine:

+ Elixir: https://elixir-lang.org/install.html
+ Phoenix: https://hexdocs.pm/phoenix/installation.html
+ PostgreSQL: https://www.postgresql.org/download/

Make sure you have a non-default PostgresQL user, with no more than `CREATEDB` privileges. If not, follow the steps below:

+ open psql by typing `psql` into your terminal
+ In psql, type:
  + `CREATE USER append_only;`
  + `ALTER USER append_only CREATEDB;`

### 1. Getting started

Make a new Phoenix app:

```
mix phx.new append
```

Type `y` when asked if you want to install the dependencies, then follow the instructions to `change directory`:

```
cd append
```

then, go into your generated config file. In `config/dev.exs` and `config/test.exs` you should see a section that looks like this:
``` elixir
# Configure your database
config :append, Append.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  ...
```

Change the username to your non-default PostgreSQL user:

``` elixir
  ...
  username: "append_only",
  ...
```

Once you've done this, `create the database` for your app:

``` sh
mix ecto.create
```

### 2. Create the Schema

We're going to use an address book as an example. run the following generator command to create our schema:

``` sh
mix phx.gen.schema Address addresses name:string address_line_1:string address_line_2:string city:string postcode:string tel:string
```

This will create two new files:
+ `lib/append/address.ex`
+ `priv/repo/migrations/{timestamp}_create_addresses.exs`

Before you follow the instructions in your terminal, we'll need to edit the generated migration file.

The generated file should look like this:

``` elixir
defmodule Append.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add(:name, :string)
      add(:address_line_1, :string)
      add(:address_line_2, :string)
      add(:city, :string)
      add(:postcode, :string)
      add(:tel, :string)

      timestamps()
    end

  end
end
```

We need to edit it to remove update and delete privileges for our user:

``` elixir
defmodule Append.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  # Get name of our Ecto Repo module from our config
  @repo :append |> Application.get_env(:ecto_repos) |> List.first()
  # Get username of Ecto Repo from our config
  @db_user Application.get_env(:append, @repo)[:username]

  def change do
    ...
    execute("REVOKE UPDATE, DELETE ON TABLE addresses FROM #{@db_user}")
  end
end
```

Once this is done, run:
``` sh
mix ecto.migrate
```
and you should see the following output:
``` sh
[info] == Running Append.Repo.Migrations.CreateAddresses.change/0 forward
[info] create table addresses
[info] execute "REVOKE UPDATE, DELETE ON TABLE addresses FROM append_only"
[info] == Migrated in 0.0s
```

### 3. Defining our Interface

Now that we have no way to delete or update the data, we need to define the functions we'll use to access and insert the data. To do this we'll define an Elixir behaviour (https://hexdocs.pm/elixir/behaviours.html) with some predefined functions.

The first thing we'll do is create the file for the behaviour. Create a file called `lib/append/append_only_log.ex` and add to it the following code:

``` elixir
defmodule Append.AppendOnlyLog do
  defmacro __using__(_opts) do
    quote do
      @behaviour Append.AppendOnlyLog

    end
  end
end
```

Here, we're creating a macro, and defining it as a behaviour. The `__using__` macro is a callback that will be injected into any module that calls `use Append.AppendOnlyLog`. We'll define some functions in here that can be reused by different modules. (see https://elixir-lang.org/getting-started/alias-require-and-import.html#use for more info on `__using__`).

The next step in defining a behaviour is to provide some callbacks that must be provided.

``` elixir
defmodule Append.AppendOnlyLog do
  @callback insert
  @callback get
  @callback get_by
  @callback update

  defmacro __using__(_opts) do
    ...
  end
end
```

These are the three functions we'll define in this macro to interface with the database. You may think it odd that we're defining an `update` function for our append only database, but we'll get to that later.

Callback definitions are similar to typespecs, in that you can provide the types that the functions expect to receive as arguments, and what they will return.


``` elixir
defmodule Append.AppendOnlyLog do
  @callback insert(struct) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}
  @callback get(integer) :: Ecto.Schema.t() | nil | no_return()
  @callback get_by(Keyword.t() | map) ::  Ecto.Schema.t() | nil | no_return()
  @callback update(Ecto.Schema.t(), struct) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}

  defmacro __using__(_opts) do
    quote do
      @behaviour Append.AppendOnlyLog

      def insert(attrs) do
      end

      def get(id) do
      end

      def get_by(clauses) do
      end

      def update(item, attrs) do
      end
    end
  end
end
```

The next step is to define the functions themselves, but first we'll write some tests.

### 4. Implementing our Interface
#### 4.1 Insert

The first thing we'll want to do is insert something into our database, so we'll put together a simple test for that. Create a directory called `test/append/` and a file called `test/append/address_test.exs`.

``` elixir
defmodule Append.AddressTest do
  use Append.DataCase
  alias Append.Address

  test "add item to database" do
    assert {:ok, item} = Address.insert(%{
      name: "Thor",
      address_line_1: "The Hall",
      address_line_2: "Valhalla",
      city: "Asgard",
      postcode: "AS1 3DG",
      tel: "0800123123"
    })

    assert item.name == "Thor"
  end
end
```

This test will assert that an item has been correctly inserted into the database. Run `mix test` now, and you should see it fail.

``` sh
1) test add item to database (Append.AddressTest)
     test/append/address_test.exs:5
     ** (UndefinedFunctionError) function Append.Address.insert/1 is undefined or private
     code: assert {:ok, item} = Address.insert(%{
     stacktrace:
       (append) Append.Address.insert(%{address_line_1: "The Hall", address_line_2: "Valhalla", city: "Asgard", name: "Thor", postcode: "AS1 3DG", tel: "0800123123"})
       test/append/address_test.exs:6: (test)
```

Now we'll go and write the code to make the test pass. The first thing we need is the actual `insert/1` function body:

``` elixir
defmodule Append.AppendOnlyLog do
  ...
  defmacro __using__(_opts) do
    quote do
      @behaviour Append.AppendOnlyLog

      def insert(attrs) do
        %__MODULE__{}
        |> __MODULE__.changeset(attrs)
        |> Repo.insert()
      end
      ...
    end
  end
end
```

Now, because we're using a macro, everything inside the `quote do`, will be injected into the module that uses this macro, and so will access its context. So in this case, where we are using `__MODULE__`, it will be replaced with the calling module's name (`Append.Address`).

In order to now use this function, we need to include the macro in `lib/append/address.ex`, which we generated earlier:

``` elixir
defmodule Append.Address do
  use Ecto.Schema
  import Ecto.Changeset

  use Append.AppendOnlyLog #include the functions from this module's '__using__' macro.

  schema "addresses" do
    ...
  end

  @doc false
  def changeset(address, attrs) do
    ...
  end
end
```

Now run the tests again.

``` sh
** (CompileError) lib/append/address.ex:4: Append.Address.__struct__/1 is undefined, cannot expand struct Append.Address
    (stdlib) lists.erl:1354: :lists.mapfoldl/3
    (elixir) expanding macro: Kernel.|>/2
```

Ah, an error.

Now this error may seem a little obtuse. The error is on line 4 of address.ex? That's:
``` elixir
use Append.AppendOnlyLog
```
That's because at compile time, this line is replaced with the contents of the macro, meaning the compiler isn't sure exactly which line of the macro is causing the error. This is one of the disadvantages of macros, and why they should be kept short, and used sparingly.

Luckily, there is a way we can see the stacktrace of the macro. Add `location: :keep` to the `quote do`:

``` elixir
defmodule Append.AppendOnlyLog do
  ...
  defmacro __using__(_opts) do
    quote location: :keep do
      @behaviour Append.AppendOnlyLog

      def insert(attrs) do
        ...
      end
      ...
    end
  end
end
```

Now, if we run `mix test` again, we should see where the error actually is:

``` sh
** (CompileError) lib/append/append_only_log.ex:20: Append.Address.__struct__/1 is undefined, cannot expand struct Append.Address
    (stdlib) lists.erl:1354: :lists.mapfoldl/3
    (elixir) expanding macro: Kernel.|>/2
```

Line 20 of `append_only_log.ex`:
``` elixir
%__MODULE__{}
```

So we see that trying to access the `Append.Address` struct is causing the error. Now this function `Append.Address.__struct__/1` should be defined when we call:

``` elixir
schema "addresses" do
```

in the `Address` module. The problem lies in the way macros are injected into modules, and the order functions are evaluated. We could solve this by moving the `use Append.AppendOnlyLog` after the schema:

``` elixir
defmodule Append.Address do
  ...

  schema "addresses" do
    ...
  end

  use Append.AppendOnlyLog #include the functions from this module's '__using__' macro.

  ...
end
```

Now run `mix.test` and it should pass! But something doesn't quite feel right. We shouldn't need to include a 'use' macro halfway down a module to get our code to compile. And we don't! Elixir provides some fine grained control over the compile order of modules: https://hexdocs.pm/elixir/Module.html#module-module-attributes

In this case, we want to use the `@before_compile` attribute.

``` elixir
defmodule Append.AppendOnlyLog do
  ...
  defmacro __using__(_opts) do
    quote do
      @behaviour Append.AppendOnlyLog
      @before_compile unquote(__MODULE__)
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
      end

      def update(item, attrs) do
      end
    end
  end
end
```

So here we add `@before_compile unquote(__MODULE__)` to `__using__`.

`unquote(__MODULE__)` here, just means we want to use the `__before_compile__` macro defined in _this_ module (`AppendOnlyLog`), _not_ the calling module (`Address`).

Then, the code we put inside `__before_compile__` will be injected at the _end_ of the calling module, meaning the schema will already be defined, and our tests should pass.

```
Finished in 0.1 seconds
4 tests, 0 failures
```

#### 4.2 Get/Get By

Now that we've done the hard parts, we'll implement the rest of the functionality for our Append Only Log.

The `get` and `get by` functions should be fairly simple, we just need to forward the requests to the Repo. But first, a test.

``` elixir
defmodule Append.AddressTest do
  ...
  describe "get item from database" do
    test "get/1" do
      {:ok, item} = insert_address()

      assert Address.get(item.id) == item
    end

    test "get_by/1" do
      {:ok, item} = insert_address()

      assert Address.get_by(name: "Thor") == item
    end
  end

  def insert_address do
    Address.insert(%{
      name: "Thor",
      address_line_1: "The Hall",
      address_line_2: "Valhalla",
      city: "Asgard",
      postcode: "AS1 3DG",
      tel: "0800123123"
    })
  end
end
```

You'll see we've refactored the insert call into a function so we can reuse it, and added some simple tests. Run `mix test` and make sure they fail, then we'll implement the functions.

``` elixir
defmodule Append.AppendOnlyLog do
  ...
  defmacro __before_compile__(_env) do
    quote do
      ...
      def get(id) do
        Repo.get(__MODULE__, id)
      end

      def get_by(clauses) do
        Repo.get_by(__MODULE__, clauses)
      end
      ...
    end
  end
end
```

`mix test` again, and we should be all green.

#### 4.3 Update

Now we come to the update function. "But I thought we were only appending to the database?" I hear you ask. This is true, but we still need to relate our existing data to the new, updated data we add.

To do this, we need to be able to reference the previous entry somehow. The simplest (conceptually) way of doing this is to provide each entry a unique id. Note that the id will be used to represent unique entries, but it will not be unique in a table, as revisions of entries will have the same id. This is the simplest way we can link our entries, but there may be some disadvantages, which we'll look into later.

So, first we'll need to edit our schema to add a shared id to our address entries:

``` elixir
defmodule Append.Address do
  ...
  schema "addresses" do
    ...
    field(:entry_id, :string)

    ...
  end
  ...
end
```

And create a migration file:

```
mix ecto.gen.migration add_entry_id
```

``` elixir
defmodule Append.Repo.Migrations.AddEntryId do
  use Ecto.Migration

  def change do
    alter table("addresses") do
      add :entry_id, :string
    end

  end
end
```

```
mix ecto.migrate
```

Now, we'll write a test for the update function.

``` elixir
defmodule Append.AddressTest do
  ...
  test "update item in database" do
    {:ok, item} = insert_address()

    {:ok, updated_item} = Address.update(item, %{tel: "0123444444"})

    assert updated_item.name == item.name
    assert updated_item.tel != item.tel
  end
  ...
end
```

Then we write the update function itself. We'll take the existing item, and a map of updated attributes as arguments.

Then we'll use the `insert` function to create a new entry in the database, rather than `update`, which would overwrite the old one.

``` elixir
defmodule Append.AppendOnlyLog do
  ...
  defmacro __before_compile__(_env) do
    quote do
      ...
      def update(%__MODULE__{} = item, attrs) do
        item
        |> __MODULE__.changeset(attrs)
        |> Repo.insert()
      end
    end
  end
end
```

But now, if we try to run our tests:

```
1) test update item in database (Append.AddressTest)
     test/append/address_test.exs:25
     ** (Ecto.ConstraintError) constraint error when attempting to insert struct:

         * unique: addresses_pkey
```
We can't add the item again, because the unique id already exists in the database.

``` elixir
def update(%__MODULE__{} = item, attrs) do
  item
  |> Map.put(:id, nil)
  |> __MODULE__.changeset(attrs)
  |> Repo.insert()
end
```

So here we remove the original autogenerated id from the existing item, preventing us from duplicating it in the database.

#### 4.4 Get history

The final part of our append only database will be the functionality to see the entire history of an item.

As usual, we'll write a test first:

``` elixir
defmodule Append.AddressTest do
  ...
  test "get history of item" do
    {:ok, item} = insert_address()

    {:ok, updated_item} = Address.update(item, %{
      address_line_1: "12",
      address_line_2: "Kvadraturen",
      city: "Oslo",
      postcode: "NW1 SCA",
    })

    {:ok, history} = Address.get_history(updated_item)

    assert length(history) == 2
    assert [h1, h2] = history
    assert h1[:city] == "Asgard"
    assert h2[:city] == "Oslo"
  end
  ...
end
```

Then the function:

``` elixir
defmodule Append.AppendOnlyLog do
  alias Append.Repo
  require Ecto.Query

  ...
  @callback get_history(Ecto.Schema.t()) :: [Ecto.Schema.t()] | no_return()

  ...
  defmacro __before_compile__(_env) do
    quote do
      import Ecto.Query, only: [from: 2]

      ...
      def get_history(%__MODULE__{} = item) do
        query = from m in __MODULE__,
        where: m.entry_id == ^item.entry_id,
        select: m

        Repo.all(query)
      end
      ...
    end
  end
  ...
end
```

You'll notice the new callback definition at the top of the file, and that we're now importing `Ecto.Query`. We have to make sure we import Ecto.Query inside our macro, so the scope matches where we end up calling it.

Now run your tests, and you'll see that we're now able to view the whole history of the changes of all items in our database.
