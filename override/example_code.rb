module Processor
  class Base
    def process
      raise NotImplementedError, "implement #process to use this class"
    end
  end

  class Derived < Base
    # @override
    def process
    end
  end

  class Derived2 < Base
    # no override declaration
    def process
    end
  end
  
  class Derived3 < Base
    # deliberate typo in method name
    # @override
    def proces
    end
  end
end