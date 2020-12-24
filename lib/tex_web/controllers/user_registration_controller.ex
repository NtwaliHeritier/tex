defmodule TexWeb.UserRegistrationController do
  use TexWeb, :controller

  alias Tex.Accounts
  alias Tex.Accounts.User
  alias TexWeb.UserAuth

  def new(conn, _params) do
    changeset = Accounts.change_user_registration(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    {:ok, %Cloudex.UploadedImage{public_id: pid}} = Cloudex.upload(user_params["account"]["image_path"].path)
    %{"account" => account_params} = user_params
    account_params = Map.put(account_params, "image_path", pid)
    user_params = Map.put(user_params, "account", account_params)
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            user,
            &Routes.user_confirmation_url(conn, :confirm, &1)
          )
        conn
        |> put_flash(:info, "User created successfully.")
        |> UserAuth.log_in_user(user)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
