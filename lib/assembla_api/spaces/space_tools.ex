defmodule AssemblaApi.Spaces.SpaceTools do
  alias AssemblaApi.Request

  @doc """
  Struct module to hold space tool data.
  """
  defmodule SpaceTool do
    defstruct [:id, :name, :active,
               :created_at,
               :menu_name, :number, :url,
               :space_id, :parent_id,
               :public_permissions, :team_permissions, :watcher_permissions,
               :tool_id, :type]
    @type t :: %SpaceTool{id: String.t, name: String.t, active: boolean, created_at: String.t,
                          menu_name: String.t, number: integer, url: String.t, space_id: String.t,
                          parent_id: String.t, public_permissions: integer,
                          team_permissions: integer, watcher_permissions: integer, tool_id: integer,
                          type: String.t}
  end

  @doc """
  Returns space tool list from `space_id`.
  """
  @spec list(String.t) :: [SpaceTool.t]
  def list(space_id) do
    # TODO handle 404
    {:ok, %{body: body, status_code: 200}} = Request.get("/spaces/#{space_id}/space_tools")
    result = Poison.Decode.decode(body, as: [SpaceTool])
    {:ok, result}
  end

  @doc """
  Returns space tool by `space_id` or `menu_name`.
  """
  @spec get(String.t, String.t) :: SpaceTool.t
  def get(space_id, id) do
    {:ok, %{body: body, status_code: 200}} = Request.get("/spaces/#{space_id}/space_tools/#{id}")
    result = Poison.Decode.decode(body, as: SpaceTool)
    {:ok, result}
  end

  @doc """
  Returns metadata information for space tool records.
  """
  @spec meta :: map
  def meta do
    {:ok, %{body: body, status_code: 200}} = Request.get("/meta/space_tools")
    body
  end
end
