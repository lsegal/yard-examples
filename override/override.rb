require 'yard'

# Register the tag to be recognized by the parser
YARD::Tags::Library.define_tag 'Overriden Method', :override

# Parse the ruby file
YARD.parse('example_code.rb')

# Check that all declared overriden methods define @override
# and that all @override tags override something.
YARD::Registry.all(:method).each do |method|
  found_override = false
  method.namespace.inheritance_tree[1..-1].each do |klass|
    if found_override = klass.child(name: method.name, scope: method.scope)
      break
    end
  end
  
  warning = nil
  if found_override && !method.has_tag?(:override)
    warning = "does not declare override for superclass method"
  elsif !found_override && method.has_tag?(:override)
    warning = "declares override but does not override any methods (typo?)."
  end
  
  puts "[warning] '#{method.path}' #{warning}" if warning
end