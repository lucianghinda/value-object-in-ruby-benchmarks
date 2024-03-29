require 'benchmark/ips'
require "ostruct"

keys = [:key1, :key2, :key3, :key4, :key5, :key6]
DataStructKeyword = Struct.new(*keys, keyword_init: true)
DataStructPositional = Struct.new(*keys)
DataDefine = Data.define(*keys)

values = 6.times.map { |i| "value#{i}" }
keys_and_values = Hash[keys.zip(values)]

class MyValueObjectWithKeywordArgs
  attr_reader :key1, :key2, :key3, :key4, :key5, :key6

  def initialize(key1:, key2:, key3:, key4:, key5:, key6:)
    @key1 = key1
    @key2 = key2
    @key3 = key3
    @key4 = key4
    @key5 = key5
    @key6 = key6
  end
end

class MyValueObjectWithPositionalArgs
  attr_reader :key1, :key2, :key3, :key4, :key5, :key6

  def initialize(key1, key2, key3, key4, key5, key6)
    @key1 = key1
    @key2 = key2
    @key3 = key3
    @key4 = key4
    @key5 = key5
    @key6 = key6
  end
end


puts "Creating a new object - Benchmark with ips - small numbers"

Benchmark.ips do |x|
  x.report("Struct - positional") do
    DataStructPositional.new(*values)
  end

  x.report("Struct - keywords") do
    DataStructKeyword.new(**keys_and_values)
  end

  x.report("Data - positional") do
    DataDefine.new(*values)
  end

  x.report("Data - keywords") do
    DataDefine.new(**keys_and_values)
  end

  x.report("OpenStruct.new") do
    OpenStruct.new(**keys_and_values)
  end

  x.report("PORO - positional") do
    MyValueObjectWithPositionalArgs.new(*values)
  end

  x.report("PORO - keywords") do
    MyValueObjectWithKeywordArgs.new(**keys_and_values)
  end

  x.compare!
end
