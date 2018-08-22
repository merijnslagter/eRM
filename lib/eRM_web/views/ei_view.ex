defmodule ERMWeb.EIView do
  use ERMWeb, :view

  def render("index.json", %{eis: eis}) do
    %{data: render_many(eis, ERMWeb.EIView, "ei.json")}
  end

  def render("show.json", %{ei: ei}) do
    %{data: render_one(ei, ERMWeb.EIView, "ei.json")}
  end

  def render("ei.json", %{ei: ei}) do
    {lat, long} = if(ei.geom) do
      ei.geom.coordinates
    else
      {nil, nil}
    end
    %{id: ei.id, description: ei.description, lat: lat, long: long}
  end

  def render("info.json", %{ei_id: ei_id}) do
    ei = ERM.Cooperation.get_e2!(ei_id)
    %{data: render_one(ei, ERMWeb.EIView, "ei.json")}
  end
end
