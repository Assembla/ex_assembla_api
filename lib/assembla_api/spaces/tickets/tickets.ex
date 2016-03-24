defmodule AssemblaApi.Tickets do
  alias AssemblaApi.Request

  # https://api-doc.assembla.com/content/ref/ticket_fields.html
  defmodule Ticket do
    defstruct [:id, :number, :summary, :description, :priority,
               :completed_date, :component_id, :created_on, :permission_type,
               :importance, :is_story, :milestone_id, :followers,
               :notification_list, :space_id, :state, :status, :story_importance,
               :updated_at, :working_hours, :estimate, :total_estimate,
               :total_invested_hours, :total_working_hours,:assigned_to_id, :reporter_id,
               :custom_fields, :hierarchy_type, :is_support]
    @type t:: %Ticket{id: String.t, number: integer, summary: String.t,
                      description: String.t, priority: integer,
                      completed_date: String.t, component_id: integer,
                      created_on: String.t, permission_type: integer,
                      importance: float, is_story: boolean, milestone_id: integer,
                      notification_list: String.t, space_id: String.t,
                      state: integer, status: String.t, story_importance: integer,
                      updated_at: String.t, working_hours: float, estimate: float,
                      total_estimate: float, total_invested_hours: float,
                      total_working_hours: float, assigned_to_id: String.t,
                      reporter_id: String.t, custom_fields: String.t,
                      hierarchy_type: integer, is_support: boolean }
  end

  @spec create(String.t, %{}) :: {:ok, Ticket.t} | {:error, map}
  def create(space_id, params) do
    {:ok, %{body: body, headers: _headers, status_code: status}} =
      Request.post(url(space_id), %{ticket: params}, [{"Content-Type", "application/json"}])

    case status do
      201 -> {:ok, Poison.Decode.decode(body, as: Ticket)}
      _ -> {:error, body}
    end
  end

  @spec delete(String.t, integer) :: {:ok} | {:error, map}
  def delete(space_id, number) do
    {:ok, %{body: body, headers: _headers, status_code: status}} =
      Request.delete(url(space_id) <> "/#{number}")

    case status do
      204 -> :ok
      _ -> {:error, body}
    end
  end

  @spec get(String.t, integer) :: {:ok, Ticket.t} | {:error, map}
  def get(space_id, number) do
    {:ok, %{body: body, status_code: status}} = Request.get(url(space_id) <> "/#{number}")
    case status do
      201 -> {:ok, Poison.Decode.decode(body, as: Ticket)}
      _ -> {:error, body}
    end
  end

  @doc """
  Lists tickets by `space_id` and `params`
  options report, page,
  per_page (default to 10),
  sort_order: :asc, :desc (default asc),
  sort_by: id number summary priority completed_date created_on importance is_story
  milestone_id updated_at working_hours estimate total_estimate total_invested_hours total_working_hours
  """
  @spec list(String.t, %{}) :: {:ok, [Ticket.t]}
  def list(space_id, params \\ %{}) do
    {:ok, %{body: body, status_code: 200}} = Request.get(url(space_id) <> "?/#{URI.encode_query(params)}")
    IO.puts inspect body
    result = Poison.Decode.decode(body, as: [Ticket])
    {:ok, result}
  end

  defp url(space_id) do
    "/spaces/#{space_id}/tickets"
  end
end
