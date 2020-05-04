defmodule PullrequestsWeb.PageController do
  use PullrequestsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", pull_requests: reviewers())
  end

  defp reviewers do
    get_response()
    |> Enum.map(fn x ->
      reviewers =
        x["number"]
        |> get_reviewers
        |> request_decode
        |> length()

      Map.put(x, "reviewers", reviewers)
    end)
  end

  defp get_response do
    if Mix.env() == :dev do
      decode_local()
    else
      get_request_pull_requests
      |> request_decode
    end
  end

  defp request_decode(encoded) do
    if %HTTPoison.Response{status_code: 200, body: body} = encoded do
      Jason.decode!(body)
    else
      nil
    end
  end

  defp get_reviewers(id) do
    url = "https://api.github.com/repos/#{repo()}/#{project()}/pulls/#{id}/reviews"

    HTTPoison.get!(url, headers())
  end

  defp get_request_pull_requests do
    url =
      "https://api.github.com/repos/#{repo()}/#{project()}/pulls?state=open&sort=created&direction=desc"

    HTTPoison.get!(url, headers())
  end

  defp decode_local do
    Jason.decode!(File.read!("priv/static/json/response.json"))
  end

  defp headers do
    [Authorization: "token #{token()}"]
  end

  defp token, do: System.get_env("TOKEN")
  defp repo, do: System.get_env("REPO")
  defp project, do: System.get_env("PROJECT")
end
