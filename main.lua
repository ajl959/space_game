require "src.ship"
require "src.bullets"
require "src.enemies"


score = 0

function love.load()

	ship.load()

	background = love.graphics.newImage("images/background.jpg")

end
function love.update(dt)

	UPDATE_SHIP(dt)
	UPDATE_BULLETS(dt)
	UPDATE_ENEMIES(dt)

end
function love.draw()

	love.graphics.draw(background, 0, 0)
	love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), 10, 10)
	love.graphics.print("Score: "..tostring(score), 10, 30)
	
	DRAW_SHIP()
	DRAW_BULLETS()
	DRAW_ENEMIES()

end