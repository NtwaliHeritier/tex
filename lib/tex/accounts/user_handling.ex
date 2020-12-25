defmodule Tex.Accounts.UserHandling do
    alias Tex.Accounts.User
    alias Tex.Articles.{Like, Post}
    alias Tex.Friendship.Invitation
    alias Tex.Repo
    import Ecto.Query

    def get_user_account_info(user) do
        User
        |> Repo.get!(user.id)
        |> Repo.preload(:account)
        |> Repo.preload(:followees)
        |> Repo.preload(posts: [:likes, :comments, :views, user: :account])
    end

    def get_followee_posts(user) do
        current_user = User |> Repo.get!(user.id) |> Repo.preload(:followees)
        followee_ids = get_followee_id(current_user.followees, [])
        query = from(p in Post, where: p.user_id == ^current_user.id or p.user_id in ^followee_ids)
        query
        |> Repo.all
        |> Repo.preload([:likes, :comments, :views, user: :account])
    end

    def get_followee_id([], list), do: list

    def get_followee_id(followees, list) do
        list = list ++ [hd(followees).id]
        get_followee_id(tl(followees), list)
    end

    def get_count(invitations, _user_id, a) when invitations == [], do: a

    def get_count(invitations, user_id, a) do
       [ head | tail ] = invitations
       if (head.invitee_id == user_id ) do
            get_count(tail, user_id, a + 1)
       else
            get_count(tail, user_id, a)
        end
    end

    def get_post(user, post) do
        query = from(l in Like, where: l.user_id == ^user.id and l.post_id == ^post.id)
        Repo.all(query)
    end

    def get_follow_info(follower, followee) do
        query = from(f in Invitation, where: f.invitor_id == ^follower.id and f.invitee_id == ^followee.id)
        Repo.all(query)
    end

    def get_all(current_user) do
        query = from(u in User, where: u.id != ^current_user.id)
        query
        |> Repo.all
        |> Repo.preload(:account)
    end
end
