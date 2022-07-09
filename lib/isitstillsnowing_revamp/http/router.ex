defmodule IsitstillsnowingRevamp.Http.Router do
  use Plug.Router

  import IsitstillsnowingRevamp.{Renderer.Layout, Weather}

  plug(Plug.Logger, log: :debug)

  plug(:match)

  plug(:dispatch)

  get "/" do
    %{remote_ip: ip} = conn

    format_ip(ip) |> IO.inspect()

    build_ip_info("62.182.98.212") |> IO.inspect()

    conn
    |> put_resp_header("content-type", "text/html; charset=utf-8")
    |> send_resp(200, layout())
  end

  get _ do
    send_resp(conn, 404, "not found")
  end

  defp format_ip(ip), do: Tuple.to_list(ip) |> Enum.join(".")
end
