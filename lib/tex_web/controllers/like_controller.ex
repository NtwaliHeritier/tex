defmodule TexWeb.LikeController do
    use TexWeb, :controller
    alias Tex.Articles

    def create(conn, %{"like" => %{"post" => post_id, "user" => user_id}}) do
        case Articles.create_like(String.to_integer(post_id), String.to_integer(user_id)) do
            {:ok, _} ->
                post = Articles.get_post!(String.to_integer(post_id))
                conn
                |> put_flash(:info, "Like added")
                |> redirect(to: Routes.post_path(conn, :show, post))
            {:error, _} ->
                conn
                |> put_flash(:error, "Like not added")
        end     
    end
end