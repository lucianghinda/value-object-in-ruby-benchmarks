# Micro Benchmarks on Value Object options in Ruby

A series of micro benchmarks about Data.define vs Struct vs OpenStruct in #Ruby.

This is executed with defaults, no extra settings added.

The tests are focused on using keyword arguments. The results might be different when using positional arguments.

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
Struct.new       0.000023   0.000003   0.000026 (  0.000024)
Data.define      0.000020   0.000001   0.000021 (  0.000022)
OpenStruct.new   0.001705   0.000075   0.001780 (  0.001780)
----------------------------------------- total: 0.001827sec

                     user     system      total        real
Struct.new       0.000020   0.000000   0.000020 (  0.000020)
Data.define      0.000022   0.000000   0.000022 (  0.000022)
OpenStruct.new   0.001069   0.000044   0.001113 (  0.001132)
```

#### Benchmark with `ibs`

This benchmark is run with `benchmark-ips` gem.

```bash
Creating a new object - Benchmark with ips
ruby 3.3.0 (2023-12-25 revision 5124f9ac75) [arm64-darwin23]
Warming up --------------------------------------
          Struct.new     5.169k i/100ms
         Data.define     5.361k i/100ms
      OpenStruct.new    62.000 i/100ms
Calculating -------------------------------------
          Struct.new     50.086k (± 1.7%) i/s -    253.281k in   5.058450s
         Data.define     51.646k (± 1.1%) i/s -    262.689k in   5.086990s
      OpenStruct.new    607.447 (± 0.8%) i/s -      3.038k in   5.001584s

Comparison:
         Data.define:    51646.3 i/s
          Struct.new:    50085.7 i/s - 1.03x  slower
      OpenStruct.new:      607.4 i/s - 85.02x  slower
```

#### Benchmark with `memory`

This benchmark is run with `benchmark-memory` gem

```bash
Creating a new object - Benchmark with ips
Calculating -------------------------------------
          Struct.new    36.792k memsize (     0.000  retained)
                         2.000  objects (     0.000  retained)
                         0.000  strings (     0.000  retained)
         Data.define    36.792k memsize (     0.000  retained)
                         2.000  objects (     0.000  retained)
                         0.000  strings (     0.000  retained)
      OpenStruct.new   848.728k memsize (     0.000  retained)
                         8.005k objects (     0.000  retained)
                        50.000  strings (     0.000  retained)

Comparison:
          Struct.new:      36792 allocated
         Data.define:      36792 allocated - same
      OpenStruct.new:     848728 allocated - 23.07x more
```

### Accessing Attributes

#### Benchmark with `bmbm`

This benchmark is run with Ruby default benchmark using `bmbm`

```bash
Accessing attributes - bmbm test
Rehearsal -----------------------------------------------
Struct        0.000069   0.000002   0.000071 (  0.000071)
Data.define   0.000069   0.000003   0.000072 (  0.000071)
OpenStruct    0.000110   0.000003   0.000113 (  0.000116)
-------------------------------------- total: 0.000256sec

                  user     system      total        real
Struct        0.000049   0.000001   0.000050 (  0.000046)
Data.define   0.000046   0.000001   0.000047 (  0.000046)
OpenStruct    0.000091   0.000001   0.000092 (  0.000094)
```

#### Benchmark with `ibs`

This benchmark is run with `benchmark-ips` gem.

```bash
Accessing attributes - ips test
ruby 3.3.0 (2023-12-25 revision 5124f9ac75) [arm64-darwin23]
Warming up --------------------------------------
              Struct     2.857k i/100ms
         Data.define     2.828k i/100ms
          OpenStruct     1.384k i/100ms
Calculating -------------------------------------
              Struct     28.420k (± 0.9%) i/s -    142.850k in   5.026906s
         Data.define     28.691k (± 0.5%) i/s -    144.228k in   5.027131s
          OpenStruct     13.475k (± 0.9%) i/s -     67.816k in   5.033315s

Comparison:
         Data.define:    28690.8 i/s
              Struct:    28419.6 i/s - same-ish: difference falls within error
          OpenStruct:    13474.6 i/s - 2.13x  slower
```
