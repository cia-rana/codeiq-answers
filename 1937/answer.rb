class Fare_Calculator
  DISCOUNT = 0.56
  ONE_DAY_TICKET_FARE = {"An" => 910, "Ax" => 510, "Cn" => 460, "Cx" => 260}
  PASSENGER_CLASSIFICATION = %w(An Ap Ax Cn Cp Cx In Ip Ix)
  PASSENGER_ONE_DAY_TICKET_EFFECTIVE = %w(An Ax Cn Cx)

  def initialize
    @passenger_num = {}
    PASSENGER_CLASSIFICATION.each do |c|
      @passenger_num[c] = 0
    end
  end

  def calculate(regular_fares, passengers)
    count_people_num(passengers)

    # 大人の人数の2倍分、幼児の人数をIn、Ixの順で減らしていく
    red_num = (@passenger_num["An"] + @passenger_num["Ap"] + @passenger_num["Ax"])*2
    @passenger_num["In"] = (red_num = red_num - @passenger_num["In"]) > 0 ? 0 : (red_tmp = -red_num; red_num=0; red_tmp)
    @passenger_num["Ix"] = (red_num = red_num - @passenger_num["Ix"]) > 0 ? 0 : (red_tmp = -red_num; red_num=0; red_tmp)

    # 残った幼児を子供の人数に加える
    @passenger_num["Cn"] = @passenger_num["Cn"] + @passenger_num["In"]
    @passenger_num["Cx"] = @passenger_num["Cx"] + @passenger_num["Ix"]
    
    # 一日乗車券を使わない場合の運賃を計算する
    # （計算はPASSENGER_ONE_DAY_TICKET_EFFECTIVEに列挙した分だけで十分）
    fare_sum = {}
    PASSENGER_ONE_DAY_TICKET_EFFECTIVE.each { |pas| fare_sum[pas] = 0 }
    regular_fares.each do |regular_fare|
      regular_fare_for_child = round_per_ten(regular_fare / 2.0)
      discount_fare_for_child = round_per_ten(regular_fare_for_child * DISCOUNT)
      discount_fare = round_per_ten(regular_fare * DISCOUNT)

      fare_sum["An"] = fare_sum["An"] + regular_fare
      fare_sum["Ax"] = fare_sum["Ax"] + discount_fare
      fare_sum["Cn"] = fare_sum["Cn"] + regular_fare_for_child
      fare_sum["Cx"] = fare_sum["Cx"] + discount_fare_for_child
    end

    # 一日乗車券を使った方が良いか決めながら、運賃の合計を計算する
    # （計算はPASSENGER_ONE_DAY_TICKET_EFFECTIVEに列挙した分だけで十分）
    PASSENGER_ONE_DAY_TICKET_EFFECTIVE.inject(0) do |sum, pas|
      sum = sum + [fare_sum[pas], ONE_DAY_TICKET_FARE[pas]].min * @passenger_num[pas]
    end
  end

  private
  def count_people_num(passengers)
    PASSENGER_CLASSIFICATION.each do |c|
      @passenger_num[c] = passengers.count(c)
    end
  end

  def round_per_ten(value)
    tmp = (value / 10.0).floor * 10
    (value - tmp).zero? ? tmp : tmp + 10
  end
end

def parse(arg)
  regular_fares, passengers = arg.strip.split(':')
  regular_fares = regular_fares.split(',').map(&:to_i)
  passengers = passengers.split(',')
  [regular_fares, passengers]
end

regular_fares, passengers = parse(gets)
fare_calculator = Fare_Calculator.new
puts fare_calculator.calculate(regular_fares, passengers)

=begin
q = []
q << "220,250,300:Ap,Cn,In,Ix,Ix"
q << "210:Ap,Cn,In,Ix,Ix"
q << "450,200:An,Cn,In,In"
q << "450,200:Ax,Cn,In,Ix"
q << "310,350,330:Ap,Cn,In,Ix,Ix"
q << "300,350:An,An,In,In,In,In"
q << "300,350:An,In,In,In,In"
q << "300,350:Cn,In,In,In,In"
q << "240,220:Ax,Ix,Cp,In"

q.each do |s|
  regular_fares, passengers = parse(s)
  fare_calculator = Fare_Calculator.new
  puts s
  puts fare_calculator.calculate(regular_fares, passengers)
end
=end