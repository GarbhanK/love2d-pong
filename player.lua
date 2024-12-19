
p1 = {}
p1.x = 0
p1.y = love.graphics.getHeight()/2
p1.w = 20
p1.h = 110
p1.score = 0

function p1:draw()
    love.graphics.setColor(love.math.colorFromBytes(204, 36, 29))
    love.graphics.rectangle("fill", p1.x, p1.y, p1.w, p1.h)
end

p2 = {}
p2.x = love.graphics.getWidth() - 20
p2.y = love.graphics.getHeight()/2
p2.w = 20
p2.h = 110
p2.score = 0

function p2:draw()
    love.graphics.setColor(love.math.colorFromBytes(69, 133, 136))
    love.graphics.rectangle("fill", p2.x, p2.y, p2.w, p2.h)
end
