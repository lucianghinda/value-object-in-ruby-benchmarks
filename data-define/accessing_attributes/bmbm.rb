require 'benchmark'

keys = 1000.times.map { |i| "key#{i}".to_sym }
values = 1000.times.map { |i| "value#{i}" }
keys_and_values = Hash[keys.zip(values)]

DataDefine = Data.define(*keys)
keyword_args = DataDefine.new(**keys_and_values)
positional_args = DataDefine.new(*values)
constructor_method = DataDefine[*values]
constructor_with_keyword_args = DataDefine[**keys_and_values]

puts "Comparing accessing data for Data.define object - Benchmark with bmbm"

Benchmark.bmbm do |x|
  x.report("Keyword arguments") do
    keys.each { keyword_args.send(_1) }
  end

  x.report("Positional arguments") do
    keys.each { positional_args.send(_1) }
  end

  x.report("Constructor method") do
    keys.each { constructor_method.send(_1) }
  end

  x.report("Constructor keywords") do
    keys.each { constructor_with_keyword_args.send(_1) }
  end
end
