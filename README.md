# Micro Benchmarks on Value Object options in Ruby

A series of micro benchmarks about Data.define vs Struct vs OpenStruct in #Ruby.

This is executed with defaults, no extra settings added.

## How to run the benchmarks

```bash
bundle install
bundle exec ruby <benchmark>
```

## Results on my machine

I run the following benchmarks on my machine:

- Apple M3 PRO
- 36 GB
- Running Mac OS 14.4 (23E214)
- Ruby 3.3.0

### Creating Values

#### Benchmark with `bmbm`

This benchmark is run with Ruby default benchmark using `bmbm`

```bash
Creating a new object - Benchmark with bmbm
Rehearsal --------------------------------------------------
Struct.new       0.000005   0.000000   0.000005 (  0.000004)
Data.define      0.000042   0.000001   0.000043 (  0.000041)
OpenStruct.new   0.001642   0.000075   0.001717 (  0.001718)
----------------------------------------- total: 0.001765sec

                     user     system      total        real
Struct.new       0.000004   0.000001   0.000005 (  0.000004)
Data.define      0.000044   0.000000   0.000044 (  0.000044)
OpenStruct.new   0.001061   0.000015   0.001076 (  0.001079)
```

#### Benchmark with `ibs`

This benchmark is run with `benchmark-ips` gem.

```bash
Creating a new object - Benchmark with ips
ruby 3.3.0 (2023-12-25 revision 5124f9ac75) [arm64-darwin23]
Warming up --------------------------------------
          Struct.new    35.559k i/100ms
         Data.define     2.615k i/100ms
      OpenStruct.new    56.000 i/100ms
Calculating -------------------------------------
          Struct.new    375.213k (±10.7%) i/s -      1.885M in   5.085625s
         Data.define     25.891k (± 1.6%) i/s -    130.750k in   5.051338s
      OpenStruct.new    589.611 (± 1.0%) i/s -      2.968k in   5.034355s

Comparison:
          Struct.new:   375212.9 i/s
         Data.define:    25890.6 i/s - 14.49x  slower
      OpenStruct.new:      589.6 i/s - 636.37x  slower
```

#### Benchmark with `memory`

This benchmark is run with `benchmark-memory` gem

```bash
Creating a new object - Benchmark with ips
Calculating -------------------------------------
          Struct.new     8.040k memsize (     0.000  retained)
                         1.000  objects (     0.000  retained)
                         0.000  strings (     0.000  retained)
         Data.define    36.792k memsize (     0.000  retained)
                         2.000  objects (     0.000  retained)
                         0.000  strings (     0.000  retained)
      OpenStruct.new   791.224k memsize (     0.000  retained)
                         8.003k objects (     0.000  retained)
                        50.000  strings (     0.000  retained)

Comparison:
          Struct.new:       8040 allocated
         Data.define:      36792 allocated - 4.58x more
      OpenStruct.new:     791224 allocated - 98.41x more
```

### Accessing Attributes

#### Benchmark with `bmbm`

This benchmark is run with Ruby default benchmark using `bmbm`

```bash
Accessing attributes - bmbm test
Rehearsal -----------------------------------------------
Struct        0.000070   0.000002   0.000072 (  0.000070)
Data.define   0.000064   0.000002   0.000066 (  0.000065)
OpenStruct    0.000108   0.000005   0.000113 (  0.000113)
-------------------------------------- total: 0.000251sec

                  user     system      total        real
Struct        0.000044   0.000001   0.000045 (  0.000044)
Data.define   0.000042   0.000000   0.000042 (  0.000042)
OpenStruct    0.000090   0.000001   0.000091 (  0.000089)
```

#### Benchmark with `ibs`

This benchmark is run with `benchmark-ips` gem.

```bash
Accessing attributes - ips test
ruby 3.3.0 (2023-12-25 revision 5124f9ac75) [arm64-darwin23]
Warming up --------------------------------------
              Struct     2.741k i/100ms
         Data.define     2.799k i/100ms
          OpenStruct     1.370k i/100ms
Calculating -------------------------------------
              Struct     27.832k (± 0.2%) i/s -    139.791k in   5.022750s
         Data.define     27.989k (± 0.3%) i/s -    139.950k in   5.000245s
          OpenStruct     13.434k (± 0.5%) i/s -     68.500k in   5.099337s

Comparison:
         Data.define:    27988.9 i/s
              Struct:    27831.7 i/s - 1.01x  slower
          OpenStruct:    13433.5 i/s - 2.08x  slower
```
