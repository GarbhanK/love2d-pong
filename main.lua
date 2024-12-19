require 'ball'
require 'player'

width, height = love.graphics.getDimensions()

function love.load()
    math.randomseed(os.time())

    local r, g, b = love.math.colorFromBytes(132, 193, 238)
    local r, g, b = love.math.colorFromBytes(33, 33, 33)
    love.graphics.setBackgroundColor(r, g, b)

    PADDLE_SPEED = 250
    MAX_BALL_SPEED = 5.0
    GAMESTATE = 'start'
    DEBUG = false

    -- load audio
    love.audio.setVolume(0.5)
    bg_music = love.audio.newSource("audio/Limp_Pumpo_ LIMP_PUMPO_INTRODUCTION.mp3", "static")
    love.audio.play(bg_music)
end

function love.update(dt)

    if love.keyboard.isDown("w") then
        p1.y = math.max(0, p1.y + (-PADDLE_SPEED * dt))
    elseif love.keyboard.isDown("s") then
        p1.y = math.min(height - p1.h, p1.y + (PADDLE_SPEED * dt))
    end

    -- player 2 controls
    if love.keyboard.isDown("i") then
        p2.y = math.max(0, p2.y + -PADDLE_SPEED * dt)
    elseif love.keyboard.isDown("k") then
        p2.y = math.min(height - p1.h, p2.y + PADDLE_SPEED * dt)
    end

    if GAMESTATE == 'play' then
        ball.x = ball.x + ball.dx * (dt * ball.speed)
        ball.y = ball.y + ball.dy * (dt * ball.speed)
    end

    -- backwall bounces (scores)
    if ball.x <= 0 then
        ball:reset()
        p2.score = p2.score + 1
    elseif ball.x >= width then
        ball:reset()
        p1.score = p1.score + 1
    end

    -- edge of play bounce
    if ball.y <= 0 + ball.radius then
        ball:bounce(1, -1)
    elseif ball.y >= height - ball.radius then
        ball:bounce(1, -1)
    end

    -- paddle bounces
    if ball.x <= p1.w + ball.radius and ball.y > p1.y and ball.y <= p1.y + p1.h then
        ball:bounce(-1, 1)
        ball.x = ball.x + 5
    end

    if ball.x >= (width - p2.w - ball.radius) and ball.y > p2.y and ball.y <= p2.y + p2.h then
        ball:bounce(-1, 1)
        ball.x = ball.x - 5
    end
end

function love.draw()

    if GAMESTATE == 'start' then
        love.graphics.printf("Start State", 0, 20, width, 'center')
        love.graphics.printf("Press 'Enter' to start!", 0, 40, width, "center")
        love.graphics.printf("Paddle 1 (left) uses 'w' and 's'", 0, 60, width, "center")
        love.graphics.printf("Paddle 2 (right) uses 'i' and 'k'", 0, 80, width, "center")
    else
        love.graphics.printf("Play State", 0, 20, width, 'center')

        -- print scores
        love.graphics.printf(
            string.format("P1 score: %s", p1.score), 0, 20, width - 300, 'center')
        love.graphics.printf(
            string.format("P2 score: %s", p2.score), 0, 20, width + 300, 'center')
    end
    
    -- draw two player paddles and the ball
    p1:draw()
    p2:draw()
    ball:draw()

    -- debug stuff
    if DEBUG == true then
        love.graphics.print(string.format("ball.x: %s", ball.x), 10, 10)
        love.graphics.print(string.format("ball.y: %s", ball.y), 10, 20)
        love.graphics.print(string.format("ball.dx: %s", ball.dx), 10, 30)
        love.graphics.print(string.format("ball.dy: %s", ball.dy), 10, 40)
        love.graphics.print(string.format("ball.speed: %s", ball.speed), 10, 50)
    end
end

function love.keypressed(key)
    if key == 'escape' then -- exit the game
        love.event.quit()
    elseif key == 'tab' then -- toggle debug info
        if DEBUG == false then
            DEBUG = true
        else
            DEBUG = false
        end
    elseif key == 'enter' or key == 'return' then -- reset the game
        if GAMESTATE == 'start' then
            GAMESTATE = 'play'
        else
            GAMESTATE = 'start'

            ball.x = width/2
            ball.y = height/2

            -- give ball a random starting value
            ball.dx = math.random(2) == 1 and 100 or -100
            ball.dy = math.random(-50, 50) * 1.5
        end
    end
end
