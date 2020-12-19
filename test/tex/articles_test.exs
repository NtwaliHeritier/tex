defmodule Tex.ArticlesTest do
  use Tex.DataCase

  alias Tex.Articles

  describe "posts" do
    alias Tex.Articles.Post

    @valid_attrs %{content: "some content", image: "some image", title: "some title"}
    @update_attrs %{content: "some updated content", image: "some updated image", title: "some updated title"}
    @invalid_attrs %{content: nil, image: nil, title: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Articles.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Articles.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Articles.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Articles.create_post(@valid_attrs)
      assert post.content == "some content"
      assert post.image == "some image"
      assert post.title == "some title"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Articles.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = Articles.update_post(post, @update_attrs)
      assert post.content == "some updated content"
      assert post.image == "some updated image"
      assert post.title == "some updated title"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Articles.update_post(post, @invalid_attrs)
      assert post == Articles.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Articles.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Articles.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Articles.change_post(post)
    end
  end
end
