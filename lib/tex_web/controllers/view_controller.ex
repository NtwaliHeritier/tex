defmodule TexWeb.ViewController do
    use TexWeb, :controller
    alias Tex.Articles
    def create(conn, %{"view" => %{"post_id" => post_id}}) do
        post_id = String.to_integer(post_id)
        user_id = conn.assigns.current_user.id
        case Articles.create_view(user_id, post_id) do
            {:ok, _} ->
                post = Articles.get_post!(post_id)
                conn
                |> redirect(to: Routes.post_path(conn, :show, post))
            {:error, _} ->
                conn
                |> put_flash(:error, "Please try again")
        end
    end
end