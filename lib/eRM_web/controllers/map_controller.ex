defmodule ERMWeb.MapController do
  use ERMWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
