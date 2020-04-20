require "map test/level1"
--require "tile-test/map"

function love.load()

  love.window.setTitle("UHACC - Lundum Dare 46")

  -- Play Field
    playAreaWidth = 800
    playAreaHeight = 600

-- Loading Classes
  characterScale = 1.5

  --  sprite.load()
  collisionOffset = 12

  spriteX = 430
  spriteY = 300
  spriteStartX = 430
  spriteStartY = 300
  spriteWidth = 24*characterScale
  spriteHeight = 24*characterScale

  covidStartX = 200
  covidStartY = 200
  covidX = 200
  covidY = 200
  covidWidth = 24*characterScale
  covidHeight = 24*characterScale

  itemX = 500
  itemY = 500
  itemWidth = 24*characterScale
  itemHeight = 24*characterScale


  sampleLadyX = 510
  sampleLadyY = 380
  sampleLadyWidth = 48*characterScale
  sampleLadyHeight = 24*characterScale


  tptimerX = 24
  tptimerY = 24
  tptimerWidth = 72
  tptimerHeight = 72


  wallCollision = 0
  rightCollision = 0
  leftCollision = 0
  upCollision = 0
  downCollision = 0


  rightPress = 0
  leftPress = 0
  upPress = 0
  downPress = 0

  -- Remove blur from pixel art
  love.graphics.setDefaultFilter("nearest", "nearest")

-- sprite numbers 1 = up, 2 = down, 3 = left, 4 = right
  spriteSelect = 0

  --    animation = newAnimation(love.graphics.newImage("/sprites/oldHero.png"), 16, 18, 1)
  animationDown = newAnimationDown(love.graphics.newImage("/sprites/p1_sprite_front_stand_walk_jump.png"), 24, 24, 1)
  animationUp = newAnimationUp(love.graphics.newImage("/sprites/p1_sprite_rear_stand_walk_jump.png"), 24, 24, 1)
  animationLeft = newAnimationLeft(love.graphics.newImage("/sprites/p1_sprite_left_stand_walk_jump.png"), 24, 24, 1)
  animationRight = newAnimationRight(love.graphics.newImage("/sprites/p1_sprite_right_stand_walk_jump.png"), 24, 24, 1)

  animationCovid = newAnimationCovid(love.graphics.newImage("/sprites/lvl01_bad_covid19.png"), 24, 24, 1)

  sampleLady = love.graphics.newImage("/sprites/lvl01_bad_samplelady.png")
  toiletpaper = love.graphics.newImage("/sprites/tp_dummy72x72.png")
  playerStart = love.graphics.newImage("sprites/p1_sprite_front.png")


  currentFrame = 1
  covidFrames = {}

  table.insert(covidFrames, love.graphics.newImage("/sprites/covid1.png"))
  table.insert(covidFrames, love.graphics.newImage("/sprites/covid2.png"))
  table.insert(covidFrames, love.graphics.newImage("/sprites/covid3.png"))
  table.insert(covidFrames, love.graphics.newImage("/sprites/covid4.png"))



  sampleLadyFrames = {}

  table.insert(sampleLadyFrames, love.graphics.newImage("/sprites/bad_samplelady1.png"))
  table.insert(sampleLadyFrames, love.graphics.newImage("/sprites/bad_samplelady2.png"))
  table.insert(sampleLadyFrames, love.graphics.newImage("/sprites/bad_samplelady1.png"))
  table.insert(sampleLadyFrames, love.graphics.newImage("/sprites/bad_samplelady2.png"))


  -- Sound
  music = love.audio.newSource("/sound/foodstore_demo.mp3", "static")
  music:setLooping(true)
  music:setVolume(.05)
  music:play()



--[[
tile = {}
   for i=0,3 do -- change 3 to the number of tile images minus 1.
      tile[i] = love.graphics.newImage( "/sprites/tile"..i..".png" )
   end
--]]

  tptimerFrames = {}
  table.insert(tptimerFrames, love.graphics.newImage("/sprites/tp_timer_3.png"))
  table.insert(tptimerFrames, love.graphics.newImage("/sprites/tp_timer_2.png"))
  table.insert(tptimerFrames, love.graphics.newImage("/sprites/tp_timer_1.png"))
  table.insert(tptimerFrames, love.graphics.newImage("/sprites/tp_timer_0.png"))



  tile = {}

    tile[0] = love.graphics.newImage("/sprites/lvl01_floor_creamtile.png")
    tile[1] = love.graphics.newImage("/sprites/lvl01_shelf_empty_lr.png")
    tile[2] = love.graphics.newImage("/sprites/lvl01_shelf_half_lr.png")
    tile[3] = love.graphics.newImage("/sprites/lvl01_shelf_full_lr.png")
    tile[4] = love.graphics.newImage("/sprites/brick01_h.png")
    tile[5] = love.graphics.newImage("/sprites/brick01_v.png")



  love.graphics.setNewFont(12)

   -- map variables
   map_w = 33
   map_h = 25
   map_x = 0
   map_y = 0
   map_offset_x = -24
   map_offset_y = -24
   map_display_w = 33
   map_display_h = 25
   tile_w = 24
   tile_h = 24

map = {
{4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},
{5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,2,3,5},
{5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,2,5},
{5,0,0,0,0,3,3,1,2,2,3,0,0,0,1,2,2,1,3,2,0,0,0,1,0,0,0,0,0,0,0,1,5},
{5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5},
{5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5},
{5,0,0,0,1,0,0,0,2,0,0,0,1,0,0,0,3,0,0,0,1,0,0,0,0,0,0,1,1,3,0,0,5},
{5,0,0,0,1,0,0,0,2,0,0,0,2,0,0,0,3,0,0,0,2,0,0,0,0,0,0,1,1,3,0,0,5},
{5,0,0,0,1,0,0,0,1,0,0,0,3,0,0,0,2,0,0,0,1,0,0,0,0,2,2,1,0,0,0,0,5},
{5,0,0,0,1,0,0,0,1,0,0,0,3,0,0,0,2,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,5},
{5,0,0,0,2,0,0,0,3,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,1,0,0,0,2,5},
{5,0,0,0,3,0,0,0,1,0,0,0,2,0,0,0,2,0,0,0,2,0,0,0,0,0,0,3,0,0,0,0,5},
{5,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,1,1,0,0,0,0,5},
{5,0,0,0,2,0,0,0,1,0,0,0,2,0,0,0,2,0,0,0,3,0,0,0,0,0,1,1,2,0,0,0,5},
{5,0,0,0,1,0,0,0,3,0,0,0,2,0,0,0,2,0,0,0,3,0,0,0,0,0,1,1,0,0,0,0,5},
{5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,5},
{5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,5},
{5,0,0,0,0,0,0,3,1,0,0,1,2,0,0,1,1,0,0,1,1,0,1,1,1,1,0,0,0,1,0,0,5},
{5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,0,5},
{5,0,0,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,0,1,1,0,0,0,0,0,0,0,0,5},
{5,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,0,1,1,0,0,0,0,0,0,0,0,5},
{5,1,1,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,1,1,0,0,0,0,1,1,1,1,5},
{5,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5},
{5,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5},
{4,4,4,0,0,4,4,4,4,4,4,4,4,4,4,0,0,4,0,0,4,4,4,0,0,4,0,0,4,4,4,4,4}

}

function reset()
   spriteX = spriteStartX
   spriteY = spriteStartY
   wallCollision = 0
  -- music:play()
end


end


function draw_map()
   for y = 1, map_display_h do
      for x = 1, map_display_w do
         love.graphics.draw(
            tile[map[y+map_y][x+map_x]],
            (x*tile_w)+map_offset_x,
            (y*tile_h)+map_offset_y )
      end
   end
end



--[[ This is the actual function to detect collision between two objects. ]]

-- Collision detection function;
-- Returns true if two boxes overlap, false if they don't;
-- x1,y1 are the top-left coords of the first box, while w1,h1 are its width and height;
-- x2,y2,w2 & h2 are the same, but for the second box.


function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
end

--[[
function rightCheck(x1,y1,w1,h1, x2,y2,w2,h2)
  if x1 < x2+w2 then
    return 0
  end
end
--]]

-- LOVE.UPDATE
function love.update(dt)

  currentFrame = currentFrame + dt

  if currentFrame >= 5 then
    currentFrame = 1
  end

-- Covid Spore Control

  if covidX > 0 and covidX <= playAreaWidth then
      covidX = covidX + math.random(-1, 1)*math.random(1,3)
  else
      covidX = covidStartX
  end

  if covidY > 0 and covidY <= playAreaWidth then
    covidY = covidStartY
  else
    covidY = covidY + math.random(-1, 5)
  end

-- Sprite

--This one works but slows down the system


if wallCollision == 0 then
  if love.keyboard.isDown("w") and upCollision == 0 then
    selectSprite = 1
    animationUp.currentTime = animationUp.currentTime + dt
      if animationUp.currentTime >= animationUp.duration then
        animationUp.currentTime = animationUp.currentTime - animationUp.duration
        end
      spriteY = spriteY - 5
  elseif love.keyboard.isDown("s") and downCollision == 0 then
    selectSprite = 2
    animationDown.currentTime = animationDown.currentTime + dt
      if animationDown.currentTime >= animationDown.duration then
       animationDown.currentTime = animationDown.currentTime - animationDown.duration
     end
     spriteY = spriteY + 5
  elseif love.keyboard.isDown("d") and rightCollision == 0 then
    selectSprite = 4
    animationRight.currentTime = animationRight.currentTime + dt
      if animationRight.currentTime >= animationRight.duration then
          animationRight.currentTime = animationRight.currentTime - animationRight.duration
      end
      spriteX = spriteX + 6
  elseif love.keyboard.isDown("a") and leftCollision == 0 then
    selectSprite = 3
    animationLeft.currentTime = animationLeft.currentTime + dt
      if animationLeft.currentTime >= animationLeft.duration then
          animationLeft.currentTime = animationLeft.currentTime - animationLeft.duration
      end
      spriteX = spriteX - 6
  end
end

if wallCollision == 1 then
    if love.keyboard.isDown("w") then
      upCollision = 1
      downCollision = 0
      spriteY = spriteY + 8
      wallCollision = 0
    elseif love.keyboard.isDown("s") then
      upCollision = 0
      downCollision = 1
      spriteY = spriteY - 8
      wallCollision = 0
    elseif love.keyboard.isDown("d") then
      rightCollision = 1
      leftCollision = 0
      spriteX = spriteX - 8
      wallCollision = 0
    elseif love.keyboard.isDown("a") then
      leftCollision = 1
      rightCollision = 0
      spriteX = spriteX + 8
      wallCollision = 0
    end
  end


--[[ This one works but slows down the system
  if (love.keyboard.isDown('d') or love.keyboard.isDown("right")) and (spriteX + 48) < (playAreaWidth) then
      if leftCollision == 1 then
        spriteX = spriteX + 6
        leftCollision = 0
        wallCollision = 0
      elseif wallCollision == 1 then
        wallCollision = 0
        rightCollision = 1
        leftCollision = 0
        upCollision = 0
        downCollision = 0
      elseif wallCollision == 0 and rightCollision == 0 then
        selectSprite = 4
        leftCollision = 0
        animationRight.currentTime = animationRight.currentTime + dt
          if animationRight.currentTime >= animationRight.duration then
            animationRight.currentTime = animationRight.currentTime - animationRight.duration
          end
          spriteX = spriteX + 6
      end
  end

  if love.keyboard.isDown('a') or love.keyboard.isDown("left") then
      if rightCollision == 1 then
        spriteX = spriteX - 6
        rightCollision = 0
        wallCollision = 0
      elseif wallCollision == 1 then
        wallCollision = 0
        rightCollision = 0
        leftCollision = 1
        upCollision = 0
        downCollision = 0
      elseif wallCollision == 0 then
      selectSprite = 3
      spriteX = spriteX - 6
      animationLeft.currentTime = animationLeft.currentTime + dt
          if animationLeft.currentTime >= animationLeft.duration then
            animationLeft.currentTime = animationLeft.currentTime - animationLeft.duration
          end
          spriteX = spriteX - 6
        end
  end

  if love.keyboard.isDown('s') or love.keyboard.isDown("down") then
    if upCollision == 1 then
        spriteY = spriteY + 6
        upCollision = 0
        wallCollision = 0
    elseif wallCollision == 1 then
      wallCollision = 0
      rightCollision = 0
      leftCollision = 0
      upCollision = 0
      downCollision = 1
    elseif wallCollision == 0 then
      selectSprite = 2
      animationLeft.currentTime = animationLeft.currentTime + dt
          if animationLeft.currentTime >= animationLeft.duration then
            animationLeft.currentTime = animationLeft.currentTime - animationLeft.duration
          end
          spriteY = spriteY + 5
    end
  end

  if love.keyboard.isDown('w') or love.keyboard.isDown("up") then
    if downCollision == 1 then
      spriteY = spriteY - 6
      downCollision = 0
      wallCollision = 0
    elseif wallCollision == 1 then
      wallCollision = 0
      rightCollision = 0
      leftCollision = 0
      upCollision = 1
      downCollision = 0
    elseif wallCollision == 0 then
      selectSprite = 1
      animationLeft.currentTime = animationLeft.currentTime + dt
          if animationLeft.currentTime >= animationLeft.duration then
            animationLeft.currentTime = animationLeft.currentTime - animationLeft.duration
          end
          spriteY = spriteY - 5
    end
  end
--]]

--[[ Another attempt. Does not work
    if spriteX + 48 < playAreaWidth and love.keyboard.isDown('d') and wallCollision == 0 then
          selectSprite = 4
          animationRight.currentTime = animationRight.currentTime + dt
              if animationRight.currentTime >= animationRight.duration then
                animationRight.currentTime = animationRight.currentTime - animationRight.duration
              end
              spriteX = spriteX + 6
    end

  if spriteX > 0 and love.keyboard.isDown('a') and wallCollision == 0 then
        selectSprite = 3
        animationLeft.currentTime = animationLeft.currentTime + dt
            if animationLeft.currentTime >= animationLeft.duration then
              animationLeft.currentTime = animationLeft.currentTime - animationLeft.duration
            end
            spriteX = spriteX - 6
  end

  if spriteY > 0 and love.keyboard.isDown('w') and wallCollision == 0 then
        selectSprite = 1
        animationUp.currentTime = animationUp.currentTime + dt
          if animationUp.currentTime >= animationUp.duration then
            animationUp.currentTime = animationUp.currentTime - animationUp.duration
          end
          spriteY = spriteY - 5
  end

  if (spriteY+ 48) < playAreaHeight and love.keyboard.isDown('s') and wallCollision == 0 then
        selectSprite = 2
        animationDown.currentTime = animationDown.currentTime + dt
          if animationDown.currentTime >= animationDown.duration then
           animationDown.currentTime = animationDown.currentTime - animationDown.duration
       end
       spriteY = spriteY + 5
  end

  if wallCollision == 1 then
    if love.keyboard.isDown("w") then
      upCollision = 1
    elseif love.keyboard.isDown("s") then
      downCollision = 1
    elseif love.keyboard.isDown("d") then
      rightCollision = 1
    elseif love.keyboard.isDown("a") then
      leftCollision = 1
    end
  end

--]]
  -- Sprint collision
--  if spriteX = sampleLadyX and spriteY = sampleLady then



-- end program
    if love.keyboard.isDown('escape') then
         love.event.quit()
    end

-- reset program
        if love.keyboard.isDown('r') then
            music:stop()
            love.load()
        end

-- stop music
      if love.keyboard.isDown('space') then
            music:stop()
      end

-- Wall collision check
    for y = -1, 1 do
      for x = -1, 1 do
        for wallsIndex, walls in ipairs(walls) do
            if CheckCollision(spriteX,spriteY,spriteWidth,spriteHeight, walls.x,walls.y,walls.width,walls.height) then
              wallCollision = 1
            end
        end
      end
    end


end





-- LOVE.DRAW

function love.draw()
  love.graphics.rectangle('fill', 0, 0, playAreaWidth, playAreaHeight)

--  love.graphics.draw(playerStart, spriteX, spriteY, 0, characterScale)


  -- Draw walls
    for y = -1, 1 do
      for x = -1, 1 do
        for wallsIndex, walls in ipairs(walls) do
          --love.graphics.setColor(walls.red, walls.green, walls.blue)
          love.graphics.setColor(0,0,0)
          love.graphics.rectangle("line", walls.x, walls.y, walls.width, walls.height)
        end
      end
    end

  love.graphics.setColor(1, 1, 1)

  draw_map()


    -- Animation
  if selectSprite == 1 then
        local spriteNum = math.floor(animationUp.currentTime / animationUp.duration * #animationUp.quads) + 1
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(animationUp.spriteSheet, animationUp.quads[spriteNum], spriteX, spriteY, 0, characterScale)
    elseif selectSprite == 2 then
        local spriteNum = math.floor(animationDown.currentTime / animationDown.duration * #animationDown.quads) + 1
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(animationDown.spriteSheet, animationDown.quads[spriteNum], spriteX, spriteY, 0, characterScale)
    elseif selectSprite == 3 then
        local spriteNum = math.floor(animationLeft.currentTime / animationLeft.duration * #animationLeft.quads) + 1
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(animationLeft.spriteSheet, animationLeft.quads[spriteNum], spriteX, spriteY, 0, characterScale)
     elseif selectSprite == 4 then
        local spriteNum = math.floor(animationRight.currentTime / animationRight.duration * #animationRight.quads) + 1
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(animationRight.spriteSheet, animationRight.quads[spriteNum], spriteX, spriteY, 0, characterScale)
    end


  -- Item
    --love.graphics.setColor(1, 1, 1)
    --love.graphics.draw(sampleLady,sampleLadyX, sampleLadyY,0)
    --love.graphics.rectangle('fill',itemX,itemY,24,24)

    love.graphics.setColor(1, 1, 1)

-- Item
    love.graphics.setColor(1, 0, 1)
  --  love.graphics.draw(toiletpaper, 24, 24, 0)

    love.graphics.setColor(1, 1, 1)


-- Disable for testing
    love.graphics.draw(covidFrames[math.floor(currentFrame)],covidX, covidY,0,characterScale,characterScale)

    love.graphics.draw(covidFrames[math.floor(currentFrame)],covidX+400, covidY-50,0,characterScale,characterScale)

    love.graphics.draw(covidFrames[math.floor(currentFrame)],covidX-120, covidY-80,0,characterScale,characterScale)

    love.graphics.draw(sampleLadyFrames[math.floor(currentFrame)],sampleLadyX, sampleLadyY,0,characterScale,characterScale)

    love.graphics.draw(tptimerFrames[math.floor(currentFrame)],tptimerX, tptimerY,0)

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
