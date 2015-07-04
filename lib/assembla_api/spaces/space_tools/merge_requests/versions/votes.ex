defmodule AssemblaApi.Spaces.SpaceTools.MergeRequests.Versions.Votes do
  alias AssemblaApi.Request

  defmodule Vote do
    defstruct [:id, :merge_request_id, :merge_request_version_id,
               :created_at, :updated_at, :user_id, :vote]
    @type t :: %Vote{id: integer, merge_request_id: integer, merge_request_version_id: integer}
  end

  @spec list(binary, binary, number, number) :: Vote.t
  def list(space_id, tool_id, mr_id, version) do
    {:ok, %{body: body, headers: _hdrs, status_code: 200}} =
      Request.get(url(space_id, tool_id, mr_id, version))
    IO.puts inspect(body)
    result = Poison.Decode.decode(body, as: [Vote])
    {:ok, result}
  end

  def upvote(space_id, tool_id, mr_id, version) do
    vote(space_id, tool_id, mr_id, version, :up)
  end

  def downvote(space_id, tool_id, mr_id, version) do
    vote(space_id, tool_id, mr_id, version, :down)
  end

  def delete(space_id, tool_id, mr_id, version) do
    {:ok, %{body: body, headers: _hdrs, status_code: status}} =
      Request.delete(url(space_id, tool_id, mr_id, version) <> "/delete")

    case status do
      204 -> :ok
      _ -> {:error, body}
    end
  end

  # Removes auth user vote from MR
  def remove(space_id, tool_id, mr_id, version) do
    delete(space_id, tool_id, mr_id, version)
  end

  defp vote(space_id, tool_id, mr_id, version, dir) do
    {:ok, %{body: body, headers: _hdrs, status_code: 201}} =
      Request.post(url(space_id, tool_id, mr_id, version) <> "/#{dir}vote", "")

    IO.puts inspect(body)
    result = Poison.Decode.decode(body, as: [Vote])

    {:ok, result}
  end

  defp url(space_id, tool_id, mr_id, version) do
    "/spaces/#{space_id}/space_tools/#{tool_id}/merge_requests/#{mr_id}/versions/#{version}/votes"
  end
end
