CURRENCIES = [10_000, 5_000, 2_000, 1_000, 500, 100, 50, 10, 5, 1]

def select_currencies(price)
  CURRENCIES.size.downto(1).each{|kinds|
    cc = []
    CURRENCIES.combination(kinds).each{|selected_currencies|
      balance = price - selected_currencies.inject(:+)
      cc << [selected_currencies, balance] if balance > 0
    }
    return [kinds, cc] if cc.size > 0
  }
end

def calc_num_currencies_min(selected_currencies)
  selected_currencies.map{|currencies, price|
    dp = [0] + [1.0/0] * price
    (price + 1).times{|i|
      currencies.size.times{|j|
        dp[i] = [dp[i - currencies[j]] + 1, dp[i]].min if i >= currencies[j]
      }
    }
    dp[price]
  }.min
end

kinds, selected_currencies = select_currencies(gets.to_i)
p calc_num_currencies_min(selected_currencies) + kinds