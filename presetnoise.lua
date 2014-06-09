-- local references
local lnoise = love.math.noise
local abs = function(a) return a < 0 and -a or a end
local max = math.max
local min = math.min

-- util functions
local function clamp01(v)
	return (v > 1 and 1 or v) < 0 and 0 or v
end

-- fractal noise
local function fractalNoise1(x, n, a, f)
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
	return val/v*0.5+0.5
end

local function fractalNoise2(x, y, n, a, f)
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
	return val/v*0.5+0.5
end

local function fractalNoise3(x, y, z, n, a, f)
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
	return val/v*0.5+0.5
end

local function fractalNoise4(x, y, z, w, n, a, f)
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
	return val/v*0.5+0.5
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

-- simplex noise
local function simplexNoise(pos, seed, scale)
	local l = #pos
	seed = seed or 42
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

-- ridged multifractal noise
local function ridgedNoise1(x, n, a, f)
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
	return val/v
end

local function ridgedNoise2(x, y, n, a, f)
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
	return val/v
end

local function ridgedNoise3(x, y, z, n, a, f)
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
	return val/v
end

local function ridgedNoise4(x, y, z, w, n, a, f)
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
	return val/v
end

local function ridgedNoise(pos, seed, scale, n, a, f)
	local l = #pos
	a = a or 0.5
	f = f or 2
	seed = seed or 42
	if l == 1 then
		return
		ridgedNoise1(pos[1]/scale+seed, n, a, f)
	elseif l == 2 then
		return
		ridgedNoise2(pos[1]/scale+seed, pos[2]/scale-seed, n, a, f)
	elseif l == 3 then
		return
		ridgedNoise3(pos[1]/scale+seed, pos[2]/scale-seed, pos[3]/scale+seed, n, a, f)
	elseif l == 4 then
		return
		ridgedNoise4(pos[1]/scale-seed, pos[2]/scale+seed, pos[3]/scale-seed, pos[4]/scale+seed, n, a, f)
	end
	return nil
end

return {fractal = fractalNoise, simplex = simplexNoise, ridged = ridgedNoise}