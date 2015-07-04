defmodule AssemblaApi.Request do
  use HTTPoison.Base

  defp process_url(url) do
    result = AssemblaApi.config(:api_url) <> url
    IO.puts result
    result
  end

  defp process_request_headers(headers), do:
    [
      {"Accept", "application/json"},
      {"X-Api-Key", System.get_env("ASSEMBLA_API_KEY") || AssemblaApi.config(:api_key)},
      {"X-Api-Secret", System.get_env("ASSEMBLA_API_SECRET") || AssemblaApi.config(:api_secret)}
    | headers]

  defp process_request_body(body) when is_binary(body) do
    if String.length(body) > 0 do
      Poison.encode!(body)
    else
      body
    end
  end

  defp process_request_body(body) when is_map(body) or is_list(body) do
    unless Enum.empty?(body) do
      result = Poison.encode!(body)
      #IO.puts "encoded body: #{result}"
      result
    end
  end

  defp process_response_body(body) when is_binary(body) do
    if String.length(body) > 0 do
      Poison.decode!(body)
    end
  end
end
