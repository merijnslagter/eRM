defmodule ERMWeb.MapChannel do
  use Phoenix.Channel

  def join("map:lobby", _message, socket) do
    IO.puts "map socket lobby join"
    # get EI projects and send to channel
    Process.send_after(self(), :do_init, 0)
    {:ok, socket}
  end
  def join("map:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_info(:do_init, socket) do
    IO.puts "do_init"
    eis = ERM.Cooperation.list_e2s()
    return = ERMWeb.EIView.render("index.json", %{eis: eis})
    # todo return rendered html
    push socket, "eis:list", return
    IO.inspect return
    {:noreply, socket}
  end

  def handle_in("ei:selected", %{"ei_id" => ei_id}, socket) do
    #broadcast! socket, "new_msg", %{body: body}
    IO.puts "EID selected on map: #{inspect(ei_id)}"
    # get ei data and render
    #return = ERMWeb.EIView.render("info.json", %{ei_id: ei_id})
    ei = %{ei_id: ei_id}
    html = Phoenix.View.render_to_string(ERMWeb.PageView, "e3interaction.html", ei: ei)
    IO.inspect(html)
    push socket, "ei:selected", %{html: html}
    {:noreply, socket}
  end
end
