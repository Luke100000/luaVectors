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
		double x, y;
	} vec2;
]]

metatable = {
	__add = function(a, b)
		if type(a) == "number" then
			return vec(a + b.x, a + b.y)
		elseif type(b) == "number" then
			return vec(a.x + b, a.y + b)
		else
			return vec(a.x + b.x, a.y + b.y)
		end
	end,
	
	__sub = function(a, b)
		if type(a) == "number" then
			return vec(a - b.x, a - b.y)
		elseif type(b) == "number" then
			return vec(a.x - b, a.y - b)
		else
			return vec(a.x - b.x, a.y - b.y)
		end
	end,
	
	__mul = function(a, b)
		if type(a) == "number" then
			return vec(a * b.x, a * b.y)
		elseif type(b) == "number" then
			return vec(a.x * b, a.y * b)
		else
			return vec(a.x * b.x, a.y * b.y)
		end
	end,
	
	__div = function(a, b)
		if type(a) == "number" then
			return vec(a / b.x, a / b.y)
		elseif type(b) == "number" then
			return vec(a.x / b, a.y / b)
		else
			return vec(a.x / b.x, a.y / b.y)
		end
	end,
	
	__mod = function(a, b)
		if type(a) == "number" then
			return vec(a % b.x, a % b.y)
		elseif type(b) == "number" then
			return vec(a.x % b, a.y % b)
		else
			return vec(a.x % b.x, a.y % b.y)
		end
	end,
	
	__unm = function(a)
		return vec(-a.x, -a.y, -a.z)
	end,
	
	__pow = function(a, b)
		if type(a) == "number" then
			return vec(a ^ b.x, a ^ b.y)
		elseif type(b) == "number" then
			return vec(a.x ^ b, a.y ^ b)
		else
			return vec(a.x ^ b.x, a.y ^ b.y)
		end
	end,
	
	__eq = function(a, b)
		return a.x == b.x and a.y == b.y
	end,
	
	__len = function()
		return 2
	end,
	
	__tostring = function(self)
		return "{" .. self.x .. ", " .. self.y .. "}"
	end,
	
	__index = function(self, key)
		if key == 1 then
			return self.x
		elseif key == 2 then
			return self.y
		else
			return rawget(metatable, key)
		end
	end,
	
	clone = function(a)
		return vec(a.x, a.y)
	end,
	
	length = function(a)
		return math.sqrt(a.x * a.x + a.y * a.y)
	end,
	
	lengthSquared = function(a)
		return a.x * a.x + a.y * a.y
	end,
	
	normalize = function(a)
		return a / a:length()
	end,
	
	abs = function(a)
		return vec(abs(a.x), abs(a.y))
	end,
	
	dot = function(a, b)
		return a.x * b.x + a.y * b.y
	end,
}

vec = ffi.metatype("vec2", metatable)

return vec