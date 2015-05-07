def stock_picker(prices)
  best_price = 0
  best_days = nil

  prices.each_with_index do |buy, buy_day|
    (buy_day + 1..prices.length - 1).each do |sell_day|
      if prices[sell_day] - buy > best_price
        best_price = prices[sell_day] - buy
        best_days = [buy_day, sell_day]
      end
    end
  end
  
  best_days
end


p stock_picker([1, 6, 4, 7, 3, 9, 1, 2])
