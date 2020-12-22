defmodule TexWeb.CommentController do
    use TexWeb, :controller
    alias Tex.Articles

    def create(conn, %{"comment" => %{"content" => content_params, "post_id" => post_id}}) do
        post_id = String.to_integer(post_id)
        user_id = conn.assigns[:current_user].id
        case Articles.create_comment(user_id, post_id, %{"content" => content_params}) do
            {:ok, _} ->
                post = Articles.get_post!(post_id)
                conn
                |> put_flash(:info, "Comment added")
                |> redirect(to: Routes.post_path(conn, :show, post))
            {:error, _} ->
                conn
                |> put_flash(:error, "Comment not added")
        end
    end
end