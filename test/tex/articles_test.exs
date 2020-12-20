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

  describe "likes" do
    alias Tex.Articles.Like

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def like_fixture(attrs \\ %{}) do
      {:ok, like} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Articles.create_like()

      like
    end

    test "list_likes/0 returns all likes" do
      like = like_fixture()
      assert Articles.list_likes() == [like]
    end

    test "get_like!/1 returns the like with given id" do
      like = like_fixture()
      assert Articles.get_like!(like.id) == like
    end

    test "create_like/1 with valid data creates a like" do
      assert {:ok, %Like{} = like} = Articles.create_like(@valid_attrs)
    end

    test "create_like/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Articles.create_like(@invalid_attrs)
    end

    test "update_like/2 with valid data updates the like" do
      like = like_fixture()
      assert {:ok, %Like{} = like} = Articles.update_like(like, @update_attrs)
    end

    test "update_like/2 with invalid data returns error changeset" do
      like = like_fixture()
      assert {:error, %Ecto.Changeset{}} = Articles.update_like(like, @invalid_attrs)
      assert like == Articles.get_like!(like.id)
    end

    test "delete_like/1 deletes the like" do
      like = like_fixture()
      assert {:ok, %Like{}} = Articles.delete_like(like)
      assert_raise Ecto.NoResultsError, fn -> Articles.get_like!(like.id) end
    end

    test "change_like/1 returns a like changeset" do
      like = like_fixture()
      assert %Ecto.Changeset{} = Articles.change_like(like)
    end
  end
end
