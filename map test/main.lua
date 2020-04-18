function love.load()
	playingAreaWidth = 800
	playingAreaHeight = 600
	love.graphics.setBackgroundColor(1, 1, 1)
end

function love.draw()

	local wallWidth = 24
	love.graphics.setColor(.37, .82, .28) -- wall color
	love.graphics.rectangle(
		'fill',
		0*wallWidth, 
		0*wallWidth,
		1*wallWidth,
		25*wallWidth)
		
	love.graphics.rectangle(
		'fill',
		0*wallWidth, 
		0*wallWidth,
		33*wallWidth,
		1*wallWidth)
	
	love.graphics.rectangle(
		'fill',
		5*wallWidth, 
		3*wallWidth,
		6*wallWidth,
		1*wallWidth)
	
	love.graphics.rectangle(
		'fill',
		14*wallWidth, 
		3*wallWidth,
		6*wallWidth,
		1*wallWidth)
	
	love.graphics.rectangle(
		'fill',
		4*wallWidth, 
		6*wallWidth,
		1*wallWidth,
		10*wallWidth)
	
	love.graphics.rectangle(
		'fill',
		8*wallWidth, 
		6*wallWidth,
		1*wallWidth,
		10*wallWidth)

	love.graphics.rectangle(
		'fill',
		12*wallWidth, 
		6*wallWidth,
		1*wallWidth,
		10*wallWidth)

	love.graphics.rectangle(
		'fill',
		16*wallWidth, 
		6*wallWidth,
		1*wallWidth,
		10*wallWidth)
	
	love.graphics.rectangle(
		'fill',
		20*wallWidth, 
		6*wallWidth,
		1*wallWidth,
		10*wallWidth)
	
		love.graphics.rectangle(
		'fill',
		23*wallWidth, 
		1*wallWidth,
		1*wallWidth,
		3*wallWidth)

		love.graphics.rectangle(
		'fill',
		28*wallWidth, 
		1*wallWidth,
		4*wallWidth,
		1*wallWidth)

		love.graphics.rectangle(
		'fill',
		31*wallWidth, 
		1*wallWidth,
		1*wallWidth,
		4*wallWidth)

		love.graphics.rectangle(
		'fill',
		32*wallWidth, 
		0*wallWidth,
		1*wallWidth,
		22*wallWidth)

		love.graphics.rectangle(
		'fill',
		1*wallWidth, 
		20*wallWidth,
		1*wallWidth,
		5*wallWidth)

		love.graphics.rectangle(
		'fill',
		2*wallWidth, 
		20*wallWidth,
		1*wallWidth,
		2*wallWidth)
		
		love.graphics.rectangle(
		'fill',
		2*wallWidth, 
		24*wallWidth,
		1*wallWidth,
		1*wallWidth)

		love.graphics.rectangle(
		'fill',
		5*wallWidth, 
		24*wallWidth,
		10*wallWidth,
		1*wallWidth)

		love.graphics.rectangle(
		'fill',
		19*wallWidth, 
		24*wallWidth,
		3*wallWidth,
		1*wallWidth)

		love.graphics.rectangle(
		'fill',
		21*wallWidth, 
		17*wallWidth,
		2*wallWidth,
		6*wallWidth)

		love.graphics.rectangle(
		'fill',
		23*wallWidth, 
		17*wallWidth,
		4*wallWidth,
		2*wallWidth)
		
		love.graphics.rectangle(
		'fill',
		5*wallWidth, 
		20*wallWidth,
		2*wallWidth,
		2*wallWidth)

		love.graphics.rectangle(
		'fill',
		5*wallWidth, 
		22*wallWidth,
		1*wallWidth,
		1*wallWidth)
		
		love.graphics.rectangle(
		'fill',
		9*wallWidth, 
		20*wallWidth,
		2*wallWidth,
		2*wallWidth)

		love.graphics.rectangle(
		'fill',
		9*wallWidth, 
		22*wallWidth,
		1*wallWidth,
		1*wallWidth)
		
		love.graphics.rectangle(
		'fill',
		13*wallWidth, 
		20*wallWidth,
		2*wallWidth,
		2*wallWidth)

		love.graphics.rectangle(
		'fill',
		13*wallWidth, 
		22*wallWidth,
		1*wallWidth,
		1*wallWidth)

		love.graphics.rectangle(
		'fill',
		17*wallWidth, 
		20*wallWidth,
		2*wallWidth,
		2*wallWidth)

		love.graphics.rectangle(
		'fill',
		17*wallWidth, 
		22*wallWidth,
		1*wallWidth,
		1*wallWidth)

		love.graphics.rectangle(
		'fill',
		25*wallWidth, 
		12*wallWidth,
		2*wallWidth,
		5*wallWidth)

		love.graphics.rectangle(
		'fill',
		28*wallWidth, 
		22*wallWidth,
		5*wallWidth,
		1*wallWidth)


		
end
	