-- CONSTANTS
local MAXVAL = 2 ^ 16

-- LOCAL REFERENCES
local random = love.math.random
local max = math.max
local min = math.min

-- Require needed fails
local class = require('third-party.middleclass')
local presets = require('lovenoise.presets')

-- [[ Module Abstract Class ]] --

local Module = class('LoveNoise.Module')

function Module:initialize() self.sources = nil end

-- Adds a source module at an index. Indices are one-based
function Module:addSource(index, source)
    if not self.sources then self.sources={} end
    self.sources[index] = source
end

function Module:getValue(...)
    return -1
end

-- [[ end ]] --

-- [[ NoiseModule superclass ]]--

local NoiseModule = class("LoveNoise.NoiseModule")

    -- Initializes a module
    function NoiseModule:initialize(seed, frequency)
        self.seed = seed or 42
        self.frequency = frequency or 1
    end

    -- Sets the seed for the module
    function NoiseModule:setSeed(seed)
        self.seed=seed
        return self
    end

    -- Sets the frequency for the module
    function NoiseModule:setFrequency(frequency)
        self.frequency=frequency
        return self
    end

    -- Gets the value of a coherent-noise function at a certain position
    function NoiseModule:getValue(...)
        return -1
    end

-- [[ end ]] --

-- [[ Fractal Noise Module ]] --
-- Inherits from NoiseModule

local Fractal = class('LoveNoise.Generator.Fractal', NoiseModule)

    -- Initializes a Fractal module
    -- Args:
    --  * octaves - number of octaves or levels of detail
    --  * lacunarity - how quickly the frequencies increases for each octave
    --  * persistence - how quickly the amplitudes diminish for each octave
    --  * seed - a value that changes the output of a noise function
    function Fractal:initialize( octaves,
                                 lacunarity,
                                 persistence,
                                 seed,
                                 frequency )
        NoiseModule.initialize(self, seed, frequency)
        self.octaves = octaves or 1
        self.lacunarity = lacunarity or 2
        self.persistence = persistence or 0.5

    end

    -- Sets the number of octaves
    function Fractal:setOctaves(octaves)
        self.octaves=octaves or 1
        return self
    end

    -- Sets the lacunarity value
    function Fractal:setLacunarity(lacunarity)
        self.lacunarity=lacunarity
        return self
    end

    -- Sets the persistence value
    function Fractal:setPersistence(persistence)
        self.persistence=persistence
        return self
    end

    function Fractal:getValue(...)
        return presets.fractal( {...},
                                self.seed,
                                self.frequency,
                                self.octaves,
                                self.persistence,
                                self.lacunarity )
    end

-- [[ end ]] --

-- [[ Ridged-Multifractal Noise Module ]] --
-- Inherits from Fractal

local RidgedMulti = class('LoveNoise.Generator.RidgedMulti', Fractal)

    function RidgedMulti:getValue(...)
        return presets.ridgedMulti( {...},
                                    self.seed,
                                    self.frequency,
                                    self.octaves,
                                    self.persistence,
                                    self.lacunarity )
    end

-- [[ end ]] --

-- [[ Billow Noise Module ]] --
-- Inherits from Fractal

local Billow = class('LoveNoise.Generator.Billow', Fractal)

    function Billow:getValue(...)
        return presets.billow( {...},
                               self.seed,
                               self.frequency,
                               self.octaves,
                               self.persistence,
                               self.lacunarity )
    end

-- [[ Simplex Noise Module (internal implemntation) ]] --
-- inherits from NoiseModule

local Simplex = class('LoveNoise.Generator.Simplex', NoiseModule)

    function Simplex:getValue(...)
        return presets.simplex( {...},
                                self.seed,
                                self.frequency)
    end

-- [[ end ]] --

-- [[ Add Module ]] --
-- Inherits from Module

local Add = class('LoveNoise.Combiner.Add', Module)

-- Initializes an Add module with sources source1 and source2
function Add:initialize(source1, source2)
    self.sources = {source1, source2}
end

-- Gets the combined value of the two sources
function Add:getValue(...)
    return self.sources[1]:getValue(...) + self.sources[2]:getValue(...)
end

-- [[ end ]] --

-- [[ Max Module ]] --
-- Inherits from Module

local Max = class('LoveNoise.Combiner.Max', Module)

-- Initializes a Max module with sources source1 and source2
function Max:initialize(source1, source2)
    self.sources = {source1, source2}
end

-- Gets the maximum value of the two sources
function Max:getValue(...)
    return max(self.sources[1]:getValue(...), self.sources[2]:getValue(...))
end

-- [[ end ]] --

-- [[ Min Module ]] --
-- Inherits from Module

local Min = class('LoveNoise.Combiner.Min', Module)

-- Initializes a Min module with sources source1 and source2
function Min:initialize(source1, source2)
    self.sources = {source1, source2}
end

-- Gets the minimum value of the two sources
function Min:getValue(...)
    return min(self.sources[1]:getValue(...), self.sources[2]:getValue(...))
end

-- [[ end ]] --

-- [[ Multiply Module ]] --
-- Inherits from Module

local Multiply = class('LoveNoise.Combiner.Multiply', Module)

-- Initializes a Multiply module with sources source1 and source2
function Multiply:initialize(source1, source2)
    self.sources = {source1, source2}
end

-- Gets the multiplied value of the two sources
function Multiply:getValue(...)
    return self.sources[1]:getValue(...) * self.sources[2]:getValue(...)
end

-- [[ end ]] --

-- [[ Power Module ]] --
-- Inherits from Module

local Power = class('LoveNoise.Combiner.Power', Module)

-- Initializes a Power module with sources source1 and source2
function Power:initialize(source1, source2)
    self.sources = {source1, source2}
end

-- Gets the value of the first source raised by the value of the second source
function Power:getValue(...)
    return self.sources[1]:getValue(...) ^ self.sources[2]:getValue(...)
end

-- [[ end ]] --


-- [[ Invert Module ]] --
-- Inherits from Module

local Invert = class('LoveNoise.Modifier.Invert', Module)

-- Initializes a Power module with sources source1 and source2
function Invert:initialize(source)
    self.sources = {source1}
end

-- Gets the value of the source inverted
function Invert:getValue(...)
    return -self.sources[1]:getValue(...)
end



-- Return a table containing all modules
return {
            -- Generator Modules
            Fractal=Fractal,
            RidgedMulti=RidgedMulti,
            Simplex=Simplex,
            Billow=Billow,

            -- Combiner Modules
            Add=Add,
            Max=Max,
            Min=Min,
            Multiply=Multiply,
            Power=Power,

            -- Modifier Modules
            Invert=Invert
        }