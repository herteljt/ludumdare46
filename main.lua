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

  covidX = 200
  covidY = 200
  covidWidth = 24
  covidHeight = 24

  itemX = 500
  itemY = 500
  itemWidth = 48
  itemHeight = 48


  sampleLadyX = 510
  sampleLadyY = 380
  sampleLadyWidth = 48
  sampleLadyHeight = 24

  topCollision = 0

  bottomCollision = 0
  wallCollision = 0
  collisionOffset = 12

  rightPress = 0
  leftPress = 0
  upPress = 0
  downPress = 0

  -- Remove blur from pixel art
  love.graphics.setDefaultFilter("nearest", "nearest")

-- sprite numbers 1 = up, 2 = down, 3 = left, 4 = right
  spriteSelect = 1

  --    animation = newAnimation(love.graphics.newImage("/sprites/oldHero.png"), 16, 18, 1)
  animationDown = newAnimationDown(love.graphics.newImage("/sprites/p1_sprite_front_stand_walk_jump.png"), 24, 24, 1)
  animationUp = newAnimationUp(love.graphics.newImage("/sprites/p1_sprite_rear_stand_walk_jump.png"), 24, 24, 1)
  animationLeft = newAnimationLeft(love.graphics.newImage("/sprites/p1_sprite_left_stand_walk_jump.png"), 24, 24, 1)
  animationRight = newAnimationRight(love.graphics.newImage("/sprites/p1_sprite_right_stand_walk_jump.png"), 24, 24, 1)

  animationCovid = newAnimationCovid(love.graphics.newImage("/sprites/lvl01_bad_covid19.png"), 24, 24, 1)

  sampleLady = love.graphics.newImage("/sprites/lvl01_bad_samplelady.png")
  toiletpaper = love.graphics.newImage("/sprites/tp_dummy72x72.png")

  currentFrame = 1
  frames = {}

  table.insert(frames, love.graphics.newImage("/sprites/lvl01_shelf01_lr.png"))
  table.insert(frames, love.graphics.newImage("/sprites/lvl01_shelf02_lr.png"))
  table.insert(frames, love.graphics.newImage("/sprites/lvl01_shelf03_lr.png"))



  -- Sound
  src1 = love.audio.newSource("/sound/foodstore_demo.mp3", "static")
  src1:setLooping(true)
  src1:setVolume(.05)
--  src1:play()


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


function love.update(dt)

  currentFrame = currentFrame + dt

  if currentFrame >= 4 then
    currentFrame = 1
  end

-- Sprite
    if (spriteX + 48) < (playAreaWidth) then
      if (love.keyboard.isDown('d') or love.keyboard.isDown("right")) then
          animationRight.currentTime = animationRight.currentTime + dt
          selectSprite = 4
              if animationRight.currentTime >= animationRight.duration then
                animationRight.currentTime = animationRight.currentTime - animationRight.duration
              end
              spriteX = spriteX + 5
      end
    end


  if (spriteX) > 0 then
    if love.keyboard.isDown('a') or love.keyboard.isDown("left") then
      if wallCollision == 1 then
        spriteX = spriteX + collisionOffset
        wallCollision = 0
      elseif rightPress == 1 then
        rightPress = 0
        animationLeft.currentTime = animationLeft.currentTime + dt
        selectSprite = 3
            if animationLeft.currentTime >= animationLeft.duration then
              animationLeft.currentTime = animationLeft.currentTime - animationLeft.duration
            end
            spriteX = spriteX - 10
      else
        animationLeft.currentTime = animationLeft.currentTime + dt
        selectSprite = 3
            if animationLeft.currentTime >= animationLeft.duration then
              animationLeft.currentTime = animationLeft.currentTime - animationLeft.duration
            end
            spriteX = spriteX - 5
      end
    end
  end

-- Need to figure out how to make the collision stop movement. Global variable?
  if spriteY > 0 and topCollision == 0 then
    if love.keyboard.isDown('w') or love.keyboard.isDown("up") then
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
-- end program
    if love.keyboard.isDown('escape') then
         love.event.quit()
    end

    -- reset program
        if love.keyboard.isDown('r') then
            src1:stop()
            love.load()
        end


-- Wall collision check
    for y = -1, 1 do
      for x = -1, 1 do
        for wallsIndex, walls in ipairs(walls) do
            if CheckCollision(spriteX,spriteY,spriteWidth,spriteHeight, walls.x,walls.y,walls.width,walls.height) then
          --    love.graphics.setColor(0, 1, 1)
              wallCollision = 1
            end
        end
      end
    end

--[[
    -- Covid
      if (covidX + 48) < (playAreaWidth) then
            animationCovid.currentTime = animationCovid.currentTime + dt
                if animationCovid.currentTime >= animationCovid.duration then
                  animationCovid.currentTime = animationCovid.currentTime - animationCovid.duration
                end
                spriteX = spriteX + 5
      end
--]]

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
    if selectSprite == 1 and wallCollision == 0 then
        local spriteNum = math.floor(animationUp.currentTime / animationUp.duration * #animationUp.quads) + 1
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(animationUp.spriteSheet, animationUp.quads[spriteNum], spriteX, spriteY, 0, 1)
    elseif selectSprite == 2 and wallCollision == 0 then
        local spriteNum = math.floor(animationDown.currentTime / animationDown.duration * #animationDown.quads) + 1
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(animationDown.spriteSheet, animationDown.quads[spriteNum], spriteX, spriteY, 0, 1)
    elseif selectSprite == 3 and wallCollision == 0 then
        local spriteNum = math.floor(animationLeft.currentTime / animationLeft.duration * #animationLeft.quads) + 1
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(animationLeft.spriteSheet, animationLeft.quads[spriteNum], spriteX, spriteY, 0, 1)
     elseif selectSprite == 4 and wallCollision == 0 then
        local spriteNum = math.floor(animationRight.currentTime / animationRight.duration * #animationRight.quads) + 1
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(animationRight.spriteSheet, animationRight.quads[spriteNum], spriteX, spriteY, 0, 1)
    end

--[[
    local spriteNum = math.floor(animationCovid.currentTime / animationCovid.duration * #animationCovid.quads) + 1
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(animationCovid.spriteSheet, animationCovid.quads[spriteNum], covidX, covidY, 0, 1.5)
--]]


  -- Sample Lady

    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(sampleLady,sampleLadyX, sampleLadyY,0)
    --love.graphics.rectangle('fill',itemX,itemY,24,24)

    love.graphics.setColor(1, 1, 1)

-- Item
    love.graphics.setColor(1, 0, 1)
    love.graphics.draw(toiletpaper, 24, 24, 0)

    love.graphics.setColor(1, 1, 1)

    love.graphics.draw(frames[math.floor(currentFrame)],400, 400,0)

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


function newAnimationCovid(image, width, height, duration)
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
