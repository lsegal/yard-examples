require 'yard'

YARD::Tags::Library.define_tag "RSpec Specification", :it, :with_raw_title_and_text

def run_specs(object)
  require 'spec'
  path = File.basename(object.file)
  describe(object.namespace.path, object.name(true).to_s) do
    object.tags(:it).each do |it|
      it(it.name + " (from #{path}:#{object.line})") do 
        begin
          eval(it.text)
        rescue => e
          e.set_backtrace(["#{path}:#{object.line}:in @it tag specification"])
          raise e
        end
      end
    end
  end
  opts = Spec::Runner.options
  opts.parse_format('specdoc')
  opts.colour = true
  opts.run_examples
end
