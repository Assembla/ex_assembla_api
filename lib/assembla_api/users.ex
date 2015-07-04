defmodule AssemblaApi.Users do
  alias AssemblaApi.Request

  defmodule User do
    defstruct [:id, :email, :im, :im2, :login, :name, :organization, :phone, :picture]
  end

  def me do
    {:ok, %{body: body, status_code: 200}} = Request.get("/user")
    result = Poison.Decode.decode(body, as: User)
    result
  end

  def get(id_or_login) do
    # TODO check for 404
    {:ok, %{body: body, status_code: 200}} = Request.get("/users/#{id_or_login}")
    result = Poison.Decode.decode(body, as: User)
    result
  end
end
