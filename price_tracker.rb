require 'http'
system 'clear'

portfolio = []
bool1 = true

puts "welcome to the Price Tracker app"
while bool1
  puts "enter a ticker symbol to add to you portfolio, enter 'q' when done: "
  user_input = gets.chomp
  if user_input != 'q'
    portfolio << user_input.upcase
  elsif user_input == 'q'
    bool1 = false
  end
end
request = HTTP.get("https://api2.binance.com/api/v3/ticker/24hr")
request = request.parse(:json)


bool2 = true
i = 0
i2 = 0
while bool2
  bool2 = false
  while i2 < portfolio.length
    symbol = request[i]["symbol"]
    if symbol.include? (portfolio[i2] + "USDT") 
      puts symbol
      puts request[i]["lastPrice"]
      puts request[i]["priceChange"]
      puts request[i]["priceChangePercent"]
      i2 += 1
      i = 0
      bool2 = true
    end
    i += 1
  end
end