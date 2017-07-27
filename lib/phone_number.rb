module PhoneNumber
  def self.normalize(digits)
    digits.gsub(/[^0-9]/,'')[-10..-1]
  end
end
