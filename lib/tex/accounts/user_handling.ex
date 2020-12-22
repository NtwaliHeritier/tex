defmodule Tex.Accounts.UserHandling do
    alias Tex.Accounts.User
    alias Tex.Articles.Like
    alias Tex.Friendship.Friend
    alias Tex.Repo
    import Ecto.Query

    def get_user_account_info(user) do
        User
        |> Repo.get!(user.id)
        |> Repo.preload([:account, :followees])
        |> Repo.preload(posts: [:likes, :comments, :views, user: :account])
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
        query = from(f in Friend, where: f.follower_id == ^follower.id and f.followee_id == ^followee.id)
        Repo.all(query)
    end
end
