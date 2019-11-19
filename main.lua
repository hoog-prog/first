function love.conf(t)
	t.console = true
end

function love.load()
	loveframes = require("loveframes")

	gui = {}
	data = {18,11,2019,11,'00'}
	local pers1 = {'Name','Second',18,3000}
	local cwd = love.filesystem.getSource( )
	print(cwd)
	local sucsess = love.filesystem.remove('test.txt')
	print(sucsess)
	love.filesystem.newFile('test.txt')
	
	for i = 1, table.getn(data) do
		love.filesystem.append('test.txt', data[i] .. '\n')
	end
	for i = 1, table.getn(pers1) do
		love.filesystem.append('test.txt', pers1[i] .. '\n')
	end
	
	drawData()
	
	print(pers1)
	
	for i=1, table.getn(pers1) do
	  print(pers1[i])
	end

	fileText = love.filesystem.read( 'test.txt' )
	
	local name = string.find(fileText,'2_')
	
	local main = {}
	for i=1, table.getn(pers1) do
	  main[i] = pers1[i]
	end
	
	for i = 1, table.getn(main) do
		print(main[i])
		if i == 1 then local nameText = setColorText(1,1,1,1,main[i]) end
		if i == 2 then 
			local secondNameText = setColorText(1,1,1,1,main[i]) 
			secondNameText:SetPos(0,i * 10)
		end
		
		
	end

	local button = loveframes.Create("button")
	button:SetText('Skip hour')
	button:SetPos(100,0)
    button.OnClick = function(object)
        dataChange('hour',1)
		drawData()
    end
	
	local button = loveframes.Create("button")
	button:SetText('Skip day')
	button:SetPos(100,25)
    button.OnClick = function(object)
        dataChange('day',1)
		drawData()
    end
	
	local button = loveframes.Create("button")
	button:SetText('Skip month')
	button:SetPos(100,50)
    button.OnClick = function(object)
        dataChange('month',1)
		drawData()
    end
	
	local button = loveframes.Create("button")
	button:SetText('Skip year')
	button:SetPos(100,75)
    button.OnClick = function(object)
        dataChange('year',1)
		drawData()
    end

end
 
function love.update(dt)
	loveframes.update(dt)
	

end

function love.draw()
    loveframes.draw()
end

function love.mousepressed(x, y, button)
    loveframes.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
    loveframes.mousereleased(x, y, button)
end

function setColorText(r,g,b,a,text)

	local colortext = {}
	table.insert(colortext, {color = {r, g, b, 1}})
	table.insert(colortext,text)
	local text1 = loveframes.Create("text")
    text1:SetText(colortext)

	return text1
end

function drawData()
	if dataText ~= nil then
		dataText:Remove()
	end
	
	dataText = setColorText(1,1,1,1, data[1] .. '.' .. data[2] .. '.' .. data[3] .. ' ' .. data[4] .. ':' .. data[5])
	dataText:SetPos(300,0)
	gui[1] = dataText
	
end

function dataChange(dataT, count)
	local dataMonth = {31,28,31,30,31,30,31,31,30,31,30,31}
	
	if dataT == 'hour' then

			data[4] = data[4] + count;
			
	end
	
	if dataT == 'day' then
		
			data[1] = data[1] + count;
		
	end
	
	if dataT == 'month' then
		data[2] = data[2] + count
	end
	
	if dataT == 'year' then
		data[3] = data[3] + count
	end
	
	if data[4] > 23 then
		data[4] = data[4] + count - 25
		data[1] = data[1] + 1
		
	end	
	
	
	
	if data[2] > 12 then
		data[2] = data[2] - 12
		data[3] = data[3] + 1
		
	end	
	
	if data[1] > dataMonth[data[2]] then
		data[1] = data[1] - dataMonth[data[2]]
		data[2] = data[2] + 1
	end	
end

