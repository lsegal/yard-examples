class String
  # Pig latin of a String
  # 
  # @example
  #   "hello".pig_latin #=> "ellohay"
  # 
  # @example 
  #   "hi".pig_latin #=> "hiay"
  # 
  def pig_latin
    self[1..-1] + self[0] + "ay"
  end
end


if $0 == __FILE__
  require 'doctest'

  YARD.parse(File.basename(__FILE__))
  obj_to_test = P("String#pig_latin")
  
  puts "--- Testing @example tags: ---"
  puts
  run_examples(obj_to_test)
end