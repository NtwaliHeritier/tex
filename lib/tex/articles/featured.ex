defmodule Tex.Articles.Featured do
    import Plug.Conn
    import Ecto.Query
    alias Tex.Articles.Post
    alias Tex.Repo

    def liked_posts(conn, _) do
        posts = Post
                |> limit(2)
                |> Repo.all
                |> Repo.preload(user: :account)
                |> Repo.preload(:likes)
                |> Repo.preload(:views)
        assign(conn, :liked_posts, posts)
    end

    def viewed_posts(conn, _) do
        posts = Post
                |> limit(2)
                |> Repo.all
                |> Repo.preload(user: :account)
                |> Repo.preload(:likes)
                |> Repo.preload(:views)
        assign(conn, :viewed_posts, posts)
    end
end