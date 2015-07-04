defmodule AssemblaApi.Users do
  alias AssemblaApi.Request

  defmodule User do
    defstruct [:id, :email, :im, :im2, :login, :name, :organization, :phone, :picture]
    @type t :: %User{id: integer, email: String.t, im: map, im2: map, login: String.t, name: String.t,
                    organization: String.t, phone: String.t, picture: String.t}
  end

  @doc """
  Returns currently logged in user details.
  """
  @spec me :: User.t
  def me do
    {:ok, %{body: body, status_code: 200}} = Request.get("/user")
    result = Poison.Decode.decode(body, as: User)
    result
  end

  @doc """
  Returns user details by login or ID.
  """
  @spec get(String.t) :: User.t
  def get(id_or_login) do
    # TODO check for 404
    {:ok, %{body: body, status_code: 200}} = Request.get("/users/#{id_or_login}")
    result = Poison.Decode.decode(body, as: User)
    result
  end
end
