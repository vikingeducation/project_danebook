module GlobalHelpers

def create_dates
  1.upto(31) do |num|
    Day.create(day: num)
  end

  1.upto(12) do |num|
    month_n = Date::MONTHNAMES[num]
    Month.create(month: num, month_name: month_n)
  end

  1900.upto(2010) do |num|
    Year.create(year: num)
  end
end

end
