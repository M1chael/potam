module Timer

  def now
    time = ENV['POTAM'] == 'test' ? ENV['POTAMTIME'].to_i : Time.now.to_i
  end

  def last_mon
    mon = Time.at(now - (Time.at(now).wday - 1) * 24 * 60 * 60)
    Time.new(mon.year, mon.month, mon.day).to_i
  end

end