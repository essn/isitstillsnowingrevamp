defmodule IsitstillsnowingRevamp.Weather do
  defstruct ip: nil,
    lat: nil,
    lon: nil,
    zip: nil,
    weather_list: nil,
    snowing: nil

  @spec build_ip_info(String.t()) :: {atom, %__MODULE__{}}
  def build_ip_info(ip) do
   ip
   |> get_geo_info
   |> get_weather
   |> calculate_is_snowing
  end

  defp get_geo_info(ip) do
    {:ok, %HTTPoison.Response{body: body}} =
      HTTPoison.get("http://ip-api.com/json/#{ip}")

    with %{"zip" => zip, "lat" => lat, "lon" => lon} <- Jason.decode!(body)
    do
      {:ok, %__MODULE__{zip: zip, lat: lat, lon: lon, ip: ip}}
    else
      _ -> {:error, % __MODULE__{ip: ip}}
    end
  end

  defp get_weather(err = {:error, _}), do: err
  defp get_weather({:ok, ip_info = %__MODULE__{}}) do
    params = build_params(ip_info)

    {:ok, %HTTPoison.Response{body: body}} =
      HTTPoison.get("api.openweathermap.org/data/2.5/weather?#{params}")

    with %{"weather" => weather } <- Jason.decode!(body)
    do
      {:ok,% __MODULE__{ip_info | weather_list: weather}}
    else
      _ -> {:error, ip_info}
    end
  end

  defp build_params(ip_info = %__MODULE__{}) do
    params = case ip_info do
      %__MODULE__{lat: nil}
        -> "zip=#{ip_info.zip}"
      %__MODULE__{lon: nil}
        -> "zip=#{ip_info.zip}"
      _
        -> "lat=#{ip_info.lat}&lon=#{ip_info.lon}"
    end

    app_id = System.get_env("OPENWEATHER_API_KEY")

    "#{params}&APPID=#{app_id}"
  end

  defp calculate_is_snowing(err = {:error, _}), do: err
  defp calculate_is_snowing({:ok, ip_info = %__MODULE__{}}) do
    types = Enum.map ip_info.weather_list, fn(item) -> item["main"] end

    {:ok, %__MODULE__{ip_info | snowing: Enum.member?(types, "Snow")}}
  end
end
