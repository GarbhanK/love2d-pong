local love = require('love')


P1 = {}
P1.x = 0
P1.y = love.graphics.getHeight() / 2
P1.w = 20
P1.h = 110
P1.score = 0

function P1:draw()
    love.graphics.setColor(love.math.colorFromBytes(204, 36, 29))
    love.graphics.rectangle("fill", P1.x, P1.y, P1.w, P1.h)
end

p2 = {}
p2.x = love.graphics.getWidth() - 20
p2.y = love.graphics.getHeight() / 2
p2.w = 20
p2.h = 110
p2.score = 0

function p2:draw()
    love.graphics.setColor(love.math.colorFromBytes(69, 133, 136))
    love.graphics.rectangle("fill", p2.x, p2.y, p2.w, p2.h)
end
