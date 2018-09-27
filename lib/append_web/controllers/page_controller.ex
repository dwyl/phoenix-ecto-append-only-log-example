defmodule AppendWeb.PageController do
  use AppendWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
