defmodule Chat.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "message" do
    field :from, :string
    field :content, :string
    belongs_to :user, Chat.Accounts.User
    belongs_to :room, Chat.Room

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:content, :from, :room_id, :user_id])
    |> validate_required([:content, :from, :room_id])
  end
end
