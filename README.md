# LoveNoise - a Love Noise Wrapper library

__LoveNoise__ is a wrapper library for LOVE's noise functions.

Installation
------------

The lovenoise.lua and the presetnoise.lua files should be dropped into an existing project and require lovenoise.

```lua
lovenoise = require "lovenoise"
````

Examples
--------

Creating a new noise object:
```lua
-- This creates a new Noise object called testNoise which contains two noise
-- functions.
testNoise = lovenoise.newNoise({
								   {"fractal", 64, {3, 0.5, 2}},
								   {"simplex", 128}
							   })
-- The following lines sets testNoise's threshold and seed to 0.2 and 1337
-- respectively.
testNoise:setthreshold(0.2)
testNoise:setseed(1337)

-- The previous lines can also be done in this way:
testNoise:setthreshold(0.2):setseed(1337)
````

Using the new noise object:
```lua
-- This returns the value of the multiplied noise function values at position
-- x=0.2, y=0.5, thresholded by 0.2 and seeded by 1337.
local val = testNoise:eval(0.2, 0.5)
````

Noise Format
------------
```lua
{
	{"nameofnoise", scale, {args, if, any}},
	{"othernoise", scale, {args, if, any}},
	...
}
````

Available Noise Methods
-----------------------

###:setthreshold(threshold)
Sets the threshold for the result value. If threshold is less than 0, thresholding is disabled.

###:setseed(seed)
Sets the seed value for the noise object. If the function is called with no arguments, it's set to the default value.

###:setnormalized(normalized)
Changes whether the noise object will return a value from -1 to 1 or not.

###:setoperation(operation)
Changes which operation to use when combining noise. Valid operations: multiply, divide, add, subtract.

###:setmap(map)
Sets the mapping function to use when evaluating values. If the function is called with no arguments, it's set to nil.

Available Noise Functions
-------------------------

###"fractal"

Generates fractal noise.

Args:
* n (required) - number of octaves
* a (default: 0.5) - amplitude scaling factor
* f (default: 2) - frequency scaling factor

###"simplex"

Generates ordinary simplex noise.

No arguments.

###"ridged"

Generates ridged multi-fractal noise.

Args:
* n (required) - number of octaves
* a (default: 0.5) - amplitude scaling factor
* f (default: 2) - frequency scaling factor

Util functions
---------------

###lovenoise.findOctaveLimit(a, d)

Returns the maximum octave limit.

Args:
* a - amplitude scaling factor
* d - amount of detail

Example:
```lua
print(lovenoise.findOctaveLimit(0.5, 255))
>>> 8
````

License
-------

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