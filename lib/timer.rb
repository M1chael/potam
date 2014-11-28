module Timer

  def now
    time = ENV['POTAM'] == 'test' ? ENV['POTAMTIME'].to_i : Time.now.to_i
  end

end