require "map test/level1"
--require "tile-test/map"

function love.load()

  love.window.setTitle("UHACC - Lundum Dare 46")

  -- Play Field
    playAreaWidth = 800
    playAreaHeight = 600

-- Score Variable
deathCount = 0
captureCount = 0

-- Loading Classes
  characterScale = 1.5

  --  sprite.load()
  collisionOffset = 12

  spriteX = 700
  spriteY = 540
  spriteStartX = 700
  spriteStartY = 540
  spriteWidth = 24*characterScale
  spriteHeight = 24*characterScale


  covidWidth = 24*characterScale
  covidHeight = 24*characterScale

  covidX1 = 700
  covidY1 = 100
  covidStartX1 = 700
  covidStartY1 = 100
  covid1xdirection = 1

  covidX2 = 130
  covidY2 = 100
  covidStartX2 = 100
  covidStartY2 = 200

  covidX3 = 100
  covidY3 = 400
  covidStartX3 = 100
  covidStartY3 = 400

  covidX4 = 430
  covidY4 = 100
  covidStartX4 = 430
  covidStartY4 = 100

  covidX5 = 600
  covidY5 = 500
  covidStartX5 = 600
  covidStartY5 = 500


  itemX = 500
  itemY = 500
  itemWidth = 24*characterScale
  itemHeight = 24*characterScale


  sampleLady1Width = 48*characterScale
  sampleLady1Height = 24*characterScale

  sampleLady1X = 580
  sampleLady1Y = 80

  sampleLady2X = 510
  sampleLady2Y = 370

  sampleLady3X = 312
  sampleLady3Y = 110

  sampleLady3X = 510
  sampleLady3Y = 540

  sampleLady4X = 310
  sampleLady4Y = 30



  tptimerX = 24
  tptimerY = 24
  tptimerWidth = 72
  tptimerHeight = 72
  tpTimer = 4

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

  sampleLady1 = love.graphics.newImage("/sprites/lvl01_bad_samplelady.png")
  sampleLady2 = love.graphics.newImage("/sprites/lvl01_bad_samplelady.png")
  toiletpaper = love.graphics.newImage("/sprites/tp_dummy72x72.png")
  playerStart = love.graphics.newImage("sprites/p1_sprite_front.png")
  checkout = love.graphics.newImage("sprites/lvl01_checkout.png")

  currentFrame = 1
  covidFrames = {}

  table.insert(covidFrames, love.graphics.newImage("/sprites/covid1.png"))
  table.insert(covidFrames, love.graphics.newImage("/sprites/covid2.png"))
  table.insert(covidFrames, love.graphics.newImage("/sprites/covid3.png"))
  table.insert(covidFrames, love.graphics.newImage("/sprites/covid4.png"))



  sampleLady1Frames = {}

  table.insert(sampleLady1Frames, love.graphics.newImage("/sprites/bad_samplelady1.png"))
  table.insert(sampleLady1Frames, love.graphics.newImage("/sprites/bad_samplelady2.png"))
  table.insert(sampleLady1Frames, love.graphics.newImage("/sprites/bad_samplelady1.png"))
  table.insert(sampleLady1Frames, love.graphics.newImage("/sprites/bad_samplelady2.png"))


  sampleLady2Frames = {}

  table.insert(sampleLady2Frames, love.graphics.newImage("/sprites/bad_samplelady1.png"))
  table.insert(sampleLady2Frames, love.graphics.newImage("/sprites/bad_samplelady2.png"))
  table.insert(sampleLady2Frames, love.graphics.newImage("/sprites/bad_samplelady1.png"))
  table.insert(sampleLady2Frames, love.graphics.newImage("/sprites/bad_samplelady2.png"))


  -- Sound
  music = love.audio.newSource("/sound/foodstore_music.wav", "static")
  music:setLooping(true)
  music:setVolume(.05)
  music:play()

  wasted = love.audio.newSource("/sound/Wasted.wav", "static")
  wasted:setVolume(.5)

  tp_capture = love.audio.newSource("/sound/TP_capture.wav", "static")
  tp_capture:setVolume(.5)

  win = love.audio.newSource("/sound/Win.wav", "static")
  win:setVolume(.5)

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

  if covidX1 < 0 or covidX1 > playAreaWidth - 24 or covidY1 < 0 or covidY1 > playAreaHeight - 24 then
      covidX1 = covidStartX1
      covidY1 = covidStartY1
  else
      covidX1 = covidX1 - math.random(1, 2)
      covidY1 = covidY1 +math.random(-2, 2)
  end


  if covidX2 < 0 or covidX2 > playAreaWidth - 24 or covidY2 < 0 or covidY2 > playAreaHeight - 24 then
      covidX2 = covidStartX2
      covidY2 = covidStartY2
    else
      covidX2 = covidX2 +math.random(-1, 1)
      covidY2 = covidY2 +math.random(0, 1.5)
  end

  if covidX3 < 0 or covidX3 > playAreaWidth - 24 or covidY3 < 0 or covidY3 > playAreaHeight - 24 then
      covidX3 = covidStartX3
      covidY3 = covidStartY3
    else
      covidX3 = covidX3 +math.random(2, 2)
      covidY3 = covidY3 +math.random(-2, 1)
  end

  if covidX4 < 0 or covidX4 > playAreaWidth - 24 or covidY4 < 0 or covidY4 > playAreaHeight - 24 then
      covidX4 = covidStartX4
      covidY4 = covidStartY4
    else
      covidX4 = covidX4 +math.random(-1,1)
      covidY4 = covidY4 +math.random(0, 2)
  end

  if covidX5 < 0 or covidX5 > playAreaWidth - 24 or covidY5 < 0 or covidY5 > playAreaHeight - 24 then
      covidX5 = covidStartX5
      covidY5 = covidStartY5
    else
      covidX5 = covidX5 +math.random(-1,1)
      covidY5 = covidY5 +math.random(-1, 1)
  end

-- Sprite

--This one works but slows down the system


--if wallCollision == 0 then
  if love.keyboard.isDown("w") or  love.keyboard.isDown("up") and upCollision == 0 and spriteY > 24 then
    selectSprite = 1
    animationUp.currentTime = animationUp.currentTime + dt
      if animationUp.currentTime >= animationUp.duration then
        animationUp.currentTime = animationUp.currentTime - animationUp.duration
        end
      spriteY = spriteY - 5
  end

  if love.keyboard.isDown("s") or  love.keyboard.isDown("down") and downCollision == 0 and spriteY < playAreaHeight - spriteHeight - 24 then
    selectSprite = 2
    animationDown.currentTime = animationDown.currentTime + dt
      if animationDown.currentTime >= animationDown.duration then
       animationDown.currentTime = animationDown.currentTime - animationDown.duration
     end
     spriteY = spriteY + 5
  end

if love.keyboard.isDown("d") or  love.keyboard.isDown("right") and rightCollision == 0 and spriteX < playAreaWidth - spriteWidth - 24 then
    selectSprite = 4
    animationRight.currentTime = animationRight.currentTime + dt
      if animationRight.currentTime >= animationRight.duration then
          animationRight.currentTime = animationRight.currentTime - animationRight.duration
      end
      spriteX = spriteX + 6
end

if love.keyboard.isDown("a") or  love.keyboard.isDown("left") and leftCollision == 0 and spriteX > 24 then
    selectSprite = 3
    animationLeft.currentTime = animationLeft.currentTime + dt
      if animationLeft.currentTime >= animationLeft.duration then
          animationLeft.currentTime = animationLeft.currentTime - animationLeft.duration
      end
      spriteX = spriteX - 6
  end

--[[
  if wallCollision == 1 and love.keyboard.isDown("w") then
        upCollision = 1
        downCollision = 0
        spriteY = spriteY + 8
        wallCollision = 0
  end

  if wallCollision == 1 and love.keyboard.isDown("s") then
        upCollision = 0
        downCollision = 1
        spriteY = spriteY - 8
        wallCollision = 0
  end

  if wallCollision == 1 and love.keyboard.isDown("d") then
        rightCollision = 1
        leftCollision = 0
        spriteX = spriteX - 8
        wallCollision = 0
  end

  if wallCollision == 1 and love.keyboard.isDown("a") then
        leftCollision = 1
        rightCollision = 0
        spriteX = spriteX + 8
        wallCollision = 0
  end
--]]
--end
--[[
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
--]]

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

if (math.abs(spriteX - sampleLady1X) < 24 and math.abs(spriteY - sampleLady1Y) < 24)
  or (math.abs(spriteX - sampleLady2X) < 24 and math.abs(spriteY - sampleLady2Y) < 24)
  or (math.abs(spriteX - sampleLady3X) < 24 and math.abs(spriteY - sampleLady3Y) < 24)
  or (math.abs(spriteX - sampleLady4X) < 24 and math.abs(spriteY - sampleLady4Y) < 24)
  then
  wasted:play()
  spriteX= spriteStartX
  spriteY=spriteStartY
  deathCount = deathCount + 1
  tpTimer = tpTimer - 1
end


if (math.abs(spriteX - covidX1) < 24 and math.abs(spriteY - covidY1) < 24)
  or (math.abs(spriteX - covidX2) < 24 and math.abs(spriteY - covidY2) < 24)
  or (math.abs(spriteX - covidX3) < 24 and math.abs(spriteY - covidY3) < 24)
  or (math.abs(spriteX - covidX4) < 24 and math.abs(spriteY - covidY4) < 24)
  or (math.abs(spriteX - covidX5) < 24 and math.abs(spriteY - covidY5) < 24)
  then
  wasted:play()
  spriteX= spriteStartX
  spriteY=spriteStartY
  deathCount = deathCount + 1
  tpTimer = tpTimer - 1
end


if (math.abs(spriteX - tptimerX) < 48 and math.abs(spriteY - tptimerY) < 48)
  then
  win:play()
  spriteX= spriteStartX
  spriteY=spriteStartY
  captureCount = captureCount + 1
  tpTimer = 4
end



if deathCount >= 4 then
    wasted:play()
    music:stop()
    love.load()
end

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

    -- Checkouts

        love.graphics.draw(checkout,120,456,0)
        love.graphics.draw(checkout,216,456,0)
        love.graphics.draw(checkout,312,456,0)
        love.graphics.draw(checkout,408,456,0)

-- Sample Ladies
    love.graphics.draw(sampleLady1Frames[math.floor(currentFrame)],sampleLady1X, sampleLady1Y,0,characterScale,characterScale)
    love.graphics.draw(sampleLady1Frames[math.floor(currentFrame)],sampleLady2X, sampleLady2Y,0,characterScale,characterScale)
    love.graphics.draw(sampleLady1Frames[math.floor(currentFrame)],sampleLady3X, sampleLady3Y,0,characterScale,characterScale)
    love.graphics.draw(sampleLady1Frames[math.floor(currentFrame)],sampleLady4X, sampleLady4Y,0,characterScale,characterScale)
    --love.graphics.draw(sampleLady2Frames[math.floor(currentFrame)],sampleLady2X, sampleLady2Y,0,characterScale,characterScale)


    if spriteX == spriteStartX and spriteY == spriteStartY then
      love.graphics.draw(playerStart,spriteStartX,spriteStartY,0,characterScale)
    end


    if tpTimer == 4 then
      love.graphics.draw(tptimerFrames[1],tptimerX,tptimerY,0)
    end
    if tpTimer == 3 then
      love.graphics.draw(tptimerFrames[2],tptimerX,tptimerY,0)
    end
    if tpTimer == 2 then
      love.graphics.draw(tptimerFrames[3],tptimerX,tptimerY,0)
    end
    if tpTimer == 1 then
      love.graphics.draw(tptimerFrames[4],tptimerX,tptimerY,0)
    end


    -- Covid Spores
        love.graphics.draw(covidFrames[math.floor(currentFrame)],covidX1, covidY1,0,characterScale,characterScale)
        love.graphics.draw(covidFrames[math.floor(currentFrame)],covidX2, covidY2,0,characterScale,characterScale)
        love.graphics.draw(covidFrames[math.floor(currentFrame)],covidX3, covidY3,0,characterScale,characterScale)
        love.graphics.draw(covidFrames[math.floor(currentFrame)],covidX4, covidY4,0,characterScale,characterScale)
        love.graphics.draw(covidFrames[math.floor(currentFrame)],covidX5, covidY5,0,characterScale,characterScale)



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
