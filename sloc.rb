require 'yard'
include YARD::Parser

file = ARGV[0] || __FILE__

$sloc, $cloc = 0, 0
class SLOC
  attr_accessor :files
  
  def initialize(*args)
    SourceParser.parser_type = :ruby18
    self.files = {}
    log.enter_level(Logger::FATAL) do
      args.each do |file|
        files[file] = {sloc:0, cloc:0}
        parse_string(file, IO.read(file))
      
        print_file(file)
      end

      print_totals
    end
  end
  
  def parse(file, stmts)
    stmts.each do |stmt|
      files[file][:sloc] += 1
      files[file][:cloc] += stmt.comments.size if stmt.comments
      parse_string(file, stmt.block.to_s) if stmt.block
    end
  end
  
  def parse_string(file, str)
    parse(file, YARD::Parser::SourceParser.parse_string(str))
  end
  
  def print_file(file)
    puts "#{file}:"
    puts "SLOC: #{files[file][:sloc]}"
    puts "CLOC: #{files[file][:cloc]}"
    puts
  end
  
  def print_totals
    total_sloc, total_cloc = 0, 0
    avg_sloc, avg_cloc = 0, 0
    files.each do |file, v|
      total_sloc += v[:sloc]
      total_cloc += v[:cloc]
    end
    avg_sloc = total_sloc.to_f / files.size
    avg_cloc = total_cloc.to_f / files.size
    puts "Totals:"
    puts "SLOC (avg): ~#{avg_sloc.round} per file"
    puts "CLOC (avg): ~#{avg_cloc.round} per file"
  end
end

files = ARGV.empty? ? [__FILE__] : ARGV
SLOC.new(*files)
