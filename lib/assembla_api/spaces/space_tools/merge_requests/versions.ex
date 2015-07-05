defmodule AssemblaApi.Spaces.SpaceTools.MergeRequests.Versions do
  alias AssemblaApi.Request

  defmodule Version do
    defstruct [:applied_at, :apply_status, :created_at, :id, :latest, :merge_request_id,
               :source_revision, :target_revision, :updated_at, :url, :user_id, :version]
    @type t :: %Version{id: integer, applied_at: binary | nil, created_at: String.t,
                        latest: boolean, merge_request_id: integer, source_revision: String.t,
                        target_revision: String.t, updated_at: String.t, url: String.t,
                        user_id: String.t, version: integer}
  end

  def list(space_id, tool_id, mr_id) do
    {:ok, %{body: body, headers: _hdrs, status_code: 200}} =
      Request.get("/spaces/#{space_id}/space_tools/#{tool_id}/merge_requests/#{mr_id}/versions")
    #IO.puts inspect(body)

    result = Poison.Decode.decode(body, as: [Version])
    {:ok, result}
  end

  def get(space_id, tool_id, mr_id, version) do
    {:ok, %{body: body, headers: _hdrs, status_code: 200}} =
      Request.get("/spaces/#{space_id}/space_tools/#{tool_id}/merge_requests/#{mr_id}/versions/#{version}")
    result = Poison.Decode.decode(body, as: Version)
    {:ok, result}
  end

  def new(space_id, tool_id, mr_id) do
    {:ok, %{body: body, headers: _hdrs, status_code: status}} =
      Request.post("/spaces/#{space_id}/space_tools/#{tool_id}/merge_requests/#{mr_id}/versions", "")

    case status do
      201 -> {:ok, Poison.Decode.decode(body, as: Version)}
      _   -> {:error, body}
    end
  end
end
