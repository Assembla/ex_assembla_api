defmodule AssemblaApi.Spaces.SpaceTools.MergeRequests.Versions.Comments do
  alias AssemblaApi.Request

  defmodule Comment do
    defstruct [:id, :merge_request_id, :space_id, :user_id, :content, :created_at, :updated_at]
    @type t :: %Comment{id: integer, merge_request_id: integer, space_id: String.t,
                        user_id: String.t, content: String.t, created_at: String.t,
                        updated_at: String.t}
  end

  @doc """
  Returns a list of comments from merge request version.
  """
  @spec list(binary, binary, number, number) :: {:ok, [Comment.t]} | {:error, term}
  def list(space_id, tool_id, mr_id, version) do
    {:ok, %{body: body, headers: _hdrs, status_code: 200}} =
      Request.get(url(space_id, tool_id, mr_id, version))
    #IO.puts inspect(body)
    result = Poison.Decode.decode(body, as: [Comment])
    {:ok, result}
  end

  @doc """
  Creates a comment on merge request version.
  """
  @spec create(String.t, String.t, integer, integer, binary) :: {:ok, Comment.t} | {:error, term}
  def create(space_id, tool_id, mr_id, version, comment) do
    {:ok, %{body: body, headers: _hdrs, status_code: status}} =
      Request.post(url(space_id, tool_id, mr_id, version), %{content: comment},
        [{"Content-Type", "application/json"}])

    #IO.puts inspect(body)

    case status do
      201 -> {:ok, Poison.Decode.decode(body, as: [Comment])}
      _ -> {:error, body}
    end
  end

  defp url(space_id, tool_id, mr_id, version) do
    "/spaces/#{space_id}/space_tools/#{tool_id}/merge_requests/#{mr_id}/versions/#{version}/comments"
  end
end
