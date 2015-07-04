defmodule AssemblaApi.Spaces do
  alias AssemblaApi.Request

  # http://api-docs.assembla.com/content/ref/space_fields.html
  defmodule Space do
    defstruct [:id, :name, :wiki_name, :description, :approved, :parent_id,
               :created_at, :updated_at,
               :banner, :banner_height, :banner_link, :banner_text,
               :can_apply, :can_join, :commercial_from, :default_showpage,
               :is_commercial, :is_manager, :is_volunteer,
               :last_payer_changed_at, :restricted, :restricted_date,
               :status, :style, :tabs_order, :team_tab_role,
               :public_permissions, :share_permissions, :team_permissions, :watcher_permissions
  ]
  end

  def list do
    # TODO handle 204 status code
    {:ok, %{body: body, status_code: 200}} = Request.get("/spaces")
    IO.puts inspect body
    result = Poison.Decode.decode(body, as: [Space])
    {:ok, result}
  end

  def get(space_id) do
    # TODO Catch 404
    {:ok, %{body: body, status_code: 200}} = Request.get("/spaces/#{space_id}")
    result = Poison.Decode.decode(body, as: Space)
    {:ok, result}
  end
end
