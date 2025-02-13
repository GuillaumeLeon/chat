defmodule ChatWeb.RoomsLive do
  alias Chat.{Repo, Room}

  use ChatWeb, :live_view

  def render (assigns) do
    ~H"""
    <p>Room list </p>
    <%= for room <- @rooms do %> 
      <.link navigate={~p"/room/#{room.id}"}>
      <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
      {room.name}
      </button>
      </.link>
      <% end %>
    """
  end

  def mount(_, _, socket) do
    {:ok, assign(socket, :rooms, Repo.all(Room))}
  end
end
