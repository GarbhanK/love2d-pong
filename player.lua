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

P2 = {}
P2.x = love.graphics.getWidth() - 20
P2.y = love.graphics.getHeight() / 2
P2.w = 20
P2.h = 110
P2.score = 0

function P2:draw()
    love.graphics.setColor(love.math.colorFromBytes(69, 133, 136))
    love.graphics.rectangle("fill", P2.x, P2.y, P2.w, P2.h)
end
