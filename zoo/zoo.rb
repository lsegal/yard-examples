require 'yard'

class ContextObject < YARD::CodeObjects::NamespaceObject
  attr_accessor :tests
  
  def initialize(*args)
    super
    @tests = []
  end

  def type; :context end
  def path; "__TestContext::" + super end
end

class ContextHandler < YARD::Handlers::Ruby::Base
  handles method_call(:context)
  
  def process
    name = statement[1].jump(:string_content).source
    ns = ContextObject.new(:root, name)
    parse_block(statement[-1][1], :namespace => ns)
  end
end

class ExpectHandler < YARD::Handlers::Ruby::Base
  handles method_call(:expect)

  def process
    return unless namespace.is_a?(ContextObject)
    namespace.tests << statement[-1][1].source
  end
end

YARD.parse('*_test.rb')

YARD::Registry.all(:context).each do |context|
  context.tests.each do |test|
    puts "test: #{context.name} expect #{test}"
  end
end

# test: A blog post expect @post.to be_editable_by(@author)
# test: A blog post expect @post.not_to be_editable_by(@somebody_else)