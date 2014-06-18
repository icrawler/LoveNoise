-- ... shameless library info copy from kikito :P
local lovenoise = {
	_VERSION     = 'v0.2.0',
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
local MAXVAL = 2 ^ 16
local random = love.math.random
local max = math.max
local min = math.min

local lovenoise = {}

-- Contains all noise modules
lovenoise.modules = require 'lovenoise.modules'

-- Returns the maximum number of octaves for a given
-- persistence and amount of detail
function lovenoise.findOctaveLimit(persistence, aod)
    if a >= 1 then return -1 end
    return math.ceil(math.log(1/d)/math.log(a))
end

-- end--
return lovenoise