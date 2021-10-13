require 'http'
require 'tty-prompt'
system 'clear'
request = HTTP.get("https://api2.binance.com/api/v3/ticker/24hr")
request = request.parse(:json)

watchlist = []
ians_watchlist = ["luna", "sol", "avax", "dydx", "eth"]
bool1 = true

puts "welcome to the Price Tracker app"
while bool1
  puts "enter a ticker symbol to add to you watchlist, or 'default' for Ian's watchlist, enter 'q' when done: "
  user_input = gets.chomp
  if user_input != 'q' && user_input != 'default'
    watchlist << user_input.upcase
  elsif user_input == 'default'
    ians_watchlist.each do |ticker|
      watchlist << ticker.upcase
    end
    bool1 = false
  elsif user_input == 'q'
    bool1 = false
  end
end

prompt = TTY::Prompt.new
choice = prompt.select("pick an option", ["Check price data", "Check portfolio value"])

default_amount = [41.5, 10, 20, 31.63, 0.059]
amount = []
if choice == "Check portfolio value"
  if user_input != 'default'
    watchlist.each do |ticker|
      puts "enter how many #{ticker} coins you have"
      num = gets.chomp.to_i
      amount << num
    end
  elsif user_input == 'default'
    amount = default_amount
  end
end

bool2 = true
i = 0
i2 = 0
port_value = []
while bool2
  bool2 = false
  while i2 < watchlist.length
    symbol = request[i]["symbol"]
    if symbol.include? (watchlist[i2] + "USDT") 
      if choice == "Check price data"
        puts symbol
        puts request[i]["lastPrice"]
        puts request[i]["priceChange"]
        puts request[i]["priceChangePercent"]
      elsif choice == "Check portfolio value"
        puts symbol
        puts "Your total amount of #{watchlist[i2]} is $#{(request[i]["lastPrice"].to_i * amount[i2])}"
        port_value << (request[i]["lastPrice"].to_i * amount[i2])
        puts "your total account value is $#{port_value.sum}" 
      end
      i2 += 1
      i = 0
      bool2 = true
    end
    i += 1
  end
end