require "map test/level1"

function love.load()

  love.window.setTitle("UHACC - Lundum Dare 46")

  -- Play Field
    playAreaWidth = 800
    playAreaHeight = 600

-- Loading Classes
  --  sprite.load()

  spriteX = 600
  spriteY = 200
  spriteWidth = 24
  spriteHeight = 24

  itemX = 500
  itemY = 500
  itemWidth = 48
  itemHeight = 48

  topCollision = 0
  bottomCollision = 0
  rightCollision = 0
  leftCollision = 0
  wallCollision = 0
  collisionOffset = 24

  -- Remove blur from pixel art
  love.graphics.setDefaultFilter("nearest", "nearest")

-- sprite numbers 1 = up, 2 = down, 3 = left, 4 = right
  spriteSelect = 1

  --    animation = newAnimation(love.graphics.newImage("/sprites/oldHero.png"), 16, 18, 1)
  animationDown = newAnimationDown(love.graphics.newImage("/sprites/p1_sprite_front_stand_walk_jump.png"), 24, 24, 1)
  animationUp = newAnimationUp(love.graphics.newImage("/sprites/p1_sprite_rear_stand_walk_jump.png"), 24, 24, 1)
  animationLeft = newAnimationLeft(love.graphics.newImage("/sprites/p1_sprite_left_stand_walk_jump.png"), 24, 24, 1)
  animationRight = newAnimationRight(love.graphics.newImage("/sprites/p1_sprite_right_stand_walk_jump.png"), 24, 24, 1)
  animationBump  = newAnimationRight(love.graphics.newImage("/sprites/p1_collision24x24.png"), 24, 24, 1)

  toiletpaper = love.graphics.newImage("/sprites/tp_dummy72x72.png")
  duckstart = love.graphics.newImage("/sprites/p1_sprite_front.png")
  duckbump = love.graphics.newImage("/sprites/p1_collision24x24.png")

  -- Sound
  src1 = love.audio.newSource("/sound/foodstore_demo.mp3", "static")
  src1:setLooping(true)
  src1:setVolume(.05)
  --src1:play()


end

--[[ This is the actual function to detect collision between two objects. ]]

-- Collision detection function;
-- Returns true if two boxes overlap, false if they don't;
-- x1,y1 are the top-left coords of the first box, while w1,h1 are its width and height;
-- x2,y2,w2 & h2 are the same, but for the second box.


function love.update(dt)-- Need to figure out how to make the collision stop movement. Global variable?
  updateCovid(dt)

  function checkCollision(x1,y1,w1,h1, x2,y2,w2,h2)
    return x1 < x2+w2 and
           x2 < x1+w1 and
           y1 < y2+h2 and
           y2 < y1+h1
  end

  function checkRight (x1,y1,w1,h1, x2,y2,w2,h2)
      return x1 > x2 + w2

  end

  function checkLeft (x1,y1,w1,h1, x2,y2,w2,h2)
    if x1 <= x2 + w2 and x1 then
        return 1
    else return 0
    end
  end

  function checkTop (x1,y1,w1,h1, x2,y2,w2,h2)
    if y1 <= y2 then
        return 0
    else return 1
    end
  end

  function checkBottom (x1,y1,w1,h1, x2,y2,w2,h2)
    return y2 < y1+h1
  end



-- Sprite
    if (love.keyboard.isDown('d') or love.keyboard.isDown("right")) then
        if (spriteX + 48) < (playAreaWidth) and wallCollision == 0 then
        animationRight.currentTime = animationRight.currentTime + dt
        selectSprite = 4
            if animationRight.currentTime >= animationRight.duration then
              animationRight.currentTime = animationRight.currentTime - animationRight.duration
            end
            spriteX = spriteX + 5

      end
    end

    if love.keyboard.isDown('a') or love.keyboard.isDown("left") then
      if (spriteX > 0) and leftCollision == 0 then
          animationLeft.currentTime = animationLeft.currentTime + dt
          selectSprite = 3
              if animationLeft.currentTime >= animationLeft.duration then
              animationLeft.currentTime = animationLeft.currentTime - animationLeft.duration
            end
            spriteX = spriteX - 5
      end
    end

    if love.keyboard.isDown('w') or love.keyboard.isDown("up") then
      if spriteY > 0 and topCollision == 0 then
        rightCollision = 0
        leftCollision = 0
        bottomCollision = 0
        if wallCollision == 1 then
          spriteY = spriteY + collisionOffset
          wallCollision = 0
        else
          selectSprite = 1
          animationUp.currentTime = animationUp.currentTime + dt
          if animationUp.currentTime >= animationUp.duration then
            animationUp.currentTime = animationUp.currentTime - animationUp.duration
          end
          spriteY = spriteY - 5
      end
    end
  end

  if (spriteY+ 48) < playAreaHeight and bottomCollision == 0 then
    if love.keyboard.isDown('s') or love.keyboard.isDown("down") then
      if wallCollision == 1 then
        spriteY = spriteY - collisionOffset
        wallCollision = 0
      else
        selectSprite = 2
        animationDown.currentTime = animationDown.currentTime + dt
          if animationDown.currentTime >= animationDown.duration then
           animationDown.currentTime = animationDown.currentTime - animationDown.duration
       end
       spriteY = spriteY + 5
     end
    end
end

-- reset program
    if love.keyboard.isDown('r') then
        src1:stop()
        love.load()
    end

-- end program
    if love.keyboard.isDown('escape') then
         love.event.quit()
    end

-- stop sound
        if love.keyboard.isDown('z') then
             src1:stop()
        end
--

-- Wall collision check
    for y = -1, 1 do
      for x = -1, 1 do
        for wallsIndex, walls in ipairs(walls) do
            if checkCollision(spriteX,spriteY,spriteWidth,spriteHeight, walls.x,walls.y,walls.width,walls.height) then
              wallCollision = 1
                -- rightCollision = checkRight(spriteX,spriteY,spriteWidth,spriteHeight, walls.x,walls.y,walls.width,walls.height)
              --  leftCollision = checkRight(spriteX,spriteY,spriteWidth,spriteHeight, walls.x,walls.y,walls.width,walls.height)
--[[
            if checkLeft(spriteX,spriteY,spriteWidth,spriteHeight, walls.x,walls.y,walls.width,walls.height) then
                  rightCollision = 0
                  leftCollision =  1
                  topCollision = 0
                  bottomCollision = 0
            end

            if checkRight(spriteX,spriteY,spriteWidth,spriteHeight, walls.x,walls.y,walls.width,walls.height) then
                  rightCollision = 1
                  leftCollision =  0
                  topCollision = 0
                  bottomCollision = 0
            end

            if checkTop(spriteX,spriteY,spriteWidth,spriteHeight, walls.x,walls.y,walls.width,walls.height) then
                  rightCollision = 0
                  leftCollision =  0
                  topCollision = 1
                  bottomCollision = 0
            end

            if checkBottom(spriteX,spriteY,spriteWidth,spriteHeight, walls.x,walls.y,walls.width,walls.height) then
                  rightCollision = 0
                  leftCollision =  0
                  topCollision = 0
                  bottomCollision = 1
              --]]
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
    if selectSprite == 1 then
        local spriteNum = math.floor(animationUp.currentTime / animationUp.duration * #animationUp.quads) + 1
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(animationUp.spriteSheet, animationUp.quads[spriteNum], spriteX, spriteY, 0, 1.5)
    elseif selectSprite == 2 then
        local spriteNum = math.floor(animationDown.currentTime / animationDown.duration * #animationDown.quads) + 1
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(animationDown.spriteSheet, animationDown.quads[spriteNum], spriteX, spriteY, 0, 1.5)
    elseif selectSprite == 3 and wallCollision == 0 then
        local spriteNum = math.floor(animationLeft.currentTime / animationLeft.duration * #animationLeft.quads) + 1
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(animationLeft.spriteSheet, animationLeft.quads[spriteNum], spriteX, spriteY, 0, 1.5)
     elseif selectSprite == 4 and wallCollision == 0 then
        local spriteNum = math.floor(animationRight.currentTime / animationRight.duration * #animationRight.quads) + 1
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(animationRight.spriteSheet, animationRight.quads[spriteNum], spriteX, spriteY, 0, 1.5)
  --[[    elseif selectSprite == 5 then
        local spriteNum = math.floor(animationBump.currentTime / animationBump.duration * #animationBump.quads) + 1
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(animationBump.spriteSheet, animationBump.quads[spriteNum], spriteX, spriteY, 0, 1.5)
        --]]
    end

-- Item
    love.graphics.setColor(1, 0, 1)
    love.graphics.rectangle('fill',itemX,itemY,24,24)

    love.graphics.setColor(1, 1, 1)

-- Item
    love.graphics.setColor(1, 0, 1)
    love.graphics.draw(toiletpaper, 24, 24, 0)

    love.graphics.setColor(1, 1, 1)

    --love.graphics.print("rightCollision",200,200,0,1,1,0,0,0,0)


end

function newAnimationUp(image, width, height, duration)
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


function newAnimationDown(image, width, height, duration)
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

function newAnimationLeft(image, width, height, duration)
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

function newAnimationRight(image, width, height, duration)
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

function updateCovid (dt)
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

function newAnimationBump(image, width, height, duration)
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
