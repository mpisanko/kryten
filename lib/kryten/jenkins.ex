defmodule Kryten.Jenkins do
  use HTTPoison.Base

  ## API

  def build(project) do
    post!(project, "", %{}, auth)
  end

  ## CALLBACKS

  def process_url(project) do
    #"https://cicd.jora.com/job/#{project}/build?token=#{jenkins_token}" |> IO.inspect
    "http://localhost:8081/#{project}?token=#{jenkins_token}"
  end

  def auth, do: [hackney: [insecure: true, basic_auth: {github_user, github_token}]]

  def jenkins_token, do: Application.get_env(:kryten, :jenkins_token)

  def github_user, do: Application.get_env(:kryten, :github_user)

  def github_token, do: Application.get_env(:kryten, :github_token)

end
