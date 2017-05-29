# 拡張Levenshtein distanceである
# Damerau–Levenshtein distanceのさらに拡張

def damerau_levenshtein_distance(a, b)
  dp = Array.new(a.size){|i|[i*2+2]+Array.new(b.size){0}}.unshift (0..b.size).map{|e|e*2}
  a_up = a.upcase
  b_up = b.upcase
  distance_sup = (a.size + b.size)*2 + 1 # a-b levenshtein distanceの上限
  substituting_cost = ->(i, j){
    # 置換なし
    if a[i-1] == b[j-1]
      dp[i-1][j-1]
    # 大文字小文字置換
    elsif a_up[i-1] == b_up[j-1]
      dp[i-1][j-1] + 1
    # 通常置換
    else
      dp[i-1][j-1] + 2
    end
  }
  transposing_cost = ->(i, j){
    if i > 1 && j > 1
      # 通常転置
      if a[i-1] == b[j-2] && a[i-2] == b[j-1]
        return dp[i-2][j-2] + 2
      # 転置 + 大文字小文字置換x1
      elsif (a[i-1] == b[j-2]) ^ (a[i-2] == b[j-1]) && a_up[i-1] == b_up[j-2] && a_up[i-2] == b_up[j-1]
        return dp[i-2][j-2] + 3
      end
    end
    distance_sup
  }
  
  1.upto(a.size){|i|
    1.upto(b.size){|j|
      dp[i][j] = [dp[i-1][j] + 2, # 追加
                  dp[i][j-1] + 2, # 削除
                  substituting_cost[i, j], # 置換
                  transposing_cost[i, j] # 転置
                  ].min
    }
  }
  
  dp[-1][-1]
end
p damerau_levenshtein_distance(*$<.map(&:chomp))