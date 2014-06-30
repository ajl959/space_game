
enemies = {}

explosions = {}

enemyCounter = 0

enemyImage = love.graphics.newImage("images/enemy.png")
enemyExplode = love.graphics.newImage("images/explosion.png")

explodeSound = love.audio.newSource("sounds/explosion.ogg", "static")

math.randomseed(os.time())

function enemies.addNew()

	if enemyCounter > 125 then

		local r = math.random()
		local yRand = (love.graphics.getHeight() - enemyImage:getHeight()) * r

		table.insert(enemies, {
				x = love.graphics.getWidth() + 10,
				y = yRand,
				xvel = 50
			})

		enemyCounter = 0

	else
		enemyCounter = enemyCounter + 1
	end

end

function enemies.updatePosition(dt)
	local i, o
	for i, o in ipairs(enemies) do
		o.x = o.x - o.xvel * dt
		if (o.x < -10) then
			table.remove(enemies, i)
		end
	end
end

function enemies.draw()
	love.graphics.setLineWidth(12)
	local i, o
	for i, o in ipairs(enemies) do
		love.graphics.draw(enemyImage, o.x, o.y)
	end
end

function enemies.checkAlive()
	local i, e
	local j, b
	for i, e in ipairs(enemies) do
		
		for j, b in ipairs(bullets) do

			if (b.y > e.y - 5) and (b.y < e.y + 45) and (b.x > e.x) then

				table.remove(enemies, i)

				table.remove(bullets, j)

				table.insert(explosions, {
					x = e.x, 
					y = e.y, 
					c = 15
				})

				explodeSound:play()

				score = score + 1

			end

		end

	end
end

function explosions.draw()

	for i, e in ipairs(explosions) do

		if (e.c == 0) then
			table.remove(explosions, i)
		else
			love.graphics.draw(enemyExplode, e.x, e.y)
			t = e.c-1
			e.c = t
		end

	end
	
end

function UPDATE_ENEMIES(dt)
	enemies.checkAlive()
	enemies.addNew()
	enemies.updatePosition(dt)
end

function DRAW_ENEMIES()
	explosions.draw()
	enemies.draw()
end