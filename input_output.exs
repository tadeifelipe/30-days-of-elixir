defmodule CowInterrogator do

  defp get_name() do
    IO.gets("What is your name? ")
  end

  defp get_cow_lover(name), do: IO.getn("Hello #{name}, do you like Cows? [y/n]", 1)

  def interrogate() do
    get_name()
      |> get_cow_lover()
      |> validate()
  end

  defp validate(response) when response == "y" do
    IO.puts("Great! Here is a cow for you!")
    IO.puts(get_cow_art())
  end

  defp validate(response) when response == "n" do
    IO.puts("That is a shame!")
  end

  defp validate(_), do: IO.puts("You should have entered [y] or [n]")

  defp get_cow_art do
    Path.expand("support/cow.txt", __DIR__)
      |> File.read()
      |> show_cow()
  end

  defp show_cow({:ok, art}), do: IO.puts(art)
  defp show_cow({:error, _}), do: IO.puts("Error: cow.txt file not found")
end

defmodule InputOutputTest do
  ExUnit.start()
  use ExUnit.Case
  import ExUnit.CaptureIO

  describe "interrogate/0" do
    test "should print asks when starting a interrogation" do
      expected_response = "What is your name? Hello eof, do you like Cows? [y/n]You should have entered [y] or [n]\nok"
      assert capture_io(fn -> IO.write CowInterrogator.interrogate end) == expected_response
    end
  end
end

CowInterrogator.interrogate()
