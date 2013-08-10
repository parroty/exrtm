defmodule ExrtmSample do
  def operate_tasks(user, permission) do
    tasks = user |> Exrtm.Task.get_list()

    IO.puts "\n----operate_tasks----"
    IO.puts "<Tasks>"
    IO.puts Enum.join(Enum.map(tasks, fn(x) -> x.name end), ", ")

    if permission == "delete" do
      task = user |> Exrtm.Task.add("xxx")
      user |> Exrtm.Task.delete(task)

      IO.puts "<Task>"
      IO.inspect task
    end
  end

  def operate_lists(user) do
    lists = user |> Exrtm.List.get_list()
    inbox = user |> Exrtm.List.get_by_name("Inbox")

    IO.puts "\n----operate_lists----"
    IO.puts "<Lists>"
    IO.puts Enum.join(Enum.map(lists, fn(x) -> x.name end), ", ")
    IO.puts "<Inbox>"
    IO.inspect inbox
  end
end

key    = :os.getenv("RTM_API_KEY")        # your api_key of remember the milk
secret = :os.getenv("RTM_SHARED_SECRET")  # your shared secret of remember the milk

# specify '-t' to use pre-acquired token (stored in RTM_TOKEN environment variable), instead of frob.
{option, _argv} = OptionParser.parse(System.argv, aliases: [t: :token, p: :permission])
use_token = option[:token] != nil
perm      = Enum.find(["read", "write", "delete"], "read", fn(x) -> x == option[:permission] end)

IO.puts "[option] use_token = #{use_token}, perm = #{perm}"

if use_token do
  token = :os.getenv("RTM_TOKEN")         # use pre-stored token to authenticate
  user  = Exrtm.Auth.init_api(key, secret, token)
else
  user = Exrtm.Auth.init_api(key, secret)
  frob = Exrtm.Auth.get_frob(user)

  IO.puts "Access to the following url using browser to authenticate this script, and then press enter to proceed."
  IO.puts Exrtm.Auth.get_auth_url(user, perm, frob)
  IO.gets ""

  token = Exrtm.Auth.get_token(user, frob)
  user  = Exrtm.Auth.init_api(key, secret, token)
  IO.puts "token = #{token}"
end

ExrtmSample.operate_lists(user)
ExrtmSample.operate_tasks(user, perm)
