# LoveNoise - a Love Noise library

__LoveNoise__ is a wrapper library for LOVE's noise functions.

Syntax is based on [Libnoise](http://libnoise.sourceforge.net/), another noise library written in C++.

Currently only includes Simplex noise as its core noise function. Used for all the other types of noise.

Installation
------------

The `lovenoise.lua` and `presets.lua` files, the `lovenoise` and the `third-party` folder should be dropped into an existing project. After that, add this line ontop of your files that uses lovenoise.

```lua
local lovenoise = require "lovenoise"
````

Examples
--------

See main.lua.

Docs
----

See [Project Page](http://icrawler.github.io/LoveNoise/).

Use for other frameworks
------------------------

You can use this library for other frameworks, just change the `lnoise` function in line 2 of the presets.lua file to the noise function of your choice (currently uses LOVE's Simplex Noise generator.)

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