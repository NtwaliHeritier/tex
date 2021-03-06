defmodule TexWeb.PostController do
  use TexWeb, :controller
  import Tex.Friendship.InvitationsHandling
  import Tex.Articles.Featured
  plug :liked_posts
  plug :viewed_posts
  plug :unconfirmed_invitations

  alias Tex.Articles
  alias Tex.Articles.Post

  import TexWeb.UserAuth, only: [require_authenticated_user: 2]
  plug :require_authenticated_user

  def index(conn, _params) do
    posts = Articles.list_posts()
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = Articles.change_post(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    {:ok, %Cloudex.UploadedImage{public_id: pid}} = Cloudex.upload(post_params["image"].path)
    post_params = Map.put(post_params, "image", pid)
    case Articles.create_post(conn.assigns.current_user, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Articles.get_post!(id)
    conn
    |> assign(:post, post)
    |> render("show.html")
  end

  def edit(conn, %{"id" => id}) do
    post = Articles.get_post!(id)
    changeset = Articles.change_post(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Articles.get_post!(id)

    case Articles.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Articles.get_post!(id)
    {:ok, _post} = Articles.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: Routes.post_path(conn, :index))
  end
end
