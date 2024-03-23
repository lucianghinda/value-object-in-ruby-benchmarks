require 'benchmark'
require "ostruct"

keys = 1000.times.map { |i| "key#{i}".to_sym }
values = 1000.times.map { |i| "value#{i}" }
keys_and_values = Hash[keys.zip(values)]

BigDataS = Struct.new(*keys, keyword_init: true)
BigDataD = Data.define(*keys)

struct_object = BigDataS.new(**keys_and_values)
data_object = BigDataD.new(**keys_and_values)
opens_struct_object = OpenStruct.new(**keys_and_values)

puts "Accessing attributes - bmbm test"

Benchmark.bmbm do |x|
  x.report("Struct") do
    keys.each { struct_object.send(_1) }
  end

  x.report("Data.define")  do
    keys.each { data_object.send(_1) }
  end

  x.report("OpenStruct") do
    keys.each { opens_struct_object.send(_1) }
  end
end
