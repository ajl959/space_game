require "ship"
require "bullets"
require "enemies"

function love.load()

	ship.load()

	background = love.graphics.newImage("background.jpg")

end
function love.update(dt)

	UPDATE_SHIP(dt)
	UPDATE_BULLETS(dt)
	UPDATE_ENEMIES(dt)

end
function love.draw()

	love.graphics.draw(background, 0, 0)
	
	DRAW_SHIP()
	DRAW_BULLETS()
	DRAW_ENEMIES()

end