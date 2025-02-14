defmodule Chat.Repo.Migrations.CreateMessage do
  use Ecto.Migration

  def change do
    create table(:message) do
      add :content, :string
      add :from, :string
      add :room_id, references(:rooms)

      timestamps(type: :utc_datetime)
    end
  end
end
