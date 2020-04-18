require "map test/level1"
function love.load()

  love.window.setTitle("UHACC - Lundum Dare 46")

  -- Play Field
    playAreaWidth = 800
    playAreaHeight = 600

-- Loading Classes
  --  sprite.load()

  spriteX = 800 / 2
  spriteY = 600 / 2
  spriteWidth = 24
  spriteHeight = 24

  itemX = 500
  itemY = 500
  itemWidth = 48
  itemHeight = 48

  topCollision = 0
  bottomCollision = 0
  wallCollision = 0

  -- Remove blur from pixel art
  love.graphics.setDefaultFilter("nearest", "nearest")

  --    animation = newAnimation(love.graphics.newImage("/sprites/oldHero.png"), 16, 18, 1)
  animation = newAnimation(love.graphics.newImage("/sprites/p1_sprite_front_stand_walk_jump.png"), 24, 24, 1)


end

--[[ This is the actual function to detect collision between two objects. ]]

-- Collision detection function;
-- Returns true if two boxes overlap, false if they don't;
-- x1,y1 are the top-left coords of the first box, while w1,h1 are its width and height;
-- x2,y2,w2 & h2 are the same, but for the second box.


function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

--[[

function checkCollision(x,y,z)
  return x < y + z
end
--]]


function love.update(dt)
-- Sprite
    if (spriteX + 48) < (playAreaWidth) then
          if love.keyboard.isDown('d') or love.keyboard.isDown("right") then
            animation.currentTime = animation.currentTime + dt
              if animation.currentTime >= animation.duration then
                animation.currentTime = animation.currentTime - animation.duration
              end
              spriteX = spriteX + 5
          end
    end

  if (spriteX) > 0 then
    if love.keyboard.isDown('a') or love.keyboard.isDown("left") then
      animation.currentTime = animation.currentTime + dt
       if animation.currentTime >= animation.duration then
           animation.currentTime = animation.currentTime - animation.duration
       end
       spriteX = spriteX - 5
    end
  end

-- Need to figure out how to make the collision stop movement. Global variable?
  if spriteY > 0 and topCollision == 0 then
    if love.keyboard.isDown('w') or love.keyboard.isDown("up") then
      bottomCollision = 0
      animation.currentTime = animation.currentTime + dt
       if animation.currentTime >= animation.duration then
           animation.currentTime = animation.currentTime - animation.duration
       end
       spriteY = spriteY - 5
    end
  end

  if (spriteY+ 48) < playAreaHeight and bottomCollision == 0 then
    if love.keyboard.isDown('s') or love.keyboard.isDown("down") then
      topCollision = 0
      animation.currentTime = animation.currentTime + dt
       if animation.currentTime >= animation.duration then
           animation.currentTime = animation.currentTime - animation.duration
       end
       spriteY = spriteY + 5
    end
end
-- end program
    if love.keyboard.isDown('escape') then
         love.event.quit()
    end

--[[
    if CheckCollision(spriteX,spriteY,spriteWidth,spriteHeight, itemX,itemY,itemWidth,itemHeight) then
        love.graphics.setColor(0, 1, 1)
        wallCollision = 1
    end
--]]

-- Wall collision check
    for y = -1, 1 do
      for x = -1, 1 do
        for wallsIndex, walls in ipairs(walls) do
            if CheckCollision(spriteX,spriteY,spriteWidth,spriteHeight, walls.x,walls.y,walls.width,walls.height) then
              love.graphics.setColor(0, 1, 1)
              wallCollision = 1
            end
        end
      end
    end

end

function love.draw()
  love.graphics.rectangle('fill', 0, 0, playAreaWidth, playAreaHeight)

  -- Draw walls
    for y = -1, 1 do
      for x = -1, 1 do
        for wallsIndex, walls in ipairs(walls) do
          love.graphics.setColor(walls.red, walls.green, walls.blue)
          love.graphics.rectangle("fill", walls.x, walls.y, walls.width, walls.height)
        end
      end
    end

-- Animation
    local spriteNum = math.floor(animation.currentTime / animation.duration * #animation.quads) + 1
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(animation.spriteSheet, animation.quads[spriteNum], spriteX, spriteY, 0, 2)


-- Item
    love.graphics.setColor(1, 0, 1)
    love.graphics.rectangle('fill',itemX,itemY,24,24)

    love.graphics.setColor(1, 1, 1)


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
