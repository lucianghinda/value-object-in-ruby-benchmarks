require 'benchmark/ips'
require "ostruct"

keys = 1000.times.map { |i| "key#{i}".to_sym }
values = 1000.times.map { |i| "value#{i}" }
keys_and_values = Hash[keys.zip(values)]

DataStruct = Struct.new(*keys)
DataDefine = Data.define(*keys)

puts "Creating a new object - Benchmark with ips"

Benchmark.ips do |x|
  x.report("Struct.new") do
    DataStruct.new(*values)
  end

  x.report("Data.define") do
    DataDefine.new(*values)
  end

  x.report("OpenStruct.new") do
    OpenStruct.new(keys_and_values)
  end
  x.compare!
end
