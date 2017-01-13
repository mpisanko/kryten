defmodule Kryten.Circle do
  use HTTPoison.Base

  @org "jobseekerltd"
  @base_url "https://circleci.com/api/v1.1"
  @auth "?circle-token=#{Application.get_env(:kryten, :circle_token)}"

  ## API

  def failing_builds do
    get!("projects", %{"Accept" => "application/json"})
    |> Map.get(:body)
    |> Poison.decode!
    |> Enum.map(fn p ->
      {
        Map.get(p, "reponame"),
        Map.get(p, "branches")
        |> parse_branches
        |> Enum.filter(fn {_, outcome, _, _} -> outcome == "failed" end)
      }
    end)
    |> Enum.reject(fn {_, failing_builds} -> failing_builds == [] end)
    |> Enum.map(&format_msg/1)
  end

  defp format_msg({pn, branches}) do
    "\n*#{pn}*\n#{ Enum.map(branches, fn {b, _, n, _} -> "• #{b} : https://circleci.com/gh/jobseekerltd/#{pn}/#{n}\n" end) |> Enum.join }"
  end
  defp parse_branches(branches) do
    Enum.map(branches, &parse_builds/1)
  end

  defp parse_builds({branch_name, %{"recent_builds" => []}}) do
    {branch_name, "no recent builds", nil, nil}
  end
  defp parse_builds({branch_name, %{"recent_builds" => [fst|_rest]}}) do
    {branch_name, Map.get(fst, "outcome"), Map.get(fst, "build_num"), Map.get(fst, "pushed_at")}
  end
  defp parse_builds({branch_name, _}), do: {branch_name, "no recent builds", nil, nil}
  ## CALLBACKS

  def process_url("projects"), do: "#{@base_url}/projects#{@auth}"

end
