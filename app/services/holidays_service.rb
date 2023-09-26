class HolidaysService

  def self.next_three_holidays
    response = Faraday.get("https://date.nager.at/api/v3/NextPublicHolidays/US")
    parsed = JSON.parse(response.body, symbolize_names: true).first(3)
    next_three_holidays = parsed.map { |holiday| Holiday.new(holiday)}
  end
end