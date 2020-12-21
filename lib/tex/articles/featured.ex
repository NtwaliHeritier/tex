defmodule Tex.Articles.Featured do
    import Plug.Conn
    import Ecto.Query
    alias Tex.Articles.{Post, Like, View}
    alias Tex.Repo

    def liked_posts(conn, _) do
        query = from(p in Post, join: l in Like, on: p.id==l.post_id, limit: 2, group_by: p.id, order_by: [desc: count(l.id)])
        posts = Repo.all(query) |> Repo.preload(:likes) |> Repo.preload(user: :account) |> Repo.preload(:views)
        assign(conn, :liked_posts, posts)
    end

    def viewed_posts(conn, _) do
        query = from(p in Post, join: v in View, on: p.id==v.post_id, limit: 2, group_by: p.id, order_by: [desc: count(v.id)])
        posts = Repo.all(query) |> Repo.preload(:likes) |> Repo.preload(user: :account) |> Repo.preload(:views)
        assign(conn, :viewed_posts, posts)
    end
end