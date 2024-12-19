

bounce_sfx = love.audio.newSource("audio/SOPHIE_snare_15.wav", "static")

ball = {}
ball.x = love.graphics.getWidth()/2
ball.y = love.graphics.getHeight()/2
ball.radius = 10
ball.dx = math.random(2) == 1 and 100 or -100
ball.dy = math.random(-50, 50)
ball.speed = 2.0

function ball:reset()
    ball.x = love.graphics.getWidth()/2
    ball.y = love.graphics.getHeight()/2
    ball.radius = 10
    ball.dx = math.random(2) == 1 and 100 or -100
    ball.dy = math.random(-50, 50)
end

function ball:bounce(x, y)
    self.dx = x * self.dx
    self.dy = y * self.dy
    love.audio.play(bounce_sfx)

    if ball.speed <= MAX_BALL_SPEED then
        ball.speed = ball.speed + 0.2
    end
end

function ball:draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.circle("fill", ball.x, ball.y, ball.radius)
end
