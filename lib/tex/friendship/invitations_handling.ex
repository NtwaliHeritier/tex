defmodule Tex.Friendship.InvitationsHandling do
    alias Tex.Friendship.Invitation
    alias Tex.Repo
    import Ecto.Query
    import Plug.Conn
    
    def unconfirmed_invitations(conn, _) do
        query = from(i in Invitation, where: i.status == false, preload: [invitor: :account, invitee: :account])
        unconfirmed_invitations = Repo.all(query)
        assign(conn, :unconfirmed_invitations, unconfirmed_invitations)
    end
end