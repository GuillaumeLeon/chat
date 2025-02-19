defmodule ChatWeb.RoomLive do
  alias Expo.Message
  alias Ecto.Repo
  alias Expo.Message
  alias Ecto.Repo
  alias Expo.Message
  alias Ecto.Repo
  alias Chat.{Repo, Room, Message}

  use ChatWeb, :live_view

  def render (assigns) do
    ~H"""
    <p>Rooms thingy</p>
    We are on room: {@room.id}

    <h1>List of messages in the room</h1>

    <div class="container p-2">
      <%= for message <- @messages do %>
        <div class={message.classes}>
         <p class="font-bold">{message.user.email}</p>
        {message.content}
        </div>
        <% end %>

    </div>

      <.form for={@form} phx-submit="save">
        <.input type="text" field={@form[:message]}/>
        <button>send</button>
      </.form>
    """
  end

  def mount(%{"id" => id}, _params, socket) do

    room = Repo.get(Room, id) 
      |> Repo.preload([messages: [:user]])

    user = socket.assigns.current_user

    messages = Enum.map(room.messages, fn m -> generate_class(m, user) end)

    {:ok, assign(socket, %{:room => room, :messages => messages, :user => user, :form => to_form(%{})})}
  end

  def handle_event("save", %{"message" => message}, socket) do
    room = socket.assigns.room

    %Message{content: message}
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:room, room)
    |> Ecto.Changeset.put_assoc(:user, socket.assigns.current_user)
    |> Repo.insert!()

    IO.inspect(Repo.all(Message))
    {:noreply, assign(socket, form: to_form(%{}))}
  end

  def generate_class(message, user) do
    classes = get_class(message, user)

    Map.put(message, :classes, classes)
  end

  defp get_class(message, user) do
    base = "bg-blue-500 w-40 text-white p-4 rounded break-words"
     cond do 
      message.user_id == user.id -> base <> " " <> "bg-slate-500 ml-auto"
        true -> base
    end
  end
end
