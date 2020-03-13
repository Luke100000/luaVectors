--[[
MIT License

Copyright (c) 2020 Luke100000

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
--]]

local ffi = require("ffi")
local abs = math.abs
local vec
local metatable

ffi.cdef[[
	typedef struct {
		double x, y, z, w;
	} vec4;
]]

metatable = {
	__add = function(a, b)
		if type(a) == "number" then
			return vec(a + b.x, a + b.y, a + b.z, a + b.w)
		elseif type(b) == "number" then
			return vec(a.x + b, a.y + b, a.z + b, a.w + b)
		else
			return vec(a.x + b.x, a.y + b.y, a.z + b.z, a.w + b.w)
		end
	end,
	
	__sub = function(a, b)
		if type(a) == "number" then
			return vec(a - b.x, a - b.y, a - b.z, a - b.w)
		elseif type(b) == "number" then
			return vec(a.x - b, a.y - b, a.z - b, a.w - b)
		else
			return vec(a.x - b.x, a.y - b.y, a.z - b.z, a.w - b.w)
		end
	end,
	
	__mul = function(a, b)
		if type(a) == "number" then
			return vec(a * b.x, a * b.y, a * b.z, a * b.w)
		elseif type(b) == "number" then
			return vec(a.x * b, a.y * b, a.z * b, a.w * b)
		else
			return vec(a.x * b.x, a.y * b.y, a.z * b.z, a.w * b.w)
		end
	end,
	
	__div = function(a, b)
		if type(a) == "number" then
			return vec(a / b.x, a / b.y, a / b.z, a / b.w)
		elseif type(b) == "number" then
			return vec(a.x / b, a.y / b, a.z / b, a.w / b)
		else
			return vec(a.x / b.x, a.y / b.y, a.z / b.z, a.w / b.w)
		end
	end,
	
	__mod = function(a, b)
		if type(a) == "number" then
			return vec(a % b.x, a % b.y, a % b.z, a % b.w)
		elseif type(b) == "number" then
			return vec(a.x % b, a.y % b, a.z % b, a.w % b)
		else
			return vec(a.x % b.x, a.y % b.y, a.z % b.z, a.w % b.w)
		end
	end,
	
	__unm = function(a)
		return vec(-a.x, -a.y, -a.z, -a.w)
	end,
	
	__pow = function(a, b)
		if type(a) == "number" then
			return vec(a ^ b.x, a ^ b.y, a ^ b.z, a ^ b.w)
		elseif type(b) == "number" then
			return vec(a.x ^ b, a.y ^ b, a.z ^ b, a.w ^ b)
		else
			return vec(a.x ^ b.x, a.y ^ b.y, a.z ^ b.z, a.w ^ b.w)
		end
	end,
	
	__eq = function(a, b)
		return a.x == b.x and a.y == b.y and a.z == b.z and a.w == b.w
	end,
	
	__len = function()
		return 4
	end,
	
	__tostring = function(self)
		return "{" .. self.x .. ", " .. self.y .. ", " .. self.z .. ", " .. self.w .. "}"
	end,
	
	__index = function(self, key)
		if key == 1 then
			return self.x
		elseif key == 2 then
			return self.y
		elseif key == 3 then
			return self.z
		elseif key == 4 then
			return self.w
		else
			return rawget(metatable, key)
		end
	end,
	
	clone = function(a)
		return vec(a.x, a.y, a.z, a.w)
	end,
	
	length = function(a)
		return math.sqrt(a.x * a.x + a.y * a.y + a.z * a.z + a.w * a.w)
	end,
	
	lengthSquared = function(a)
		return a.x * a.x + a.y * a.y + a.z * a.z + a.w * a.w
	end,
	
	normalize = function(a)
		return a / a:length()
	end,
	
	abs = function(a)
		return vec(abs(a.x), abs(a.y), abs(a.z), abs(a.w))
	end,
	
	dot = function(a, b)
		return a.x * b.x + a.y * b.y + a.z * b.z + a.w * b.w
	end,
	
	min = function(a, b)
		return vec(math.min(a.x, b.x), math.min(a.y, b.y), math.min(a.z, b.z), math.min(a.w, b.w))
	end,
	
	max = function(a, b)
		return vec(math.max(a.x, b.x), math.max(a.y, b.y), math.max(a.z, b.z), math.min(a.w, b.w))
	end,
}

vec = ffi.metatype("vec4", metatable)

return vec