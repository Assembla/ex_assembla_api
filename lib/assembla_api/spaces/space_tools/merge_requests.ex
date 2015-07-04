defmodule AssemblaApi.Spaces.SpaceTools.MergeRequests do
  alias AssemblaApi.Request

  defmodule MergeRequest do
    defstruct [:id, :commit, :description, :processed_by_user_id,
               :source_symbol,
               # source_symbol_type(1 - Branch, 2 - Tag, 3 - Revision)
               :source_symbol_type, :space_tool_id, :status,
               :target_space_id, :target_space_tool_id, :target_symbol, :title,
               :created_at, :updated_at, :url, :user_id]
    @type t :: %MergeRequest{id: integer, commit: binary, description: binary}
  end

  @doc """
  Lists merge request by `space_id` and `tool_id` and `params`

  options page, per_page, status: :open, :closed, :ignored
  per_page default to 10
  """
  @spec list(String.t, String.t, map) :: [MergeRequest.t]
  def list(space_id, tool_id, params \\ %{}) do
    {:ok, %{body: body, headers: _hdrs, status_code: 200}} =
      Request.get(url(space_id, tool_id), [], params: params)

    result = Poison.Decode.decode(body, as: [MergeRequest])
    {:ok, result}
  end

  @doc """
  Views a merge request.
  """
  @spec get(binary, binary, number) :: MergeRequest.t
  def get(space_id, tool_id, id) do
    {:ok, %{body: body, headers: _hdrs, status_code: 200}} =
      Request.get("#{url(space_id, tool_id)}/#{id}")

    result = Poison.Decode.decode(body, as: MergeRequest)
    {:ok, result}
  end

  @doc """
  Creates a merge request.

  Required field: title, source_symbol, target_symbol
  """
  @spec create(String.t, String.t, %{}) :: {:ok, MergeRequest.t} | {:error, map}
  def create(space_id, tool_id, fields \\ %{}) do
    {:ok, %{body: body, headers: _hdrs, status_code: status}} =
      Request.post(url(space_id, tool_id), %{merge_request: fields},
        [{"Content-Type", "application/json"}])

    case status do
      201 -> {:ok, Poison.Decode.decode(body, as: MergeRequest)}
      _ -> {:error, body}
    end
  end

  defp url(space_id, tool_id) do
    "/spaces/#{space_id}/space_tools/#{tool_id}/merge_requests"
  end
end
