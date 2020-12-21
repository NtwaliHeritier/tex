defmodule TexWeb.FriendshipController do
    use TexWeb, :controller
    alias Tex.Friendship
    def create(conn, %{"friendship" => friendship_params}) do
        case Friendship.create_friend(friendship_params) do
            {:ok, _} ->
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