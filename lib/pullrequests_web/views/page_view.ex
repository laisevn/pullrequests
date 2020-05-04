defmodule PullrequestsWeb.PageView do
  use PullrequestsWeb, :view

  def color(date, reviewers) do
    time =
      NaiveDateTime.utc_now()
      |> NaiveDateTime.diff(NaiveDateTime.from_iso8601!(date))
      |> Kernel.trunc()

    result =
      cond do
        time / 86400 > 1 and reviewers == 0 ->
          "danger"

        reviewers == 0 ->
          "warning"

        true ->
          "info"
      end
  end

  def text(str) do
    {str_title, _} = String.split_at(str, 60)
    str_title
  end
end
