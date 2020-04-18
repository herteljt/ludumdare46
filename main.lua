-- require "sprite"

function love.load()
-- Play Field
    playAreaWidth = 800
    playAreaHeight = 600

-- Loading Classes
  --  sprite.load()

  spriteX = 800 / 2
  spriteY = 600 / 2
  itemX = 600
  itemY = 400

    animation = newAnimation(love.graphics.newImage("/sprites/oldHero.png"), 16, 18, 1)

-- Obstacles
obstacle = {
  {
            x = 100,
            y = 100,
        },
        {
            x = playAreaWidth - 100,
            y = 100,
        },
        {
            x = playAreaWidth / 2,
            y = playAreaHeight - 100,
        }
}

end


function love.update(dt)
-- Sprite

    if love.keyboard.isDown('d') then
      animation.currentTime = animation.currentTime + dt
       if animation.currentTime >= animation.duration then
           animation.currentTime = animation.currentTime - animation.duration
       end
       spriteX = spriteX + 5
    end

    if love.keyboard.isDown('a') then
      animation.currentTime = animation.currentTime + dt
       if animation.currentTime >= animation.duration then
           animation.currentTime = animation.currentTime - animation.duration
       end
       spriteX = spriteX - 5
    end

    if love.keyboard.isDown('w') then
      animation.currentTime = animation.currentTime + dt
       if animation.currentTime >= animation.duration then
           animation.currentTime = animation.currentTime - animation.duration
       end
       spriteY = spriteY - 5
    end

    if love.keyboard.isDown('s') then
      animation.currentTime = animation.currentTime + dt
       if animation.currentTime >= animation.duration then
           animation.currentTime = animation.currentTime - animation.duration
       end
       spriteY = spriteY + 5
    end

-- end program
    if love.keyboard.isDown('escape') then
         love.event.quit()
    end

--[[
---starting to add bullets following https://simplegametutorials.github.io/asteroids/
    for bulletIndex, bullet in ipairs(bullets) do
         love.graphics.setColor(0, 1, 0)
         love.graphics.circle('fill', bullet.x, bullet.y, 5)
    end
    --]]
end

function love.draw()
-- Animation
    local spriteNum = math.floor(animation.currentTime / animation.duration * #animation.quads) + 1
    love.graphics.draw(animation.spriteSheet, animation.quads[spriteNum], spriteX, spriteY, 0, 4)


-- Item
    love.graphics.setColor(0, 0, 1)
    love.graphics.rectangle('fill',itemX,itemY,20,20)




-- Barriers
  love.graphics.setColor(1, 1, 1)
love.graphics.rectangle('fill', playAreaWidth/4, playAreaHeight/4, 10, 20)


-- Obstacles
  for y = -1, 1 do
        for x = -1, 1 do
            -- etc.

            for obstacleIndex, obstacle in ipairs(obstacle) do
              --  love.graphics.setColor(1, 1, 0)
                love.graphics.circle('fill', obstacle.x, obstacle.y, 80)
            end
        end
   end
end

function newAnimation(image, width, height, duration)
    local animation = {}
    animation.spriteSheet = image;
    animation.quads = {};

    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end

    animation.duration = duration or 1
    animation.currentTime = 0

    return animation
end
