defmodule ChatWeb.RoomLive do
  alias Chat.{Repo, Room, Message}

  use ChatWeb, :live_view

  def render (assigns) do
    ~H"""
    <p>Rooms thingy</p>
    We are on room: {@room.id}

    <h1>List of messages in the room</h1>

    <div class="container p-2">
      <%= for message <- @room.messages do %>
        <div class="bg-blue-500 w-40 text-white p-4 rounded">
        <p class="capitalize font-bold">{message.user.email}</p>
        {message.content}
        </div>
        <% end %>

      <.form for={@form} phx-submit="save">
        <.input type="text" field={@form[:message]}/>
        <button>send</button>
      </.form>
    </div>
    """
  end

  def mount(%{"id" => id}, p, socket) do

    room = Repo.get(Room, id) 
      |> Repo.preload([messages: [:user]])

    IO.inspect(p)
    {:ok, assign(socket, %{:room => room, :form => to_form(%{})})}
  end

  def handle_event("save", %{"message" => message}, socket) do
      current_user = socket.assigns.current_user
    IO.inspect(message)
    IO.inspect(current_user)
    {:noreply, socket}
  end
end
