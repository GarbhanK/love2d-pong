require 'ball'
require 'player'

local love = require('love')
WIDTH, HEIGHT = love.graphics.getDimensions()

function love.load()
    math.randomseed(os.time())

    -- local r, g, b = love.math.colorFromBytes(132, 193, 238)
    local r, g, b = love.math.colorFromBytes(33, 33, 33)
    love.graphics.setBackgroundColor(r, g, b)

    PADDLE_SPEED = 250
    MAX_BALL_SPEED = 5.0
    GAMESTATE = 'start'
    DEBUG = false

    -- load audio
    love.audio.setVolume(0.5)
    local bg_music = love.audio.newSource("audio/Limp_Pumpo_ LIMP_PUMPO_INTRODUCTION.mp3", "static")
    love.audio.play(bg_music)
end

function love.update(dt)
    if love.keyboard.isDown("w") then
        P1.y = math.max(0, P1.y + (-PADDLE_SPEED * dt))
    elseif love.keyboard.isDown("s") then
        P1.y = math.min(HEIGHT - P1.h, P1.y + (PADDLE_SPEED * dt))
    end

    -- player 2 controls
    if love.keyboard.isDown("i") then
        P2.y = math.max(0, P2.y + -PADDLE_SPEED * dt)
    elseif love.keyboard.isDown("k") then
        P2.y = math.min(HEIGHT - P1.h, P2.y + PADDLE_SPEED * dt)
    end

    if GAMESTATE == 'play' then
        Ball.x = Ball.x + Ball.dx * (dt * Ball.speed)
        Ball.y = Ball.y + Ball.dy * (dt * Ball.speed)
    end

    -- backwall bounces (scores)
    if Ball.x <= 0 then
        Ball:reset()
        P2.score = P2.score + 1
    elseif Ball.x >= WIDTH then
        Ball:reset()
        P1.score = P1.score + 1
    end

    -- edge of play bounce
    if Ball.y <= 0 + Ball.radius then
        Ball:bounce(1, -1)
    elseif Ball.y >= HEIGHT - Ball.radius then
        Ball:bounce(1, -1)
    end

    -- paddle bounces
    if Ball.x <= P1.w + Ball.radius and Ball.y > P1.y and Ball.y <= P1.y + P1.h then
        Ball:bounce(-1, 1)
        Ball.x = Ball.x + 5
    end

    if Ball.x >= (WIDTH - P2.w - Ball.radius) and Ball.y > P2.y and Ball.y <= P2.y + P2.h then
        Ball:bounce(-1, 1)
        Ball.x = Ball.x - 5
    end
end

function love.draw()
    if GAMESTATE == 'start' then
        love.graphics.printf("Start State", 0, 20, WIDTH, 'center')
        love.graphics.printf("Press 'Enter' to start!", 0, 40, WIDTH, "center")
        love.graphics.printf("Paddle 1 (left) uses 'w' and 's'", 0, 60, WIDTH, "center")
        love.graphics.printf("Paddle 2 (right) uses 'i' and 'k'", 0, 80, WIDTH, "center")
    else
        love.graphics.printf("Play State", 0, 20, WIDTH, 'center')

        -- print scores
        love.graphics.printf(
            string.format("P1 score: %s", P1.score), 0, 20, WIDTH - 300, 'center')
        love.graphics.printf(
            string.format("P2 score: %s", P2.score), 0, 20, WIDTH + 300, 'center')
    end

    -- draw two player paddles and the Ball
    P1:draw()
    P2:draw()
    Ball:draw()

    -- debug stuff
    if DEBUG == true then
        love.graphics.print(string.format("Ball.x: %s", Ball.x), 10, 10)
        love.graphics.print(string.format("Ball.y: %s", Ball.y), 10, 20)
        love.graphics.print(string.format("Ball.dx: %s", Ball.dx), 10, 30)
        love.graphics.print(string.format("Ball.dy: %s", Ball.dy), 10, 40)
        love.graphics.print(string.format("Ball.speed: %s", Ball.speed), 10, 50)
    end
end

function love.keypressed(key)
    if key == 'escape' then  -- exit the game
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

            Ball.x = WIDTH / 2
            Ball.y = HEIGHT / 2

            -- give Ball a random starting value
            Ball.dx = math.random(2) == 1 and 100 or -100
            Ball.dy = math.random(-50, 50) * 1.5
        end
    end
end
