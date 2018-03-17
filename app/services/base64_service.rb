module Base64Service

  def self.encode(text)
    return nil unless text
    Base64.encode64(text)
  end

  def self.decode(text)
    return nil unless text
    Base64.decode64(text)
  end
end