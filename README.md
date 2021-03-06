<div align="center">

# Phoenix Ecto Append-only Log _Example_

[![Build Status](https://img.shields.io/travis/dwyl/phoenix-ecto-append-only-log-example/master.svg?style=flat-square)](https://travis-ci.org/dwyl/phoenix-ecto-append-only-log-example)
[![codecov.io](https://img.shields.io/codecov/c/github/dwyl/phoenix-ecto-append-only-log-example/master.svg?style=flat-square)](http://codecov.io/github/dwyl/phoenix-ecto-append-only-log-example?branch=master)
<!-- [![HitCount](http://hits.dwyl.io/dwyl/phoenix-ecto-append-only-log-example.svg)](https://github.com/dwyl/phoenix-ecto-append-only-log-example) -->
</div>
<br />


A **_step-by-step_ example** to help _anyone_
learn how build Phoenix Apps
where all data is stored in an **_append-only_ log**. <br />

## _Why_?

Read/learn this if you want: <br />
+ **Confidence** in your mission-critical code; know _exactly_ what's going on!
+ **Debugging** your app to be **_much_ easier** as you can _trace_
a request/change all the way through your app!
+ **Analytics _built-in_** to your App so you can _effortlessly_ derive
**user _behaviour_ metrics** i.e. **cohort analysis**
+ **_All_ history** of changes to data/records (_and who made them_)
so _users_ of your App can "***undo***" changes with ease.

<br />


If you have ever used the "***undo***" functionality in a program,
you have _experienced_ the power of an Append-only Log.


<div align="center">
    <a href="http://www.poorlydrawnlines.com/comic/undo/">
        <img src="https://user-images.githubusercontent.com/194400/46946840-f2030980-d070-11e8-853e-906f8734ce75.png"
        alt="poorly drawn lines comic: ctrl + z">
    </a>
</div>
<br />

When data is stored in Append-only (_immutable_) Log,
if a change is made to some data
it always creates a _new_ state
(_without altering history_).
This makes it _easy_ to return/rewind to the _previous_ state.

_Most_ functional programming languages
(_e.g: Elixir, Elm, Lisp, Haskell, Clojure_)
have an "_immutable data_" pattern;
data is always "transformed" never _mutated_.
This makes it _much faster_ to build reliable/predictable apps.
Code is simpler and debugging is considerably easier
when state is _always_ known and never over-written.

The "immutable data" principal in the Elm Architecture
is what enables the
["_Time Travelling Debugger_"](http://elm-lang.org/blog/time-travel-made-easy)
which is an incredibly powerful way to understand and debug an app.
By using an Append-only Log for _all_ data stored by our Elixir/Phoenix apps,
we get a "time-travelling debugger" and _complete_ "analytics" _built-in_!

It also means we are **_never_ confused** about how data/state was transformed:

<div align="center">
    <a href="https://twitter.com/jessitron/status/333228687208112128">
        <img src="https://user-images.githubusercontent.com/194400/46946485-c4699080-d06f-11e8-9b1e-30982cfb5c25.png"
        alt="@Jessitron (Jessica Kerr) tweet: Mutability leaves us with how did I get to this state?">
    </a>
</div>
<br />

> **Note**: If any these terms are unclear to you now,
don't worry, we will be clarifying them below. <br />
The main thing to remember is that using an Append-only Log
to store your app's data makes it _much_ easier
to build the app because records are never modified,
history is preserved and can easily be referred to

Once you overcome the _initial_ learning curve,
you will see that your apps become _easy_ to reason about
and you will "_unlock_" many other possibilities for useful features
and functionality that will _delight_
the people using your product/service!   

You will get your work done much faster and more reliably,
users will be happier with the UX and Product Owners/Managers
will be able to _see_ how data is transformed in the app;
_easily_ visualise the usage data and "flow" on analytics
charts/graphs in _realtime_.

## Who?

This example/tutorial is for
_all_ developers who have a basic understanding of Phoenix,
general knowledge of database storage in web apps
and want to "level up" their knowledge/skills.  
People who want to improve the _reliability_ of the product they are building.
Those who want to understand more ("advanced")
"distributed" application architecture
including the ability to (optionally/incrementally) build on this by using
IPFS and/or Blockchain in the future!

## What?

Using an Append Only Log is an _alternative_ to using Ecto's regular
["CRUD"](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete)
which allows overwriting and deleting data
without "rollback" or "recoverability".
In a "regular" Phoenix app each update _over-writes_ the state
of the record so it's impossible to retrieve it's history
without having to go digging through a backup
which is often a time-consuming process or simply _unavailable_.


### Append-only Logs are an _excellent_ approach to data storage _because_:

+ Data is _never over-written_ therefore it cannot be corrupted or "lost".
+ Field-level version control and accountability for all changes is _built-in_.
+ All changes to columns are _non-destructive additions_;
columns are never deleted or altered so existing code/queries never "break".
This is _essential_ for "**_Zero Downtime_ Continuous Deployment**".
  + A database migration can be applied
***before*** the app server is updated/refreshed
and the existing/current version of the app
can continue to run like nothing happened.
+ Data is stored as a "time series"
therefore it can be used for analytics. 📊 📈
+ "Realtime backups" are hugely simplified
(_compared to standard SQL/RDBMS_);
you simply stream the record updates to multiple storage locations/zones
and can easily recover from any "outage".

### _Examples_ where an Append-only Log is _useful_:

- **CMS/Blog** - being able to "roll back" content
means you can invite your trusted readers / stakeholders
to edit/improve your content
without "fear" of it decaying. 🔏
- **E-Commerce** - both for cart tracking and transaction logging. 🛒
  + Also, the same applies for the Product catalog
(_which is a specific type of CMS_);
having version history dramatically increases confidence in the site both
from an internal/vendor perspective and from end-users.
This is _especially_ useful for the reviews on e-commerce sites/apps
where we want to be able to detect/see where people have
updated their review following extended usage.
e.g: did the product disintegrate after a short period of time?
did the user give an initially unfavourable
review and over time come to realise
that the product is actually exceptionally durable,
well-designed and great value-for-money because
it has lasted twice a long as any previous product
they purchased to perform the same "job to be done"? ⭐️ ⭐️ ⭐️ ⭐️ ⭐️
- **Chat** - a chat system should allow editing
of previously sent messages for typos/inaccuracies,
but that edit/revision history should be transparent not just a "message edited"
banner (with no visibility of what changed). ✏️
- **Social Networking** - not allowing people to delete a message
without leaving a clarifying comment to promote accountability
for what people write. In many cases this can reduce hate speech. 😡 💬 😇
+ ***Healthcare***: a patient's medical data gets captured/recorded once
as a "snapshot" in time. The doctor or
[ECG machine](https://en.wikipedia.org/wiki/Electrocardiography)
does not go back and "update" the value of the patients heart rate
or electrophysiologic pattern.
A _new_ value is sampled at _each_ time interval.
+ **Analytics** is _all_ append-only time-series events
_streamed_ from the device to server and saved in a time-series data store.
  + Events in Analytics systems are often _aggregated_ (_using "views"_)
  into charts/graphs. The "views" of the data are "temporary tables"
  which store the _aggregated_ or _computed_ data
  but do not touch the underlying log/stream.
+ **Banking/Finance** - _all_ transactions are append-only ledgers.
If they were not accounting would be chaos and the world economy would collapse!
When the "available balance" of an account is required,
it is _calculated_ from the list/log of debit/credit transactions.
(_a summary of the data in an account may be **cached**
  in a database "view" but it is **never mutated**_)
- **CRM** - where customer data is updated and can be incorrectly altered,
having the complete history of a record and being able to "time travel"
through the change log is a really good idea. 🕙 ↩️ 🕤 ✅  
- **Most Other Web/Mobile Applications** - you name the app,
there is _always_ a way in which an append-only log
is applicable/useful/essential
to the reliability/confidence _users_ have in that app. 💖

### Append-only Using _PostgreSQL_...?

This example uses "stock" PostgreSQL and does not require any plugins.
This is a _deliberate choice_ and we use this approach in "production".
This means we can use _all_ of the power of Postgres,
and deploy our app to any "Cloud" provider that supports Postgres.

### Will it _Scale_?

Your PostgreSQL database will _not_ be the "bottleneck" in your app/stack.

Using an Append-only Log with UUIDs as Primary Keys
is _all_ the "ground work" needed <br />
to ensure that _any_ app we build
is _prepared_ to
[**scale _both_ Vertically _and_ Horizontally**](https://stackoverflow.com/questions/11707879/difference-between-scaling-horizontally-and-vertically-for-databases).
✅ 🚀 <br />

For example: an AWS RDS (PostgreSQL)
[`db.m4.16xlarge` instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html)
has **256GB** of RAM and can handle **10GB**/sec of "throughput".
The instance has been _benchmarked_ at ***200k writes/second*** .

If/when our/your app reaches **10k writes/sec**
and needs to use **one** of these instances
it will be **_insanely_** "**successful**" by _definition_. 🦄 🎉 <br />

Don't _worry_ about storing _all_ the data,
the insight it will give you will more than pay for itself!
Once your app is successful you can hire a _team_ of database _experts_
to fine-tune storing record history in a cheaper
[object store](https://github.com/dwyl/technology-stack/issues/63).

**Bottom line**: _embrace_ Postgres for your app,
you are in
[***good company***](https://github.com/dwyl/learn-postgresql/issues/31).
<br />
Postgres can handle whatever you throw at it
and _loves_ append-only data!

If your app ever "outgrows" Postgres,
you can easily migrate to
[**CitusDB**](https://github.com/dwyl/how-to-choose-a-database/issues/4).


### Prerequisites?

The only pre-requisite for understanding this example/tutorial are:

+ Basic Elixir language syntax knowledge: https://github.com/dwyl/learn-elixir
+ Basic Phoenix Framework knowledge:
https://github.com/dwyl/learn-phoenix-framework

> We _recommend_ that you follow the Phoenix Chat Example (_tutorial_):
https://github.com/dwyl/phoenix-chat-example
for _additional practice_ with Phoenix, Ecto and testing before (_or after_)
following _this_ example.

## How?

### Before you start

Make sure you have the following installed on your machine:

+ Elixir: https://elixir-lang.org/install.html
+ Phoenix: https://hexdocs.pm/phoenix/installation.html
+ PostgreSQL: https://www.postgresql.org/download

Make sure you have a non-default PostgreSQL user,
with no more than `CREATEDB` privileges.
If not, follow the steps below:

+ Open psql by typing `psql` into your terminal
+ In psql, type:
  + `CREATE USER append_only;`
  + `ALTER USER append_only WITH PASSWORD 'postgres';` (optional, only if you want to define the password for the  new user)
  + `ALTER USER append_only CREATEDB;`

Default users are `Superuser`s who cannot have core actions
like `DELETE` and `UPDATE` revoked.
But with an additional user we can revoke these actions to
ensure mutating actions don't occur accidentally (we will do this in step 2).

### 1. Getting started

Make a new Phoenix app:

```sh
mix phx.new append
```

Type `y` when asked if you want to install the dependencies,
then follow the instructions to `change directory`:

```sh
cd append
```

Then go into your generated config file. In `config/dev.exs`
and `config/test.exs` you should see a section that looks like this:

``` elixir
# Configure your database
config :append, Append.Repo
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

Define the [datetime type](https://hexdocs.pm/ecto/Ecto.Schema.html#module-the-datetime-types) for the timestamp.

```elixir
config :append, Append.Repo
  migration_timestamps: [type: :naive_datetime_usec],
  username: "postgres",
  password: "postgres",
```

Once you've done this, `create the database` for your app:

``` sh
mix ecto.create
```

### 2. Create the Schema

We're going to use an address book as an example.
run the following generator command to create our schema:

``` sh
mix phx.gen.schema Address addresses name:string address_line_1:string address_line_2:string city:string postcode:string tel:string
```

This will create two new files:
+ `lib/append/address.ex`
+ `priv/repo/migrations/{timestamp}_create_addresses.exs`

Before you follow the instructions in your terminal,
we'll need to edit the generated migration file.

The generated migration file should look like this:

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

We need to edit it to remove `update` and `delete` privileges for our user:

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

> For reference, this is what your migration file _should_ look like now:
[priv/repo/migrations/20180912142549_create_addresses.exs](https://github.com/dwyl/phoenix-ecto-append-only-log-example/pull/2/files#diff-db55bfd345510f8bbb29d36daadf7061R21)

In `lib/append/address.ex` file define the timestamps option to use the `naive_datetime_usec` type

```elixir
@timestamps_opts [type: :naive_datetime_usec]
schema "addresses" do
  ...
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

> **Note**: if you followed terminal instruction and ran `mix ecto.migrate`
**before** updating the migration file, you will need to run
[`mix ecto.drop`](https://hexdocs.pm/ecto/Mix.Tasks.Ecto.Drop.html#content)
and **first** update the migration file (_as per the instructions_)
and **then** run:
`mix ecto.create && mix ecto.migrate`.

### 3. Defining our Interface

Now that we have no way to delete or update the data,
we need to define the functions we'll use to access and insert the data.
To do this we'll define an
[Elixir behaviour](https://elixir-lang.org/getting-started/typespecs-and-behaviours.html#behaviours)
with some predefined functions.

The first thing we'll do is create the file for the behaviour.
Create a file called `lib/append/append_only_log.ex`
and add to it the following code:

``` elixir
defmodule Append.AppendOnlyLog do
  defmacro __using__(_opts) do
    quote do
      @behaviour Append.AppendOnlyLog

    end
  end
end
```

Here, we're creating a macro, and defining it as a behaviour.
The `__using__` macro is a callback that will be injected
into any module that calls `use Append.AppendOnlyLog`.
We'll define some functions in here that can be reused by different modules.
see: https://elixir-lang.org/getting-started/alias-require-and-import.html#use
for more info on the `__using__` macro.

The next step in defining a behaviour
is to provide some callbacks that must be provided.

``` elixir
defmodule Append.AppendOnlyLog do
  alias Append.Repo

  @callback insert
  @callback get
  @callback all
  @callback update
  @callback delete

  defmacro __using__(_opts) do
    ...
  end
end
```

These are the functions we'll define in this macro to interface with the database.
You may think it odd that we're defining an `update` function for our append-only
database, but we'll get to that later.

Callback definitions are similar to typespecs, in that you can provide the types
that the functions expect to receive as arguments, and what they will return.


``` elixir
defmodule Append.AppendOnlyLog do
  alias Append.Repo

  @callback insert(struct) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}
  @callback get(integer) :: Ecto.Schema.t() | nil | no_return()
  @callback all() :: [Ecto.Schema.t()]
  @callback update(Ecto.Schema.t(), struct) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}
  @callback delete(Ecto.Schema.t()) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}

  defmacro __using__(_opts) do
    quote do
      @behaviour Append.AppendOnlyLog

      def insert(attrs) do
      end

      def get(id) do
      end

      def all() do
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
  alias Append.Repo
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

Now this error may seem a little obtuse. The error is on line 4 of `address.ex`? That's:
``` elixir
use Append.AppendOnlyLog
```
That's because at compile time, this line is replaced with the contents of the
macro, meaning the compiler isn't sure exactly which line of the macro is causing
the error. This is one of the disadvantages of macros, and why they should be
kept short (and used sparingly).

Luckily, there is a way we can see the stack trace of the macro.
Add `location: :keep` to the `quote do`:

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

Now, if we run `mix test` again, we should see where the error _actually_ is:

``` sh
** (CompileError) lib/append/append_only_log.ex:20: Append.Address.__struct__/1 is undefined, cannot expand struct Append.Address
    (stdlib) lists.erl:1354: :lists.mapfoldl/3
    (elixir) expanding macro: Kernel.|>/2
```

Line 20 of `append_only_log.ex`:
``` elixir
%__MODULE__{}
```

So we see that trying to access the `Append.Address` struct is causing the error.
Now this function `Append.Address.__struct__/1` should be defined when we call:

``` elixir
schema "addresses" do
```

in the `Address` module. The problem lies in the way macros are injected into
modules, and the order functions are evaluated. We could solve this by moving the
`use Append.AppendOnlyLog` after the schema:

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

Now run `mix.test` and it should pass!
But something doesn't quite feel right.
We shouldn't need to include a 'use' macro halfway down a module to get our code to compile.
And we don't!
Elixir provides some fine grained control over the compile order of modules: https://hexdocs.pm/elixir/Module.html#module-module-attributes

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

      def all() do
      end

      def update(item, attrs) do
      end
    end
  end
end
```

So here we add `@before_compile unquote(__MODULE__)` to `__using__`.

`unquote(__MODULE__)` here, just means we want to use the `__before_compile__`
macro defined in _this_ module (`AppendOnlyLog`), _not_ the calling module (`Address`).

Then, the code we put inside `__before_compile__` will be injected at the _end_
of the calling module, meaning the schema will already be defined, and our tests should pass.

```
Finished in 0.1 seconds
4 tests, 0 failures
```

#### 4.2 Get/All

Now that we've done the _hard parts_, we'll implement the rest of the functionality
for our Append Only Log.

The `get` and `all` functions should be fairly simple, we just need to forward
the requests to the Repo. But first, some tests.

``` elixir
defmodule Append.AddressTest do
  ...
  describe "get items from database" do
    test "get/1" do
      {:ok, item} = insert_address()

      assert Address.get(item.id) == item
    end

    test "all/0" do
      {:ok, _item} = insert_address()
      {:ok, _item_2} = insert_address("Loki")

      assert length(Address.all()) == 2
    end
  end

  def insert_address(name \\ "Thor") do
    Address.insert(%{
      name: name,
      address_line_1: "The Hall",
      address_line_2: "Valhalla",
      city: "Asgard",
      postcode: "AS1 3DG",
      tel: "0800123123"
    })
  end
end
```

You'll see we've refactored the insert call into a function
so we can reuse it, and added some simple tests.
Run `mix test` and make sure they fail,
then we'll implement the functions.

``` elixir
defmodule Append.AppendOnlyLog do
  ...
  defmacro __before_compile__(_env) do
    quote do
      ...
      def get(id) do
        Repo.get(__MODULE__, id)
      end

      def all do
        Repo.all(__MODULE__)
      end
      ...
    end
  end
end
```

`mix test` again, and we should be all green.

#### 4.3 Update

Now we come to the update function. <br />
"But I thought we were only appending to the database?" I hear you ask. <br />
This is true, but we still need to relate our existing data to the new,
updated data we add.

To do this, we need to be able to reference the previous entry somehow.
The simplest (conceptually) way of doing this
is to provide a unique id to each entry.
Note that the id will be used to represent unique entries,
but it will not be unique in a table,
as revisions of entries will have the same id.
This is the simplest way we can link our entries,
but there may be some disadvantages,
which we'll look into later.

So, first we'll need to edit our schema
to add a shared id to our address entries:

``` elixir
defmodule Append.Address do
  ...
  schema "addresses" do
    ...
    field(:entry_id, :string)

    ...
  end

  def changeset(address, attrs) do
    address
    |> insert_entry_id()
    |> cast(attrs, [:name, :address_line_1, :address_line_2, :city, :postcode, :tel, :entry_id])
    |> validate_required([:name, :address_line_1, :address_line_2, :city, :postcode, :tel, :entry_id])
  end

  def insert_entry_id(address) do
    case Map.fetch(address, :entry_id) do
      {:ok, nil} -> %{address | entry_id: Ecto.UUID.generate()}
      _ -> address
    end
  end
end
```

We've added a function here that will generate a unique id, and add it to our item when it's created.

Then we create a migration file:

```
mix ecto.gen.migration add_entry_id
```

That created a file called
`priv/repo/migrations/20180914130516_add_entry_id.exs`

containing the following "blank" migration:
```elixir
defmodule Append.Repo.Migrations.AddEntryId do
  use Ecto.Migration

  def change do

  end
end
```
Add an `alter` definition to the `change` function body:

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
This is fairly explanatory: it alters the `addresses` table
to add the `entry_id` field.

Run the migration:
```
mix ecto.migrate
```
You should see the following in your terminal:
```sh
[info] == Running Append.Repo.Migrations.AddEntryId.change/0 forward
[info] alter table addresses
[info] == Migrated in 0.0s
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

If you attempt to _run_ this test with `mix test`,
you will see:
```sh
.....

  1) test update item in database (Append.AddressTest)
     test/append/address_test.exs:25
     ** (MatchError) no match of right hand side value: nil
     code: {:ok, updated_item} = Address.update(item, %{tel: "0123444444"})
     stacktrace:
       test/append/address_test.exs:28: (test)

..

Finished in 0.2 seconds
8 tests, 1 failure
```

Let's _implement_ the `update` function to make the test pass.

The update function itself will receive two arguments:
the existing item and a map of updated attributes.

Then we'll use the `insert` function
to create a new entry in the database,
rather than `update`,
which would overwrite the old one.

In your `/lib/append/append_only_log.ex` file add the following `def update`:
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

If we try to run our tests,
we will see the following error:

```
1) test update item in database (Append.AddressTest)
     test/append/address_test.exs:25
     ** (Ecto.ConstraintError) constraint error when attempting to insert struct:

         * unique: addresses_pkey
```
This is because we can't add the item again,
with the same unique id (`addresses_pkey`)
as it already exists in the database.

We need to "clear" the `:id` field _before_ attempting to update (insert):
``` elixir
def update(%__MODULE__{} = item, attrs) do
  item
  |> Map.put(:id, nil)
  |> Map.put(:inserted_at, nil)
  |> Map.put(:updated_at, nil)
  |> __MODULE__.changeset(attrs)
  |> Repo.insert()
end
```

So here we remove the original autogenerated id from the existing item,
preventing us from duplicating it in the database.

We also remove the `:inserted_at` and `:updated_at` fields. Again, if we leave those in, they'll be copied over from the old item, instead of being newly generated.

Now we'll add some more tests, making sure our code so far is working as we expect it to:

``` elixir
defmodule Append.AddressTest do
  ...
  test "get updated item" do
    {:ok, item} = insert_address()

    {:ok, updated_item} = Address.update(item, %{tel: "0123444444"})

    assert Address.get(item.id) == updated_item
  end

  test "all/0 does not include old items" do
    {:ok, item} = insert_address()
    {:ok, _} = insert_address("Loki")
    {:ok, _} = Address.update(item, %{postcode: "W2 3EC"})

    assert length(Address.all()) == 2
  end
  ...
end
```

Here we're testing that the items we receive from our 'get' and 'all' functions are the new, updated items.

Run this test and...

``` elixir
1) test get updated item (Append.AddressTest)
     test/append/address_test.exs:34
     Assertion with == failed
     code:  assert Address.get(item.id()) == updated_item
     left:  %Append.Address{... tel: "0800123123"}
     right: %Append.Address{... tel: "0123444444"}
     stacktrace:
       test/append/address_test.exs:39: (test)

2) test all/0 does not include old items (Append.AddressTest)
     test/append/address_test.exs:43
     Assertion with == failed
     code:  assert length(Address.all()) == 2
     left:  3
     right: 2
     stacktrace:
       test/append/address_test.exs:48: (test)
```

We're still getting the old items.

To fix this we'll have to revisit our `get` function.

``` elixir
def get(id) do
  Repo.get(__MODULE__, id)
end
```

The first issue is that we're still using the `id` to get the item. As we know, this `id` will always reference the same `version` of the item, meaning no matter how many times we update it, the `id` will still point to the original, unmodified item.

Luckily, we have another way to reference the item. Our `entry_id` that we created earlier. Let's use that in our query:

``` elixir
defmodule Append.AppendOnlyLog do
  alias Append.Repo
  require Ecto.Query

  ...
  defmacro __before_compile__(_env) do
    quote do
      import Ecto.Query

      ...
      def get(entry_id) do
        query =
          from(
            m in __MODULE__,
            where: m.entry_id == ^entry_id,
            select: m
          )

        Repo.one(query)
      end
    ...
    end
  end
end
```
You'll notice that we're now importing Ecto.Query. We have to make sure we import Ecto.Query inside our macro, so the scope matches where we end up calling it.

Don't forget to update the tests too:

``` elixir
...
test "get/1" do
  {:ok, item} = insert_address()

  assert Address.get(item.entry_id) == item
end
...
test "get updated item" do
  {:ok, item} = insert_address()

  {:ok, updated_item} = Address.update(item, %{tel: "0123444444"})

  assert Address.get(item.entry_id) == updated_item
end
...
```

Then we'll run the tests:

``` elixir
test get updated item (Append.AddressTest)
     test/append/address_test.exs:34
     ** (Ecto.MultipleResultsError) expected at most one result but got 2 in query:
```

Another error: "expected at most one result but got 2 in query"

Of course, this makes sense, we have two items with that entry id, but we only want one. The most recent one. Let's modify our query further:

``` elixir
def get(entry_id) do
  query =
    from(
      m in __MODULE__,
      where: m.entry_id == ^entry_id,
      order_by: [desc: :inserted_at],
      limit: 1,
      select: m
    )

  Repo.one(query)
end
```

This will order our items in descending order by the inserted date, and take the most recent one.

We'll use the same query in our `all` function, but replacing the `limit: 1` with `distinct: entry_id`:

``` elixir
def all do
  query =
    from(m in __MODULE__,
      distinct: m.entry_id,
      order_by: [desc: :inserted_at],
      select: m
    )

  Repo.all(query)
end
```

This ensures we get more than one item, but only the most recent of each `entry_id`.


#### 4.4 Get history

A useful part of our append-only database will be the functionality
to see the entire history of an item.

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

    history = Address.get_history(updated_item)

    assert length(history) == 2
    assert [h1, h2] = history
    assert h1.city == "Asgard"
    assert h2.city == "Oslo"
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
      import Ecto.Query

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

You'll notice the new callback definition at the top of the file.

Now run your tests, and you'll see that we're now able to view the whole history
of the changes of all items in our database.

#### 4.5 Delete

As you may realise, even though we are using an append only database, we still need some way to "delete" items.

Of course they won't actually be deleted, merely marked as "inactive", so they don't show anywhere unless we specifically want them to (For example in our history function).

To implement this functionality, we'll need to add a field to our schema, and to the cast function in our changeset.

``` elixir
defmodule Append.Address do
  schema "addresses" do
    ...
    field(:deleted, :boolean, default: false)
    ...
  end

  def changeset(address, attrs) do
    address
    |> insert_entry_id()
    |> cast(attrs, [
      ...,
      :deleted
    ])
    |> validate_required([
      ...
    ])
  end
end
```

and a new migration:
```
mix ecto.gen.migration add_deleted
```

``` elixir
defmodule Append.Repo.Migrations.AddDeleted do
  use Ecto.Migration

  def change do
    alter table("addresses") do
      add(:deleted, :boolean, default: false)
    end
  end
end
```

This adds a `boolean` field, with a default value of `false`. We'll use this to determine whether a given item is "deleted" or not.

As usual, before we implement it, we'll add a test for our expected functionality.

``` elixir
describe "delete:" do
    test "deleted items are not retrieved with 'get'" do
      {:ok, item} = insert_address()
      {:ok, _} = Address.delete(item)

      assert Address.get(item.entry_id) == nil
    end

    test "deleted items are not retrieved with 'all'" do
      {:ok, item} = insert_address()
      {:ok, _} = Address.delete(item)

      assert length(Address.all()) == 0
    end
  end
```

Our delete function is fairly simple:

``` elixir
def delete(%__MODULE__{} = item) do
  item
  |> Map.put(:id, nil)
  |> Map.put(:inserted_at, nil)
  |> Map.put(:updated_at, nil)
  |> __MODULE__.changeset(%{deleted: true})
  |> Repo.insert()
end
```

It acts just the same as the update function, but adds a value of `deleted: true`. But this is only half of the story.

We also need to make sure we don't return any deleted items when they're requested. So again, we'll have to edit our `get` and `all` functions:

``` elixir
def get(entry_id) do
  sub =
    from(
      m in __MODULE__,
      where: m.entry_id == ^entry_id,
      order_by: [desc: :inserted_at],
      limit: 1,
      select: m
    )

  query = from(m in subquery(sub), where: not m.deleted, select: m)

  Repo.one(query)
end

def all do
  sub =
    from(m in __MODULE__,
      distinct: m.entry_id,
      order_by: [desc: :inserted_at],
      select: m
    )

  query = from(m in subquery(sub), where: not m.deleted, select: m)

  Repo.all(query)
end
```

What we're doing here is taking our original query, then performing another query on the result of that, only returning the item if it has not been marked as `deleted`.

So now, when we run our tests, we should see that we're succesfully ignoring "deleted" items.
