require 'yard'

def run_examples(object)
  exnum = 0
  path = File.basename(object.file)
  object.tags(:example).each do |exs|
    exnum += 1
    exs.text.split(/\n/).each do |ex|
      begin
        ex.gsub!('#=>', '=>')
        hash = instance_eval("{ #{ex} }")
        if hash.keys.first != hash.values.first
          puts "Incorrect @example (##{exnum}) in ('#{path}':#{object.line}):"
          puts "\tExpecting '#{hash.values[0]}', got '#{hash.keys[0]}'"
        end
      rescue => e
        raise e, "#{e.message}\nInvalid spec example in #{object.path}:\n\n\t#{ex}\n"
      end
    end
  end
end

