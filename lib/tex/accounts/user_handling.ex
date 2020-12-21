defmodule Tex.Accounts.UserHandling do
    alias Tex.Accounts
    def get_user_account_info(user) do
        Accounts.get_user!(user.id)
    end

    def get_count(invitations, user_id, a) when invitations == [], do: a

    def get_count(invitations, user_id, a) do
       [ head | tail ] = invitations
       if (head.invitee.id == user_id ) do
            get_count(tail, user_id, a = a + 1)
       else
            get_count(tail, user_id, a)
        end
    end
end