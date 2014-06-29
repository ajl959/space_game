
ship = {}

bullets = {}

fireWait = 5
fireTime = 0

function ship.load()
	ship.image = love.graphics.newImage("ship.png")
	ship.x = 50
	ship.y = 200
	ship.yvel = 0
	ship.friction = 7
	ship.speed = 2250
end

function ship.move(dt)
	if love.keyboard.isDown('up') and
	ship.yvel > -ship.speed then
		ship.yvel = ship.yvel - ship.speed * dt
	end
	if love.keyboard.isDown('down') and
	ship.yvel < ship.speed then
		ship.yvel = ship.yvel + ship.speed * dt
	end
end

function ship.fire()
	if love.keyboard.isDown('w') then

		if fireTime > fireWait then
			table.insert(bullets, {
				x = ship.x + ship.image:getWidth(),
				y = ship.y + ship.image:getHeight() / 2,
				xvel = 500
			})
			fireTime = 0
		else
			fireTime = fireTime + 1
		end

	end
end

function ship.bulletUpdate(dt)
	local i, o
	for i, o in ipairs(bullets) do
		o.x = o.x + o.xvel * dt
		if (o.x < -10) or (o.x > love.graphics.getWidth() + 10) then
			table.remove(bullets, i)
		end
	end
end

function ship.bulletDraw()
	love.graphics.setLineWidth(3)
	local i, o
	for i, o in ipairs(bullets) do
		--love.graphics.circle( "fill", o.x, o.y, 2, 6)
		love.graphics.line(o.x, o.y, o.x+2, o.y)
	end
end	

function ship.bounds()
	if ship.y < 0 then
		ship.y = 0
		ship.yvel = 0
	end
	if ship.y > 600 - ship.image:getHeight() then
		ship.y = 600 - ship.image:getHeight()
		ship.yvel = 0
	end
end

function ship.physics(dt)
	ship.y = ship.y + ship.yvel * dt
	ship.yvel = ship.yvel * (1 - math.min(dt*ship.friction, 1))
end

function UPDATE_SHIP(dt)
	ship.physics(dt)
	ship.move(dt)
	ship.bounds()
	ship.fire()
	ship.bulletUpdate(dt)
end

function DRAW_SHIP()
	love.graphics.draw(ship.image, ship.x, ship.y)
	ship.bulletDraw()
end