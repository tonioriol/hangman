defmodule Shopping do

  def get_template() do
    """
    quantity | item
    ---------------
    <%= for {amount, item} <- list do %>
    <%= amount %> | <%= item %>
    <% end %>
    """
  end

  def get_list() do
    [
      {"1 dozen", "eggs"},
      {"1 ripe", "melon"},
      {"4", "apples"},
      {"2 boxes", "tea"},
    ]
  end

  def show() do
    EEx.eval_string(
      get_template(),
      [
        list: format_list(get_list())
      ],
      trim: true
    )
    |> IO.puts
  end

  def format_list(list) do
    Enum.map(
      list,
      fn {amount, item} ->
        {format_amount(amount, calc_max_length_amount(list)), item}
      end
    )
  end

  def calc_max_length_amount(list) do
    Enum.reduce(
      list,
      0,
      fn {amount, _item}, memo ->
        amount_length = String.length(amount)
        if memo < amount_length do
          amount_length
        else
          memo
        end
      end
    )
  end

  def format_amount(amount, max_length_amount) do
    String.pad_leading(amount, max_length_amount)
  end

end
