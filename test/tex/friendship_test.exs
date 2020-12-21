defmodule Tex.FriendshipTest do
  use Tex.DataCase

  alias Tex.Friendship

  describe "invitations" do
    alias Tex.Friendship.Invitation

    @valid_attrs %{invitee_id: 42, invitor_id: 42, status: true}
    @update_attrs %{invitee_id: 43, invitor_id: 43, status: false}
    @invalid_attrs %{invitee_id: nil, invitor_id: nil, status: nil}

    def invitation_fixture(attrs \\ %{}) do
      {:ok, invitation} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Friendship.create_invitation()

      invitation
    end

    test "list_invitations/0 returns all invitations" do
      invitation = invitation_fixture()
      assert Friendship.list_invitations() == [invitation]
    end

    test "get_invitation!/1 returns the invitation with given id" do
      invitation = invitation_fixture()
      assert Friendship.get_invitation!(invitation.id) == invitation
    end

    test "create_invitation/1 with valid data creates a invitation" do
      assert {:ok, %Invitation{} = invitation} = Friendship.create_invitation(@valid_attrs)
      assert invitation.invitee_id == 42
      assert invitation.invitor_id == 42
      assert invitation.status == true
    end

    test "create_invitation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Friendship.create_invitation(@invalid_attrs)
    end

    test "update_invitation/2 with valid data updates the invitation" do
      invitation = invitation_fixture()
      assert {:ok, %Invitation{} = invitation} = Friendship.update_invitation(invitation, @update_attrs)
      assert invitation.invitee_id == 43
      assert invitation.invitor_id == 43
      assert invitation.status == false
    end

    test "update_invitation/2 with invalid data returns error changeset" do
      invitation = invitation_fixture()
      assert {:error, %Ecto.Changeset{}} = Friendship.update_invitation(invitation, @invalid_attrs)
      assert invitation == Friendship.get_invitation!(invitation.id)
    end

    test "delete_invitation/1 deletes the invitation" do
      invitation = invitation_fixture()
      assert {:ok, %Invitation{}} = Friendship.delete_invitation(invitation)
      assert_raise Ecto.NoResultsError, fn -> Friendship.get_invitation!(invitation.id) end
    end

    test "change_invitation/1 returns a invitation changeset" do
      invitation = invitation_fixture()
      assert %Ecto.Changeset{} = Friendship.change_invitation(invitation)
    end
  end
end
