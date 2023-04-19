function love.setup()
    print("Hello world")
end

local valid_octaves = {
    [2] = 4,
    [3] = 4,
    [4] = 4,
    [5] = 4,
    [6] = 4
}

function math.clamp(n, min, max)
    return math.max(math.min(n, max), min)
end

function validate_octave(octave)
    if valid_octaves[octave] then return valid_octaves[octave] end
    return validate_octave(math.clamp(octave, 2, 6))
end

function filename(note, octave)
    return note .. validate_octave(octave) .. ".mov" 
end

function new_video(note_filename)
    return love.graphics.newVideo("/data/" .. note_filename)
end

-- print("/data/C1.mov", love.filesystem.read("/data/C1.mov"))

local c1 = new_video(filename("C", 1))

coroutine.resume(
    coroutine.create(function()
        c1:play()
    end)
)

function love.draw()
    love.graphics.print("Hello World", 400, 300)

    love.graphics.draw(c1, 30, 30)
end

