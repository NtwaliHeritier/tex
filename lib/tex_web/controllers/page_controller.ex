defmodule TexWeb.PageController do
  use TexWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
