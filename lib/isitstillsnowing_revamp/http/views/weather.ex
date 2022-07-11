defmodule IsitstillsnowingRevamp.Http.Views.Weather do
  @moduledoc """
  Calculates the text to show. WAY TOO COMPLEX.

  Generally speaking, raining is MAYBE, snowing is YES, and not snowing is NO.
  """

  alias IsitstillsnowingRevamp.Weather

  @weather_text %{
    snow: "YUP!",
    not_snowing: "NOPE!",
    raining: "MAYBE!"
  }

  @snow ["Snow"]
  @rain ["Rain", "Thunderstorm", "Drizzle"]

  def text(%Weather{weather_type: weather_type}) when is_list(weather_type) do
    {_weather_type, text} =
      is_snowing?({weather_type, nil})
      |> is_raining?()
      |> is_not_snowing?()

    text
  end

  # Maybe if we can't analyze it
  def text(_), do: @weather_text.raining
  def text(), do: @weather_text.raining

  defp is_snowing?({weather_type, text} = args) do
    case has_weather?(@snow, weather_type) && is_nil(text) do
      true -> {weather_type, @weather_text.snow}
      false -> args
    end
  end

  defp is_raining?({weather_type, text} = args) do
    case has_weather?(@rain, weather_type) && is_nil(text) do
      true -> {weather_type, @weather_text.raining}
      false -> args
    end
  end

  defp is_not_snowing?({weather_type, text} = args) do
    case is_nil(text) do
      true -> {weather_type, @weather_text.not_snowing}
      false -> args
    end
  end

  defp has_weather?(types, type) do
    Enum.any?(types, fn t -> t in type end)
  end
end
