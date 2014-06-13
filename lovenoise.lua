
local lovenoise = {
	_VERSION     = 'v0.1.5',
    _DESCRIPTION = 'Noise Library for LOVE',
    _URL         = 'https://github.com/icrawler/lovenoise',
    _LICENSE     = [[
    MIT LICENSE

    Copyright (c) 2014 Phoenix Enero

    Permission is hereby granted, free of charge, to any person obtaining a
    copy of this software and associated documentation files (the
    "Software"), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:

    The above copyright notice and this permission notice shall be included
    in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  ]]
}

-- local references
local MAXVAL = 2 ^ 32
local random = love.math.random
local max = math.max
local min = math.min

-- local variables
local Noise = {}
Noise.__index = Noise

-- presets
local preset = require("presetnoise")

-- util functions
local function clamp(v, M, m)
	M = M or 1
	m = m or 0
	return max(min(v, M), m)
end

-- Main Functions --

function lovenoise.newNoise(...)
	return Noise.new({...})
end

function lovenoise.findOctaveLimit(a, d)
	if a >= 1 then return nil end
	return math.ceil(math.log(1/d)/math.log(a))
end

function Noise.new(noisetable)
	return
	setmetatable({noisetable = noisetable, normalized=false, seed=0, threshold = -1, operation="multiply", map=nil}, Noise)
end

function Noise:setseed(seed)
	self.seed = seed or random()*MAXVAL
	return self
end

function Noise:setnormalized(normalized)
	self.normalized = normalized
	return self
end

function Noise:setthreshold(threshold)
	self.threshold = threshold
	return self
end

function Noise:setmap(map)
	if type(map) ~= "function" then return self end
	self.map = map
	return self
end

local validops = {multiply = true,
				  add = true,
				  subtract = true,
				  divide = true}

function Noise:setoperation(operation)
	if validops[operation] then
		self.operation = operation
	end
	return self
end

function Noise:evaluate(i, pos)
	if i > #self.noisetable then return 0 end
	local noise = self.noisetable[i]
	if not preset[noise[1]] then return 0 end
	if not noise[3] then
		return preset[noise[1]](pos, self.seed*i, noise[2])
	end
	return preset[noise[1]](pos, self.seed*i, noise[2], unpack(noise[3]))
end

function Noise:eval(...)
	local result = 1
	for i=1, #self.noisetable do
		local v = self:evaluate(i, {...})
		if self.operation == "multiply" then
			result = result*v
		elseif self.operation == "divide" then
			result = result/v
		elseif self.operation == "add" then
			result = result+v
		elseif self.operation == "subtract" then
			result = result-v
		end
	end
	if self.normalized then return result*2-1
	elseif self.threshold > 0 then return result > self.threshold and 1 or 0
	elseif self.map then return self.map(result) end
	return clamp(result)
end

-- end--
return lovenoise