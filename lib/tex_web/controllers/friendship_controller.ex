defmodule TexWeb.FriendshipController do
    use TexWeb, :controller
    alias Tex.Friendship
    def create(conn, %{"friendship" => friendship_params}) do
        invitation_id = Map.get(friendship_params, "invitation_id")
        friendship_params = Map.delete(friendship_params, "invitation_id")
        case Friendship.create_friend(friendship_params) do
            {:ok, _} ->
                invitation = Friendship.get_invitation!(invitation_id)
                invitee = Map.get(invitation, :invitee_id)
                invitor = Map.get(invitation, :invitor_id)
                updated_invitation = %{}
                updated_invitation = Map.put(updated_invitation, :status, true)
                updated_invitation = Map.put(updated_invitation, :invitee_id, invitee)
                updated_invitation = Map.put(updated_invitation, :invitor_id, invitor)
                Friendship.update_invitation(invitation, updated_invitation)
                conn
                |> put_flash(:info, "Follower added")
                |> redirect(to: "/")
            {:error, _} ->
                conn
                |> put_flash(:error, "Follower not added")
                |> redirect(to: "/")
        end
    end
end