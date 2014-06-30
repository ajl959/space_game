
ship = {}

fireWait = 5
fireTime = 0

pi = love.graphics.newImage("images/thrust.png")
ps = love.graphics.newParticleSystem(pi, 2)
ps:setSpeed(1, 3)
ps:setEmissionRate(35)
ps:setSizes(1,2)
ps:setSpinVariation(.5)

function ship.load()
	ship.image = love.graphics.newImage("images/ship.png")
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
	if love.keyboard.isDown(' ') then

		if fireTime > fireWait then

			bullets.addBullet(ship.x + ship.image:getWidth(), 
				ship.y + ship.image:getHeight() / 2)

			fireTime = 0

		else
			fireTime = fireTime + 1
		end

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
	ps:update(dt)
end

function DRAW_SHIP()
	love.graphics.draw(ship.image, ship.x, ship.y)
	love.graphics.draw(ps, ship.x-15, ship.y - 3 + ship.image:getHeight()/2)
end