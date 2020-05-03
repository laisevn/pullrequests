defmodule PullrequestsWeb.PageView do
  use PullrequestsWeb, :view

  def color(date, reviewers) do
    time =
      NaiveDateTime.local_now()
      |> NaiveDateTime.diff(NaiveDateTime.from_iso8601!(date))
      |> Kernel.trunc()

    result =
      if reviewers == 0 do
        "warning"
      end

    result =
      if time / 86400 > 1 and reviewers == 0 do
        "danger"
      else
        "info"
      end

    result
  end

  def text(str) do
    {str_title, _} = String.split_at(str, 60)
    str_title
  end
end
