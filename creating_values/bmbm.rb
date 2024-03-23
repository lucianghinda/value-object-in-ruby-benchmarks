require 'benchmark'
require "ostruct"

keys = 1000.times.map { |i| "key#{i}".to_sym }
values = 1000.times.map { |i| "value#{i}" }
keys_and_values = Hash[keys.zip(values)]

DataStruct = Struct.new(*keys, keyword_init: true)
DataDefine = Data.define(*keys)

puts "Creating a new object - Benchmark with bmbm"

Benchmark.bmbm do |x|
  x.report("Struct.new") do
    DataStruct.new(**keys_and_values)
  end

  x.report("Data.define") do
    DataDefine.new(**keys_and_values)
  end

  x.report("OpenStruct.new") do
    OpenStruct.new(**keys_and_values)
  end
end
