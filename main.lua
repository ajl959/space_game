require "ship"

function love.load()

	ship.load()

end
function love.update(dt)

	UPDATE_SHIP(dt)

end
function love.draw()
	
	DRAW_SHIP()

end