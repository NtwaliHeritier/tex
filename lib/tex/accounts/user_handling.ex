defmodule Tex.Accounts.UserHandling do
    alias Tex.Accounts
    def get_user_account_info(user) do
        Accounts.get_user!(user.id)
    end
end