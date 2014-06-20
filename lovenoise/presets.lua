-- local references
local lnoise = love.math.noise -- Can be modified for other frameworks
local abs = function(a) return a < 0 and -a or a end
local max = math.max
local min = math.min

-- util functions
local function clamp01(v)
	return (v > 1 and 1 or v) < 0 and 0 or v
end

-- [[ Fractal Noise ]] --

-- 1D
local function fractal1(x, n, a, f)
	if n == 1 then return lnoise(x)*2-1 end
	local ca = 1
	local cf = 1
	local val = 0
	local v = 0
	for _=1, n do
		val = val + (lnoise(x*cf)*2-1)*ca
		v = v + ca
		ca = ca * a
		cf = cf * f
	end
	return val/v
end

-- 2D
local function fractal2(x, y, n, a, f)
	if n == 1 then return lnoise(x, y)*2-1 end
	local ca = 1
	local cf = 1
	local val = 0
	local v = 0
	for _=1, n do
		val = val + (lnoise(x*cf, y*cf)*2-1)*ca
		v = v + ca
		ca = ca * a
		cf = cf * f
	end
	return val/v
end

-- 3D
local function fractal3(x, y, z, n, a, f)
	if n == 1 then return lnoise(x, y, z)*2-1 end
	local ca = 1
	local cf = 1
	local val = 0
	local v = 0
	for _=1, n do
		val = val + (lnoise(x*cf, y*cf, z*cf)*2-1)*ca
		v = v + ca
		ca = ca * a
		cf = cf * f
	end
	return val/v
end

-- 4D
local function fractal4(x, y, z, w, n, a, f)
	if n == 1 then return lnoise(x, y, z, w)*2-1 end
	local ca = 1
	local cf = 1
	local val = 0
	local v = 0
	for _=1, n do
		val = val + (lnoise(x*cf, y*cf, z*cf, w*cf)*2-1)*ca
		v = v + ca
		v = v + ca
		ca = ca * a
		cf = cf * f
	end
	return val/v
end

-- Main function
local function fractal(pos, seed, frequency, n, a, f)
	local l = #pos
	local s = frequency
	if l == 1 then
		return
		fractal1(pos[1]*s+seed, n, a, f)
	elseif l == 2 then
		return
		fractal2(pos[1]*s+seed, pos[2]*s-seed, n, a, f)
	elseif l == 3 then
		return
		fractal3(pos[1]*s+seed, pos[2]*s-seed, pos[3]*s+seed, n, a, f)
	elseif l == 4 then
		return
		fractal4(pos[1]*s-seed, pos[2]*s+seed, pos[3]*s-seed, pos[4]*s+seed, n, a, f)
	end
	return nil
end

-- simplex noise
local function simplex(pos, seed, frequency)
	local l = #pos
	local s = frequency
	if l == 1 then
		return
		lnoise(pos[1]*s+seed)*2-1
	elseif l == 2 then
		return
		lnoise(pos[1]*s+seed, pos[2]*s-seed)*2-1
	elseif l == 3 then
		return
		lnoise(pos[1]*s+seed, pos[2]*s-seed, pos[3]*s+seed)*2-1
	elseif l == 4 then
		return
		lnoise(pos[1]*s-seed, pos[2]*s+seed, pos[3]*s-seed, pos[4]*s+seed)*2-1
	end
end

-- ridged multifractal noise
local function ridged1(x, n, a, f)
	local ca = 1
	local cf = 1
	local val = 0
	local v = 0
	for _=1, n do
		local s = (1-abs(lnoise(x*cf)*2-1))
		val = val + s*s*ca
		v = v + ca
		ca = ca * a
		cf = cf * f
	end
	return val/v*2-1
end

local function ridged2(x, y, n, a, f)
	local ca = 1
	local cf = 1
	local val = 0
	local v = 0
	for _=1, n do
		local s = (1-abs(lnoise(x*cf, y*cf)*2-1))
		val = val + s*s*ca
		v = v + ca
		ca = ca * a
		cf = cf * f
	end
	return val/v*2-1
end

local function ridged3(x, y, z, n, a, f)
	local ca = 1
	local cf = 1
	local val = 0
	local v = 0
	for _=1, n do
		local s = (1-abs(lnoise(x*cf, y*cf, z*cf)*2-1))
		val = val + s*s*ca
		v = v + ca
		ca = ca * a
		cf = cf * f
	end
	return val/v*2-1
end

local function ridged4(x, y, z, w, n, a, f)
	local ca = 1
	local cf = 1
	local val = 0
	local v = 0
	for _=1, n do
		local s = (1-abs(lnoise(x*cf, y*cf, z*cf, w*cf)*2-1))
		val = val + s*s*ca
		v = v + ca
		ca = ca * a
		cf = cf * f
	end
	return val/v*2-1
end

local function ridgedMulti(pos, seed, frequency, n, a, f)
	local l = #pos
	local s = frequency
	if l == 1 then
		return
		ridged1(pos[1]*s+seed, n, a, f)
	elseif l == 2 then
		return
		ridged2(pos[1]*s+seed, pos[2]*s-seed, n, a, f)
	elseif l == 3 then
		return
		ridged3(pos[1]*s+seed, pos[2]*s-seed, pos[3]*s+seed, n, a, f)
	elseif l == 4 then
		return
		ridged4(pos[1]*s-seed, pos[2]*s+seed, pos[3]*s-seed, pos[4]*s+seed, n, a, f)
	end
	return nil
end

-- billow noise
local function billow1(x, n, a, f)
	local ca = 1
	local cf = 1
	local val = 0
	local v = 0
	for _=1, n do
		local s = abs(lnoise(x*cf)*2-1)
		val = val + s*ca
		v = v + ca
		ca = ca * a
		cf = cf * f
	end
	return val/v*2-1
end

local function billow2(x, y, n, a, f)
	local ca = 1
	local cf = 1
	local val = 0
	local v = 0
	for _=1, n do
		local s = abs(lnoise(x*cf, y*cf)*2-1)
		val = val + s*ca
		v = v + ca
		ca = ca * a
		cf = cf * f
	end
	return val/v*2-1
end

local function billow3(x, y, z, n, a, f)
	local ca = 1
	local cf = 1
	local val = 0
	local v = 0
	for _=1, n do
		local s = abs(lnoise(x*cf, y*cf, z*cf)*2-1)
		val = val + s*ca
		v = v + ca
		ca = ca * a
		cf = cf * f
	end
	return val/v*2-1
end

local function billow4(x, y, z, w, n, a, f)
	local ca = 1
	local cf = 1
	local val = 0
	local v = 0
	for _=1, n do
		local s = abs(lnoise(x*cf, y*cf, z*cf, w*cf)*2-1)
		val = val + s*ca
		v = v + ca
		ca = ca * a
		cf = cf * f
	end
	return val/v*2-1
end

local function billow(pos, seed, frequency, n, a, f)
	local l = #pos
	local s = frequency
	if l == 1 then
		return
		billow1(pos[1]*s+seed, n, a, f)
	elseif l == 2 then
		return
		billow2(pos[1]*s+seed, pos[2]*s-seed, n, a, f)
	elseif l == 3 then
		return
		billow3(pos[1]*s+seed, pos[2]*s-seed, pos[3]*s+seed, n, a, f)
	elseif l == 4 then
		return
		billow4(pos[1]*s-seed, pos[2]*s+seed, pos[3]*s-seed, pos[4]*s+seed, n, a, f)
	end
	return nil
end

return {fractal = fractal, simplex = simplex, ridgedMulti = ridgedMulti,
		billow = billow}