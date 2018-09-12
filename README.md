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

```
mix ecto.create
```

### 2. Create the Schema

We're going to use an address book as an example. run the following generator command to create our schema:

```
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
```
mix ecto.migrate
```
and you should see the following output:
```
[info] == Running Append.Repo.Migrations.CreateAddresses.change/0 forward
[info] create table addresses
[info] execute "REVOKE UPDATE, DELETE ON TABLE addresses FROM append_only"
[info] == Migrated in 0.0s
```
