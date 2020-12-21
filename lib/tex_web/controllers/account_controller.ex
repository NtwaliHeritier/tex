defmodule TexWeb.AccountController do
    use TexWeb, :controller
    alias Tex.Accounts

    def show(conn, %{"id" => id}) do
        account = Accounts.get_account!(id)
        render(conn, :show, account: account)
    end
end