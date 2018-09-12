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

### Getting started

Make a new Phoenix app:

```
mix phx.new append
```

Type `y` when asked if you want to install the dependencies, then follow the instructions to `change directory`:

```
cd append
```

then `create the database` for your app:

```
mix ecto.create
```
