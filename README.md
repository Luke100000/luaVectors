# luaVectors
## Features
* FFI boosted vec2, vec3, vec3 with plain Lua fallback alternative
* supports per component addition (+), subtraction (-), multiplication (*), division (/), modulus (%) and pow (^)
* supports equals (==)
* supports length operator (#)
* supports length(), lengthSquared(), dot() normalize(), abs(), clone(), component wise min() and max()
* supports cross() for vec3 only
* supports toString()
* can be indexed by x, y, z, w (recommended) or 1, 2, 3, 4 (slightly slower on JIT, faster on fallback)

## Usage
```lua
--automatically load best code
local vec2, vec3, vec4 = unpack(require("luaVectors"))

--or load specific
local vec3 = require("luaVectors/vec3")
local vec3_ffi = require("luaVectors/vec3_ffi")

--create vector
local v1 = vec3(1.0, 1.0, 1.0)
local v2 = vec3({1.0, 1.0, 1.0})

--use operators
local v3 = v1 * v2

--or vector specific operatios
local dot = v1:dot()
```

## Benchmark
Tested on an AMD FX-6300 single core
Benchmark code in cleanup phase and not 100% trusty
```lua
median iterations of 10 samples running each 0.1 seconds
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
operation               | create and store                                  | add number                                        | mul number                                        | div number                                        
datatype                |     number |       vec2 |       vec3 |       vec4 |     number |       vec2 |       vec3 |       vec4 |     number |       vec2 |       vec3 |       vec4 |     number |       vec2 |       vec3 |       vec4 
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FFI JIT on              |  255630 k/s    19190 k/s    17930 k/s    16920 k/s|  691440 k/s   632790 k/s   617690 k/s   601830 k/s|  542820 k/s   522190 k/s   551610 k/s   345220 k/s|  228820 k/s   124950 k/s   108460 k/s    88530 k/s|
FFI JIT off             |   32800 k/s     4240 k/s     3740 k/s     3520 k/s|  187020 k/s     2040 k/s     1700 k/s     1440 k/s|  184420 k/s     2100 k/s     1680 k/s     1440 k/s|  150860 k/s     2090 k/s     1630 k/s     1430 k/s|
Lua JIT on              |  256260 k/s    13960 k/s    13190 k/s    12810 k/s|  686850 k/s   444660 k/s   405330 k/s   397570 k/s|  560940 k/s   485770 k/s   513040 k/s   344300 k/s|  254180 k/s   119350 k/s   105340 k/s    87020 k/s|
Lua JIT off             |   33590 k/s     6120 k/s     5610 k/s     5070 k/s|  192510 k/s     4600 k/s     3960 k/s     3730 k/s|  188570 k/s     4530 k/s     3990 k/s     3640 k/s|  156230 k/s     4440 k/s     3890 k/s     3550 k/s|
```

### conclusion
FFI gives a great boost as long as JIT is enabled. If not, the fallback Lua code is by far better. That means this library is in worst case equally fast as most vectors libs flying around.

## contribution
Please notify me about errors, contributions are welcome.
