function love.conf(t)
	t.console = true
end

function love.load()
	loveframes = require("loveframes")

	dataMonth = {31,28,31,30,31,30,31,31,30,31,30,31}

	dataPers = {}

	gui = {}
	data = {18,11,2019,11,0}
	pers1 = {'Name','Second',18,3000}
	
	eatTime = {09, 0,12,0,17,0}
	eatPrice = 300
	
	drawData()
	
	print(pers1)
	
	-- for i=1, table.getn(pers1) do
	  -- print(pers1[i])
	-- end

	fileText = love.filesystem.read( 'test.txt' )
	
	local name = string.find(fileText,'2_')
	
	-- local main = {}
	-- for i=1, table.getn(pers1) do
	  -- main[i] = pers1[i]
	-- end
	
	-- for i = 1, table.getn(main) do
		-- print(main[i])
		-- if i == 1 then local nameText = setColorText(1,1,1,1,main[i]) end
		-- if i == 2 then 
			-- local secondNameText = setColorText(1,1,1,1,main[i]) 
			-- secondNameText:SetPos(0,i * 10)
		-- end
		
		-- if i == 4 then 
			-- local moneyText = setColorText(1,1,1,1,main[i]) 
			-- secondNameText:SetPos(0,i * 10)
		-- end		
	-- end

	local button = loveframes.Create("button")
	button:SetText('Skip 5 minutes')
	button:SetPos(100,0)
    button.OnClick = function(object)
        dataChange('minute',5)
		drawData()
    end

	local button = loveframes.Create("button")
	button:SetText('Skip hour')
	button:SetPos(100,25)
    button.OnClick = function(object)
        for i = 1, 12 do
			dataChange('minute',5)
		end
		drawData()
    end
	
	local button = loveframes.Create("button")
	button:SetText('Skip day')
	button:SetPos(100,50)
    button.OnClick = function(object)
        for i = 1, 12 * 24 do
			dataChange('minute',5)
		end
		drawData()
    end
	
	local button = loveframes.Create("button")
	button:SetText('Skip month')
	button:SetPos(100,75)
    button.OnClick = function(object)
		local currentMonth = dataMonth[data[2]]
        for i = 1, 12 * 24 * currentMonth do
			dataChange('minute',5)
		end
		drawData()
    end
	
	local button = loveframes.Create("button")
	button:SetText('Skip year')
	button:SetPos(100,100)
    button.OnClick = function(object)
		for i = 1, 365*24*12 do
			dataChange('minute',5)
		end
        --dataChange('year',1)
		drawData()
    end
	
	local button = loveframes.Create("button")
	button:SetText('Save')
	button:SetPos(100,125)
    button.OnClick = function(object)
        SaveData()
    end
	
	local button = loveframes.Create("button")
	button:SetText('Load')
	button:SetPos(100,150)
    button.OnClick = function(object)
        LoadData()
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
	
	if dataPers ~= nil and table.getn(dataPers) ~= 0 then
		for i = 1, table.getn(dataPers) do
			print(i)
			dataPers[i]:Remove()
		end
	end
	
	dataText = setColorText(1,1,1,1, data[1] .. '.' .. data[2] .. '.' .. data[3] .. ' ' .. data[4] .. ':' .. data[5])
	dataText:SetPos(300,0)
	gui[1] = dataText
	
	for i = 1, table.getn(pers1) do
		if i == 1 then dataPers[i] = setColorText(1,1,1,1,pers1[i]) end
		if i == 2 then 
			dataPers[i] = setColorText(1,1,1,1,pers1[i]) 
			dataPers[i]:SetPos(0,i * 15)
		end
		
		if i == 3 then 
			dataPers[i] = setColorText(1,1,1,1,pers1[i]) 
			dataPers[i]:SetPos(0,i * 15)
		end	

		if i == 4 then 
				dataPers[i] = setColorText(1,1,1,1,pers1[i]) 
				dataPers[i]:SetPos(0,i * 15)
			end			
		end
	
	gui[2] = dataPers
	
end

function dataChange(dataT, count)
	
	if dataT == 'minute' then
		data[5] = data[5] + count;
		if data[5] > 59 then
			data[5] = data[5] - 60
			data[4] = data[4] + 1
			if data[4] > 23 then
				data[4] = 0
				data[1] = data[1] + 1
				if data[1] > dataMonth[data[2]] then
					data[1] = 1
					data[2] = data[2] + 1
					if data[2] > 12 then
						data[2] = 1
						data[3] = data[3] + 1
					end
				end
			end
		end
	end
	
	DoSome()
	
end

function SaveData()
	local cwd = love.filesystem.getSource( )
	print(cwd)
	local sucsess = love.filesystem.remove('test.txt')
	print(sucsess)
	love.filesystem.newFile('test.txt')
	
	for i = 1, table.getn(data) do
		love.filesystem.append('test.txt', data[i] .. '\n')
	end
	print(table.getn(pers1))
	for i = 1, table.getn(pers1) do
		love.filesystem.append('test.txt', pers1[i] .. '\n')
	end
end

function LoadData()
	local cwd = love.filesystem.getSource( )
	print(cwd)
	local tempData = {}
	for line in love.filesystem.lines("test.txt") do
	  table.insert(tempData, line)
	end
	
	local i = 1
	while  i <= table.getn(data) do
		data[i] = tonumber(tempData[i])
		i = i+1
	end
	
	while  i <= table.getn(pers1) + table.getn(data) do
		pers1[i] = tonumber(tempData[i])
		i = i+1
	end
	
	
	drawData()
end

function DoSome()
	
	if data[4] == eatTime[1] and data[5] == eatTime[2] then
		pers1[4] = pers1[4] - eatPrice
	elseif data[4] == eatTime[3] and data[5] == eatTime[4] then
		pers1[4] = pers1[4] - eatPrice
	elseif data[4] == eatTime[5] and data[5] == eatTime[6] then
		pers1[4] = pers1[4] - eatPrice
	end

	
end

