defmodule ChatWeb.RoomLive do
  alias Chat.{Repo, Room}

  use ChatWeb, :live_view

  def render (assigns) do
    ~H"""
    <p>Rooms thingy</p>
    We are on room: {@room.id}

    <h1>List of messages in the room</h1>

    <div class="container p-2">
    <%= for message <- @room.messages do %>
      <div class="bg-blue-500 w-40 text-white p-4 rounded">
      <p class="capitalize font-bold">{message.from}</p>
      {message.content}
      </div>
    <% end %>
    </div>
    """
  end

  def mount(%{"id" => id}, _, socket) do

    room = Repo.get(Room, id) |> Repo.preload(:messages)

    {:ok, assign(socket, :room, room)}
  end
end
