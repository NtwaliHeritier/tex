defmodule Tex.Accounts.UserHandling do
    alias Tex.Accounts
    alias Tex.Articles.Like
    alias Tex.Repo
    import Ecto.Query
    def get_user_account_info(user) do
        Accounts.get_user!(user.id)
    end

    def get_count(invitations, user_id, a) when invitations == [], do: a

    def get_count(invitations, user_id, a) do
       [ head | tail ] = invitations
       if (head.invitee_id == user_id ) do
            get_count(tail, user_id, a = a + 1)
       else
            get_count(tail, user_id, a)
        end
    end

    def get_post(user, post) do
        query = from(l in Like, where: l.user_id == ^user.id and l.post_id == ^post.id)
        Repo.all(query)
    end
end