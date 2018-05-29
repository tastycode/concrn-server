class Command < MagicStruct
  def perform
    raise "Not implemented"
  end

  def self.perform(**args)
    new(**args).perform
  end
end
