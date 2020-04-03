# luaVectors
## Features
* plain Lua vector library
* supports per component addition (+), subtraction (-), multiplication (*), division (/), modulus (%) and pow (^)
* supports equals (==)
* supports length operator (#)
* supports length(), lengthSquared(), dot() normalize(), abs(), clone(), component wise min() and max()
* supports cross() for vec3 only
* supports toString()
* can be indexed by x, y, z, w (without JIT 50% slower, else equal) or 1, 2, 3, 4

## Usage
```lua
local vec2 = require("luaVectors/vec2")
local vec3 = require("luaVectors/vec3")
local vec4 = require("luaVectors/vec4")

--create vector
local v1 = vec3(1.0, 1.0, 1.0)
local v2 = vec3({1.0, 1.0, 1.0})

--use operators
local v3 = v1 * v2

--or vector specific operatios
local dot = v1:dot()
```

## contribution
Please notify me about errors, contributions are welcome.