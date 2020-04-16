function love.load()
    shipX = 800 / 2
    shipY = 600 / 2
    shipAngle = 0

    shootSfx = love.audio.newSource("sound/laser6.ogg", "static")
    bullets = {}

end


function love.update(dt)
-- move small circle
    if love.keyboard.isDown('right') then
         shipAngle = shipAngle + 10 * dt
    end

    if love.keyboard.isDown('left') then
         shipAngle = shipAngle - 10 * dt
    end

    -- move large circle
    if love.keyboard.isDown('w') then
        shipY = shipY - 5
    end

    if love.keyboard.isDown('s') then
        shipY = shipY + 5
    end

    if love.keyboard.isDown('d') then
        shipX = shipX + 5
        --shootSfx:play()
    end

    if love.keyboard.isDown('a') then
        shipX = shipX - 5
    end

    if love.keyboard.isDown('f') then
        playSound(shootSfx)
    end

-- end program
    if love.keyboard.isDown('escape') then
         love.event.quit()
    end

---starting to add bullets following https://simplegametutorials.github.io/asteroids/
    for bulletIndex, bullet in ipairs(bullets) do
         love.graphics.setColor(0, 1, 0)
         love.graphics.circle('fill', bullet.x, bullet.y, 5)
    end
end

function love.draw()
    love.graphics.setColor(1, 1, 0)
    love.graphics.circle('fill', shipX, shipY, 30)

    love.graphics.setColor(0, 1, 1)
    local shipCircleDistance = 20
    love.graphics.circle(
        'fill',
        shipX + math.cos(shipAngle) * shipCircleDistance,
        shipY + math.sin(shipAngle) * shipCircleDistance,
        5
    )

    -- Temporary
    love.graphics.setColor(1, 1, 1)
    love.graphics.print('shipAngle: '..shipAngle)
end

function playSound(sound)
  --sound:rewind(sound)
  pitchMod = 0.5 + love.math.random(0, 10)/25
  sound:setPitch(pitchMod)
  sound:stop()
  sound:play()
end
