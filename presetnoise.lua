-- local references
local lnoise = love.math.noise
local abs = math.abs
local max = math.max
local min = math.min

-- util functions
local function clamp(v, M, m)
	M = M or 1
	m = m or 0
	return max(min(v, M), m)
end

-- fractal noise
local function fractalNoise1(x, n, a, f)
	local ca = 1
	local cf = 1
	local val = 0
	local v = 0
	for _=1, n do
		val = val + (lnoise(x*cf)*2-1)*ca
		ca = ca * a
		cf = cf * f
	end
	return clamp(val*0.5+0.5)
end

local function fractalNoise2(x, y, n, a, f)
	local ca = 1
	local cf = 1
	local val = 0
	local v = 0
	for _=1, n do
		val = val + (lnoise(x*cf, y*cf)*2-1)*ca
		ca = ca * a
		cf = cf * f
	end
	return clamp(val*0.5+0.5)
end

local function fractalNoise3(x, y, z, n, a, f)
	local ca = 1
	local cf = 1
	local val = 0
	local v = 0
	for _=1, n do
		val = val + (lnoise(x*cf, y*cf, z*cf)*2-1)*ca
		ca = ca * a
		cf = cf * f
	end
	return clamp(val*0.5+0.5)
end

local function fractalNoise4(x, y, z, w, n, a, f)
	local ca = 1
	local cf = 1
	local val = 0
	local v = 0
	for _=1, n do
		val = val + (lnoise(x*cf, y*cf, z*cf, w*cf)*2-1)*ca
		ca = ca * a
		cf = cf * f
	end
	return clamp(val*0.5+0.5)
end

local function fractalNoise(pos, seed, scale, n, a, f)
	local l = #pos
	a = a or 0.5
	f = f or 2
	seed = seed or 42
	if l == 1 then
		return
		fractalNoise1(pos[1]/scale+seed, n, a, f)
	elseif l == 2 then
		return
		fractalNoise2(pos[1]/scale+seed, pos[2]/scale-seed, n, a, f)
	elseif l == 3 then
		return
		fractalNoise3(pos[1]/scale+seed, pos[2]/scale-seed, pos[3]/scale+seed, n, a, f)
	elseif l == 4 then
		return
		fractalNoise4(pos[1]/scale-seed, pos[2]/scale+seed, pos[3]/scale-seed, pos[4]/scale+seed, n, a, f)
	end
	return nil
end

local function simplexNoise(pos, seed, scale)
	local l = #pos
	if l == 1 then
		return
		lnoise(pos[1]/scale+seed)
	elseif l == 2 then
		return
		lnoise(pos[1]/scale+seed, pos[2]/scale-seed)
	elseif l == 3 then
		return
		lnoise(pos[1]/scale+seed, pos[2]/scale-seed, pos[3]/scale+seed)
	elseif l == 4 then
		return
		lnoise(pos[1]/scale-seed, pos[2]/scale+seed, pos[3]/scale-seed, pos[4]/scale+seed)
	end
end

return {fractal = fractalNoise, simplex = simplexNoise}