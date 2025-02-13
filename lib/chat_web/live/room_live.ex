defmodule ChatWeb.RoomLive do
  alias Chat.{Repo, Room}

  use ChatWeb, :live_view

  def render (assigns) do
    ~H"""
    <p>Rooms thingy</p>
    We are on room: {@room.id}
    """
  end

  def mount(%{"id" => id}, _, socket) do

    room = Repo.get(Room, id)

    {:ok, assign(socket, :room, room)}
  end
end
