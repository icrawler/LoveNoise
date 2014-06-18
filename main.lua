local modules = require 'lovenoise.modules'

local lnoise = love.math.noise

function love.load(dt)
	-- all the good fun stuff

	-- Creates a new Simplex Noise module with seed 20
	local testNoise1 = modules.Simplex:new(20)

	-- Sets its frequency to 0.01
	testNoise1:setFrequency(0.01)

	-- Creates a new Simplex Noise module with default seed 42
	local testNoise2 = modules.Simplex:new()

	-- Sets its frequency to 0.01
	testNoise2:setFrequency(0.01)

	-- Creates a new Min combiner module with testNoise1 and testNoise2 as its
	-- source modules
	local testNoise3 = modules.Min:new(testNoise1, testNoise2)

	-- Creating a new ImageData object that will contain the resulting noise
	local noisedata = love.image.newImageData(800, 600)

	-- Time image creation
	local t = love.timer.getTime()

	-- Populate noisedata with noise values
	for y=1, 600 do
		for x=1, 800 do
			-- Get the value of testNoise3 at x, y
			local val = testNoise3:getValue(x, y)

			-- Set a grayscale color to noisedata
			noisedata:setPixel(x-1, y-1, val*128+128, val*128+128, val*128+128, 255)
		end
	end

	-- Print the amount of time it took to generate the imagedata
	print(("Took %f seconds to generate the imagedata"):format(love.timer.getTime()-t))

	-- Create the resulting image
	noiseImage = love.graphics.newImage(noisedata)
end

function love.update(dt)

end

function love.draw(dt)
	love.graphics.draw(noiseImage)
end