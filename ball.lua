local love = require('love')


BOUNCE_SFX = love.audio.newSource("audio/SOPHIE_snare_15.wav", "static")

Ball = {}
Ball.x = love.graphics.getWidth() / 2
Ball.y = love.graphics.getHeight() / 2
Ball.radius = 10
Ball.dx = math.random(2) == 1 and 100 or -100
Ball.dy = math.random(-50, 50)
Ball.speed = 2.0

function Ball:reset()
    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() / 2
    self.radius = 10
    self.dx = math.random(2) == 1 and 100 or -100
    self.dy = math.random(-50, 50)
end

function Ball:bounce(x, y)
    self.dx = x * self.dx
    self.dy = y * self.dy
    love.audio.play(BOUNCE_SFX)

    if self.speed <= MAX_BALL_SPEED then
        self.speed = self.speed + 0.2
    end
end

function Ball:draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.circle("fill", self.x, self.y, self.radius)
end
