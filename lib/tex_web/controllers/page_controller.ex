defmodule TexWeb.PageController do
  use TexWeb, :controller
  import TexWeb.UserAuth, only: [require_authenticated_user: 2]
  plug :require_authenticated_user

  def index(conn, _params) do
    IO.inspect "---------------------------"
    IO.inspect conn.assigns.current_user.id
    IO.inspect "---------------------------"
    render(conn, "index.html")
  end
end
