class Constantine
  class WrapperObject
    def initialize(hash)
      @hash = hash
    end

    def [](key)
      @hash[key]
    end

    def method_missing(key)
      @hash.fetch(key.to_s) rescue super
    end

    def wrap(value)
      if value.kind_of?(Hash)
        WrapperObject.new(value)
      else
        value
      end
    end
  end

  class RootWrapperObject
    def initialize(hash, env:)
      @hash = hash
      @env = env
    end

    def method_missing(key)
      config = @hash.fetch(key.to_s) rescue (fail "Missing configuration for #{key}")
      WrapperObject.new(config.fetch(@env))
    end
  end

  class << self
    def load(path, env:)
      RootWrapperObject.new(YAML.load_file(path), env: env)
    end
  end
end
