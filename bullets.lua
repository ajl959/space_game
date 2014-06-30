
bullets = {}

bulletVel = 500

bulletSound = love.audio.newSource("fire.ogg", "static")

function bullets.addBullet(xPos, yPos)

	table.insert(bullets, {
		x = xPos,
		y = yPos,
		xvel = bulletVel
	})

	bulletSound:play()

end

function bullets.updatePosition(dt)
	local i, o
	for i, o in ipairs(bullets) do
		o.x = o.x + o.xvel * dt
		if (o.x < -10) or (o.x > love.graphics.getWidth() + 10) then
			table.remove(bullets, i)
		end
	end
end

function bullets.drawBullets()
	love.graphics.setLineWidth(5)
	local i, o
	for i, o in ipairs(bullets) do
		love.graphics.line(o.x, o.y, o.x+4, o.y)
	end
end	

function UPDATE_BULLETS(dt)
	bullets.updatePosition(dt)
end

function DRAW_BULLETS()
	bullets.drawBullets()
end