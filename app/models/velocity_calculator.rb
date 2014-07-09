class VelocityCalculator
  attr_reader :calendar_data

  def initialize(user)
    @user = user
    @calendar_data = get_calendar_data.reverse
  end

  # https://github.com/users/johnkeith/contributions_calendar_data
  def get_calendar_data
    response = Net::HTTP.get_response(URI(
      "https://github.com/users/#{@user.username}/contributions_calendar_data"))
    JSON.parse(response.body)
  end

  def calc_velocity(time_data, days)
    commits_total = 0
    for i in 0..days
      commits_total += time_data[i][1]
    end
    commits_total / days
  end

  def for_past_six_months
    calc_velocity(@calendar_data, 182)
  end

  def for_past_month
    calc_velocity(@calendar_data, 30)
  end

  def for_past_week
    calc_velocity(@calendar_data, 7)
  end

  def month_as_num(month)
    case month
    when "January"
      "01"
    when "February"
      "02"
    when "March"
      "03"
    when "April"
      "04"
    when "May"
      "05"
    when "June"
      "06"
    when "July"
      "07"
    when "August"
      "08"
    when "September"
      "09"
    when "October"
      "10"
    when "November"
      "11"
    when "December"
      "12"
    end
  end

  def slice_month(month)
    m = month_as_num(month)
    @calendar_data.select { |item| item[0].match(/-#{m}-/) }
  end

  def for_month(month)
    month_data = slice_month(month)
    calc_velocity(month_data, month_data.length - 1)
  end

  def sum_for_month(month)
    total = 0
    month_data = slice_month(month)
    month_data.each do |day|
      total += day[1]
    end
    total
  end

  def for_week(start_day)
    
  end

  def sum_for_week(start_day)

  end
end
