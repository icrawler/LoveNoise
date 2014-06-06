
local lovenoise = {
	_VERSION     = 'v0.1.1',
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
local random = math.random

-- local variables
local Noise = {}
Noise.__index = Noise

-- presets
local preset = require("presetnoise")

-- Main Functions --

function lovenoise.newNoise(noisetable)
	return Noise.new(noisetable)
end

function Noise.new(noisetable)
	return
	setmetatable({noisetable = noisetable, normalized=false, seed=0, threshold = -1}, Noise)
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

function Noise:evaluate(x, y, i)
	if i > #self.noisetable then return 0 end
	local noise = self.noisetable[i]
	if not preset[noise[1]] then return 0 end
	if not noise[3] then
		return preset[noise[1]]({x, y}, self.seed*i, noise[2])
	end
	return preset[noise[1]]({x, y}, self.seed*i, noise[2], unpack(noise[3]))
end

function Noise:eval(x, y)
	local result = 1
	for i=1, #self.noisetable do
		result = result*self:evaluate(x, y, i)
	end
	if self.normalized then return result*2-1 end
	if self.threshold > 0 then return result > self.threshold and 1 or 0 end
	return result
end

-- end--
return lovenoise