defmodule TexWeb.InvitationController do
    use TexWeb, :controller
    alias Tex.Friendship

    def create(conn, %{"invitation" => invitation_params}) do
        case Friendship.create_invitation(invitation_params) do
            {:ok, _} ->
                conn
                |> put_flash(:info, "Invitation sent")
                |> redirect(to: "/")
            {:error, _} ->
                conn
                |> put_flash(:error, "Invitation not sent")
                |> redirect(to: "/")
        end
    end
end