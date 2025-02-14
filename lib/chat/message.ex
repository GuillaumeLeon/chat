defmodule Chat.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "message" do
    field :from, :string
    field :content, :string
    belongs_to :room, EctoAssoc.Room

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:content, :from, :room_id])
    |> validate_required([:content, :from, :room_id])
  end
end
