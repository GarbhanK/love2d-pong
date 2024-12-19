

bounce_sfx = love.audio.newSource("audio/SOPHIE_snare_15.wav", "static")

ball = {}
ball.x = love.graphics.getWidth()/2
ball.y = love.graphics.getHeight()/2
ball.radius = 10
ball.dx = math.random(2) == 1 and 100 or -100
ball.dy = math.random(-50, 50)
ball.speed = 2.0

function ball:reset()
    self.x = love.graphics.getWidth()/2
    self.y = love.graphics.getHeight()/2
    self.radius = 10
    self.dx = math.random(2) == 1 and 100 or -100
    self.dy = math.random(-50, 50)
end

function ball:bounce(x, y)
    self.dx = x * self.dx
    self.dy = y * self.dy
    love.audio.play(bounce_sfx)

    if self.speed <= MAX_BALL_SPEED then
        self.speed = self.speed + 0.2
    end
end

function ball:draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.circle("fill", self.x, self.y, self.radius)
end

