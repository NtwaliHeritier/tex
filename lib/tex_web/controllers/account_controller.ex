defmodule TexWeb.AccountController do
    use TexWeb, :controller
    import Tex.Friendship.InvitationsHandling
    use TexWeb, :controller
    alias Tex.Accounts
    plug :unconfirmed_invitations

    def show(conn, %{"id" => id}) do
        account = Accounts.get_account!(id)
        render(conn, :show, account: account)
    end
end