class MagicStruct
  include ActiveModel::Validations

  attr_reader :params

  def initialize(hashish)
   @params = hashish
   hashish.each do |key, val|
     send(:"#{key}=", val)
   end
  end

  def self.required_params(*required_keys)
    _required_params |= Array.wrap(required_keys)
    required_keys.each(&method(:attr_accessor))
    required_keys.each(&method(:validates_presence_of))
  end

  def self.optional_params(*optional_keys)
    _optional_params |= Array.wrap(optional_keys)
    optional_keys.each(&method(:attr_accessor))
  end

  class << self
    private

    attr_accessor :_required_params, :_optional_params

    def _required_params
      @required_params ||= []
    end

    def _optional_params
      @optional_params ||= []
    end
  end
end
