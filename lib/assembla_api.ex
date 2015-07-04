defmodule AssemblaApi do
  def config(key) do
    Application.get_env :assembla_api, key
  end
end
