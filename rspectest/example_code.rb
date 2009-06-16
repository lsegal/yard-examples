class String
  # Pig latin of a String
  # 
  # @it should be a pig!
  #   "hello".pig_latin.should == "ellohay"
  # 
  # @it should fail to be a pig!
  #   "hello".pig_latin.should == "hello"
  # 
  def pig_latin
    self[1..-1] + self[0] + "ay"
  end
end


if $0 == __FILE__
  require 'rspectest'

  YARD.parse(File.basename(__FILE__))
  obj_to_test = P("String#pig_latin")
  
  puts "--- Testing @it specs ---"
  run_specs(obj_to_test)
end