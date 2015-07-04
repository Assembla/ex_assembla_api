defmodule AssemblaApi.Spaces.SpaceTools do
  alias AssemblaApi.Request

  defmodule SpaceTool do
    defstruct [:id, :name, :active,
               :created_at,
               :menu_name, :number, :url,
               :space_id, :parent_id,
               :public_permissions, :team_permissions, :watcher_permissions,
               :tool_id, :type]
  end

  def list(space_id) do
    # TODO handle 404
    {:ok, %{body: body, status_code: 200}} = Request.get("/spaces/#{space_id}/space_tools")
    result = Poison.Decode.decode(body, as: [SpaceTool])
    {:ok, result}
  end

  def get(space_id, id) do
    {:ok, %{body: body, status_code: 200}} = Request.get("/spaces/#{space_id}/space_tools/#{id}")
    result = Poison.Decode.decode(body, as: SpaceTool)
    {:ok, result}
  end

  def meta do
    {:ok, %{body: body, status_code: 200}} = Request.get("/meta/space_tools")
    body
  end
end
