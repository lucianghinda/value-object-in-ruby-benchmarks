require 'benchmark/memory'

keys = 1000.times.map { |i| "key#{i}".to_sym }
values = 1000.times.map { |i| "value#{i}" }
keys_and_values = Hash[keys.zip(values)]

DataDefine = Data.define(*keys)

puts "Comparing ways to instantiate a Data.define object - Benchmark with memory"

Benchmark.memory do |x|
  x.report("Keyword arguments") do
    DataDefine.new(**keys_and_values)
  end

  x.report("Positional arguments") do
    DataDefine.new(*values)
  end

  x.report("Constructor method") do
    DataDefine[*values]
  end

  x.report("Constructor keywords") do
    DataDefine[**keys_and_values]
  end

  x.compare!
end
