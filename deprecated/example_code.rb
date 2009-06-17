class MyClass
  def mymethod
  end
  
  # @deprecated Use {#mymethod} instead.
  def my_old_method
  end
end

if $0 == __FILE__
  require 'yard'
  YARD::CLI::Yardoc.run(File.basename(__FILE__))
end