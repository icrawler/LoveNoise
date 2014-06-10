local lovenoise = require "lovenoise"

local function testMap(val)
	return val
end

function love.load(dt)
	-- all the good fun stuff
	testNoise = lovenoise.newNoise({
									   {"fractal", 130, {5, 0.5, 2}}
								   })
	testNoise:setseed(42):setmap(testMap)
	print(lovenoise.findOctaveLimit(0.5, 255))

	-- converting noise data to a grayscale image
	local noisedata = love.image.newImageData(800, 600)
	local seed = math.random()*6400
	local t = love.timer.getTime()
	for y=1, 600 do
		for x=1, 800 do
			local val = testNoise:eval(x, y)
			noisedata:setPixel(x-1, y-1, val*255, val*255, 0, 255)
		end
	end
	print(("Took %f seconds to generate"):format(love.timer.getTime()-t))
	noiseImage = love.graphics.newImage(noisedata)
end

function love.update(dt)

end

function love.draw(dt)
	love.graphics.draw(noiseImage)
end