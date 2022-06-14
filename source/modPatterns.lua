-- title:   Mod Patterns
-- author:  JoaoPauloVF
-- desc:    A geometric patterns generator based on modulo operations
-- github:  https://github.com/JoaoPauloVF/Mod-Patterns
-- license: MIT License
-- version: 0.1
-- input:   keyboard
-- palette: SWEETIE-16
-- script:  lua

--[[
            ----Summary----
            
	(search for the term and press down):

	* Constants
	
	* Math Code
	
		- newMatrix()
	
		- Math Functions Sample
	
	* Pattern Drawing Code
		
		- Tiles Functions Sample
	
		- drawLayer()
	
		- drawMultiLayer()
		
		- drawCover()
	
	* UI code
	
		- showTexts
	
		- printWithRect()
	
		- Menu Code
		
			. List Class
			
			. mathFuncs()
			
			. tileTypes
			
			. tilesOrders
	
			. The menu Object
	
	* TIC()
]]--

----Constants----
WIDTH = 240
HEIGHT = 136

UP = 0
DOWN = 1
LEFT = 2
RIGHT = 3
Z = 4

BG_COLOR = 0
PATTERN_PAL = {2, 3, 4, 5, 6, 9, 10, 11, 12}

----Math Code----
--[[
	Code responsible for holding math 
	functions and creating numeric 
	matrices from these.
	
	Most math functions are modulo 
	operations because they are good at 
	making sequences of integer numbers.
]]--

----newMatrix()----
--[[
	It returns a matrix of "m" rows and 
	"n" columns based on a math function 
	like f(m, n) = (m+n)%2.
]]--
function newMatrix(mathFunc, rows, cols, moduloBs)
	local matrix = {}
		
	rows.bg = rows.bg or 1
	cols.bg = cols.bg or 1
	
	rows.endg = rows.endg or 1
	cols.endg = cols.endg or 1
	
	local moduloBs = moduloBs or 4
	
	for m=rows.bg, rows.endg do
		local row = {}
		for n=cols.bg, cols.endg do
			table.insert(row, mathFunc(m, n, moduloBs))
		end
		table.insert(matrix, row)
	end
	
	return matrix
end

----Math Functions Sample----
--[[
	The math functions that create the 
	matrices for the patterns.
	
	Most of them get a row(m), a 
	column(n), and a base. 
	Then they return a modulo result 
	from these numbers.
]]--
function const0() return 0 end
function const1() return 1 end
function const2() return 2 end
function const3() return 3 end
function pattern1(m, n, base)
	if base == 0 then return nil end
	return (m+n)%base
end
function pattern2(m, n, base)
	if base == 0 then return nil end
	return (m*2+n)%base
end
function pattern3(m, n, base)
	if base == 0 then return nil end
	return (m+n*2)%base
end
function pattern4(m, n, base)
	if base == 0 then return nil end
	return (m*m+n)%base
end
function pattern5(m, n, base)
	if base == 0 then return nil end
	return (m*m+2*n)%base
end
function pattern6(m, n, base)
	if base == 0 then return nil end
	return ((m*1.5+n)%base)//1
end
function pattern7(m, n, base)
	if base == 0 then return nil end
	return ((m+n*1.5)%base)//1
end
function pattern8(m, n, base)
	if base == 0 then return nil end
	return (((m+n)*1.5)%base)//1
end
function pattern9(m, n, base)
	if base == 0 then return nil end
	return ((m+n)^2)%base
end
function pattern10(m, n, base)
	if base == 0 then return nil end
	return ((2*m+n)^2)%base
end
function pattern11(m, n, base)
	if base == 0 then return nil end
	return ((m+n)^3)%base
end
function pattern12(m, n, base)
	if base == 0 then return nil end
	return ((2*m+n)^3)%base
end
function pattern13(m, n, base)
	if base == 0 then return nil end
	return ((m+n)//2)%base
end
function pattern14(m, n, base)
	if base == 0 then return nil end
	return ((m+n)//3)%base
end
function pattern15(m, n, base)
	if base == 0 then return nil end
	return (m)%base
end
function pattern16(m, n, base)
	if base == 0 then return nil end
	return (n)%base
end
function pattern17(m, n, base)
	if base == 0 then return nil end
	return (m*m)%base
end
function pattern18(m, n, base)
	if base == 0 then return nil end
	return (m*2)%base
end
function pattern19(m, n, base)
	if base == 0 then return nil end
	return (m*3)%base
end
function pattern20(m, n, base)
	if base == 0 then return nil end
	return (m//2)%base
end
function pattern21(m, n, base)
	if base == 0 then return nil end
	return (m//3)%base
end
function pattern22(m, n, base)
	if base == 0 then return nil end
	return ((m+n)*m*n)%base
end


----Pattern Drawing Code----
--[[
	Here, stay the functions that draw 
	things like: a unique tile(the 
	smallest piece of the pattern), 
	a layer(a set of tiles), and a 
	multi-layer(several layers at 
	a time).
	
	They use matrices from the before 
	functions to decide how to produce 
	the final pattern.
]]--

----Tiles Functions Sample----
--[[
	These functions draw a tile on the 
	screen.
	
	The following tiles have four output 
	options.
	
	They also get integer numbers to 
	choose this option, their size, color, 
	filling(if they are filled or are 
	a border only), and visibility.
]]--
function Tile_Triangle(settings)
	local value = settings.value--Output option
	local tileOpts = settings.tileOpts
	local tileSize = settings.tileSize
	
	local fillValue = settings.fillValue
	
	local drawValue = settings.drawValue
	local drawBase = settings.drawBase

	local color = settings.color

	local x = settings.x
	local y = settings.y
	
	local points = {
		{x=x, y=y},
		{x=x+tileSize, y=y},
		{x=x+tileSize, y=y+tileSize},
		{x=x, y=y+tileSize}
	}
	
	table.remove(points, tileOpts[value+1]+1)
		
	if drawValue%drawBase==0 then	
		local triFunc = fillValue%2 == 0 and tri or trib
		triFunc(
			points[1].x, points[1].y, 
			points[2].x, points[2].y,
			points[3].x, points[3].y,
			color
		)
	end
end

function Tile_Triangle2(settings)
	local value = settings.value
	local tileOpts = settings.tileOpts
	local tileSize = settings.tileSize
	
	local fillValue = settings.fillValue
	
	local drawValue = settings.drawValue
	local drawBase = settings.drawBase

	local color = settings.color

	local x = settings.x
	local y = settings.y
	
	local x1 = x
	local y1 = y+tileSize/2
	local x2, x3 = x+tileSize, x+tileSize
	local y2, y3 = y, y+tileSize
	
	if value == tileOpts[2] then
		
		x1 = x+tileSize/2
		y1 = y
		x2, x3 = x, x+tileSize
		y2, y3 = y+tileSize, y+tileSize

	elseif value == tileOpts[3] then
		
		x1 = x+tileSize
		y1 = y+tileSize/2
		x2, x3 = x, x

	elseif value == tileOpts[4] then
		
		x1 = x+tileSize/2
		y1 = y+tileSize
		x2, x3 = x+tileSize, x
		y2, y3 = y, y

	end
	
	local points = {
		{x=x1, y=y1},
		{x=x2, y=y2},
		{x=x3, y=y3}
	}
	
	if drawValue%drawBase==0 then	
		local triFunc = fillValue%2 == 0 and tri or trib
		triFunc(
			points[1].x, points[1].y, 
			points[2].x, points[2].y,
			points[3].x, points[3].y,
			color
		)
	end
end

function Tile_MiniTriangle(settings)
	local value = settings.value--Output option
	local tileOpts = settings.tileOpts
	local tileSize = settings.tileSize
	
	local fillValue = settings.fillValue
	
	local drawValue = settings.drawValue
	local drawBase = settings.drawBase

	local color = settings.color

	local x = settings.x
	local y = settings.y
	
	local triangles = {
		{
			{x=x, y=y+tileSize/2},
			{x=x+tileSize/3, y=y+tileSize/3},
			{x=x+tileSize/3, y=y+tileSize*2/3}
		},
		{
			{x=x+tileSize/2, y=y},
			{x=x+tileSize/3, y=y+tileSize/3},
			{x=x+tileSize*2/3, y=y+tileSize/3}
		},
		{
			{x=x+tileSize, y=y+tileSize/2},
			{x=x+tileSize*2/3, y=y+tileSize/3},
			{x=x+tileSize*2/3, y=y+tileSize*2/3}
		},
		{
			{x=x+tileSize/2, y=y+tileSize},
			{x=x+tileSize*2/3, y=y+tileSize*2/3},
			{x=x+tileSize/3, y=y+tileSize*2/3}
		}
	}
	
	table.remove(triangles, tileOpts[value+1]+1)
		
	if drawValue%drawBase==0 then	
		local triFunc = fillValue%2 == 0 and tri or trib
		for _, triangle in pairs(triangles) do
			triFunc(
				triangle[1].x, triangle[1].y, 
				triangle[2].x, triangle[2].y,
				triangle[3].x, triangle[3].y,
				color
			)
		end
	end
end

function Tile_Square(settings)
	local value = settings.value
	local tileOpts = settings.tileOpts
	local tileSize = settings.tileSize
	
	local fillValue = settings.fillValue
	
	local drawValue = settings.drawValue
	local drawBase = settings.drawBase

	local color = settings.color

	local x = settings.x
	local y = settings.y
	
	local sqSize = tileSize/2
	
	local sqX = 
		(value==tileOpts[0] or value==tileOpts[3]) 
		and x 
		or x+tileSize/2
		
	local sqY = 
		(value==tileOpts[0] or value==tileOpts[1]) 
		and y 
		or y+tileSize/2
		
	if drawValue%drawBase==0 then	
		local rectFunc = fillValue%2 == 0 and rect or rectb
		rectFunc(
			sqX, sqY, 
			sqSize, sqSize,
			color
		)
	end
end

function Tile_DoubleSquare(settings)
	local value = settings.value
	local tileOpts = settings.tileOpts
	local tileSize = settings.tileSize
	
	local fillValue = settings.fillValue
	
	local drawValue = settings.drawValue
	local drawBase = settings.drawBase

	local color = settings.color

	local x = settings.x
	local y = settings.y
	
	local sqSize = tileSize/2
	
	local x1 = x
	local y1 = y
	local x2 = x + tileSize/2
	local y2 = y + tileSize/2
	
	if value == tileOpts[2] then
		x1, x2 = x + tileSize/4, x + tileSize/4
	elseif value == tileOpts[3] then
		x1, x2 = x2, x1
	elseif value == tileOpts[4] then
		y1, y2 = y + tileSize/4, y + tileSize/4
	end
	
	local points = {
		{x=x1, y=y1},
		{x=x2, y=y2}
	}
	
	if drawValue%drawBase==0 then	
		local rectFunc = fillValue%2 == 0 and rect or rectb
		for _, point in ipairs(points) do
			rectFunc(
				point.x, point.y, 
				sqSize, sqSize,
				color
			)
		end
	end
end

function Tile_Rectangle(settings)
	local value = settings.value
	local tileOpts = settings.tileOpts
	local tileSize = settings.tileSize
	
	local fillValue = settings.fillValue
	
	local drawValue = settings.drawValue
	local drawBase = settings.drawBase

	local color = settings.color

	local x = settings.x
	local y = settings.y
	
	local rectWidth = tileSize/2
	local rectHeight = tileSize
	
	local rectX = x
	local rectY = y
	
	if value == tileOpts[2] then
		rectWidth, rectHeight = tileSize, tileSize/2
	elseif value == tileOpts[3] then
		rectX = x + tileSize/2
	elseif value == tileOpts[4] then
		rectY = y + tileSize/2
		rectWidth, rectHeight = tileSize, tileSize/2
	end
		
	if drawValue%drawBase==0 then	
		local rectFunc = fillValue%2 == 0 and rect or rectb
		rectFunc(
			rectX, rectY, 
			rectWidth, rectHeight,
			color
		)
	end
end
----drawLayer()----
--[[
	It draws a set of tiles using 
	matrices to control the settings 
	of each one.
	
	Moreover, it accepts settings to 
	the matrices limits, layer position, 
	and order of the tile options.
]]--
function drawLayer(settings)
	--Parament to create matrices for each tile setting
	local matricesSizes = settings.matricesSizes or {rows={bg=1, endg=1}, cols={bg=1, endg=1}}
	
	local tileMatrix = settings.tileMatrix--{mathFunction, moduloBase}
	local palMatrix = settings.palMatrix
	local fillMatrix = settings.fillMatrix
	local drawMatrix = settings.drawMatrix
	
	--Matrices for each tile setting
	local matrix = newMatrix(tileMatrix.func, matricesSizes.rows, matricesSizes.cols, tileMatrix.moduloBs)
	local palMatrix = newMatrix(palMatrix.func, matricesSizes.rows, matricesSizes.cols, palMatrix.moduloBs)
	local fillMatrix = newMatrix(fillMatrix.func, matricesSizes.rows, matricesSizes.cols, fillMatrix.moduloBs)
	local drawMatrix = newMatrix(drawMatrix.func, matricesSizes.rows, matricesSizes.cols, drawMatrix.moduloBs)
	--Tile variables
	local tileSize = settings.tileSize or 8
	local tileOpts = settings.tileOpts or {0, 1, 2, 3}
	local tileFunc = settings.tileFunc or function() return 0 end
	--Color variables
	local palette = settings.palette or {12}
	local drawBase = settings.drawMatrix.moduloBs or 2
	--Position variables
	local posX = settings.posX or 0
	local posY = settings.posY or 0
	
	local rows = #matrix
	local cols = #matrix[1] --Consider all rows with the same length
	for m=1, rows do
		for n=1, cols do
			local x = (m-1)*tileSize + posX
			local y = (n-1)*tileSize + posY
			
			local color = palette[
				(palMatrix[m][n]%#palette)+1
			]
			
			local tileSets = {
				value = matrix[m][n],
				x=x, y=y,
				tileSize = tileSize,
				tileOpts = tileOpts,
				fillValue = fillMatrix[m][n],
				drawValue = drawMatrix[m][n],
				drawBase = drawBase,
				color = color
			}
			
			tileFunc(tileSets)
		end
	end
end

----drawMultiLayer()----
--[[
	It draws several layers with a 
	background color.
]]--
function drawMultiLayer(bgColor, ...)
	bgColor = bgColor or 15
	
	cls(bgColor)
	for _, layerSets in ipairs{...} do
		drawLayer(layerSets)
	end
end

----drawCover()----
--[[
	It draws some patterns to serve as 
	the cartridge cover.
]]--

function drawCover()
	local x = WIDTH*0.25
	
	local tileSize = 15
	local tileOptsNum = 4
	
	local pal1 = {9, 10, 11, 12}
	local pal2 = {2, 3, 4, 5, 6}
	
	local mLimits = {rows={bg=0, endg=3}, cols={bg=1, endg=10}}
	local drawFuncSets = {func=const0, moduloBs=1}
	
	drawMultiLayer(
		BG_COLOR,
		{
			matricesSizes = mLimits,
			
			tileMatrix = {func=pattern9, moduloBs=tileOptsNum},
			palMatrix = {func=pattern19, moduloBs=#pal2},
			fillMatrix = {func=const0, moduloBs=2},
			drawMatrix = drawFuncSets,
			
			tileFunc = Tile_Triangle,
			tileSize = tileSize,
			palette = pal1,
			posX = x*0
		},
		{
			matricesSizes = mLimits,
			
			tileMatrix = {func=const0, moduloBs=tileOptsNum},
			palMatrix = {func=pattern13, moduloBs=#pal2},
			fillMatrix = {func=pattern13, moduloBs=4},
			drawMatrix = drawFuncSets,
			
			tileFunc = Tile_DoubleSquare,
			tileSize = tileSize,
			palette = pal2,
			posX = (x*1)+1
		},
		{
			matricesSizes = mLimits,
			
			tileMatrix = {func=pattern18, moduloBs=tileOptsNum},
			palMatrix = {func=pattern1, moduloBs=#pal1},
			fillMatrix = {func=fillMthF, moduloBs=fillMthFBs},
			drawMatrix = drawFuncSets,
			
			tileFunc = Tile_MiniTriangle,
			tileSize = tileSize,
			tileOpts = tileOrder,
			palette = pal1,
			posX = x*2
		},
		{
			matricesSizes = mLimits,
			
			tileMatrix = {func=pattern9, moduloBs=tileOptsNum},
			palMatrix = {func=pattern8, moduloBs=#pal2},
			fillMatrix = {func=pattern1, moduloBs=2},
			drawMatrix = drawFuncSets,
			
			tileFunc = Tile_Rectangle,
			tileSize = tileSize,
			tileOpts = {0, 1, 3, 2},
			palette = pal2,
			posX = x*3
		}
	)
end

----UI Code----
--[[
	These lines of code care for how to 
	show the texts and construct a menu 
	for the user to control the output 
	pattern.
]]--

----showTexts----
--[[
	It indicates if the menu and the 
	tutoeial must appear.
]]--
showTexts = true
function updateShowTexts()
	if btnp(Z, 0, 10) then 
		showTexts = not(showTexts)
 end
end

----printWithRect()----
--[[
	This function highlights texts by 
	printing them in a black rectangle.
	
	The text can be a string or a list of
 strings(to multiple-lines texts).
]]--
function printWithRect(text, x, y)
	local FONT_H = 6
	
	--Get the text width
	local biggerW = nil
	if type(text) == "table" then
		biggerW = print(text[1], 0, -FONT_H)
		for i=2, #text do
			local w = print(text[i], 0, -FONT_H)
			biggerW = w > biggerW and w or biggerW
		end
	end
	local textW = biggerW or print(text, 0, -FONT_H)
	
	--Internal rectangle margin
	local margin = 3
	
	local rectW = textW + 2*margin
	local rectH = type(text)=="table" and 1.5*(#text*FONT_H+(#text+1)*margin)  or FONT_H + 2*margin
	--Render the rectangle
	rect(
		x, y,
		rectW, rectH,
		0
	)
	--Print the text
	if type(text)=="table" then
		for i=1, #text do
			print(
				text[i],
				x+margin, y+1.5*(margin*i+FONT_H*(i-1)),
				12
			)
		end
	else
		print(
			text,
			x+margin, y+margin,
			12
		)
	end
end

----Menu Code----
--[[
	In short, the menu logic.
]]--
----List Class----
--[[
	It's a prototype table to make list 
	objects.
	
	A list object has an array of 
	elements and an index that points 
	to one element at a time.

	It also has functions to get the 
	pointed element and to update 
	the index from two control buttons.
]]--
List = {}
List.index = 1
List.elements = {}

function List:updateIndex(beforeB, nextB)
	local BTN_DELAY = 10
	
	beforeB = beforeB or LEFT
	nextB = nextB or RIGHT
	
	if btnp(beforeB, 0, BTN_DELAY) then
		self.index = self.index-1 < 1 and #self.elements or self.index-1
	elseif btnp(nextB, 0, BTN_DELAY) then
		self.index = self.index+1 > #self.elements and 1 or self.index+1
	end
end
function List:getCurrElement()
	return self.elements[self.index]
end
function List:new(elementsArray)
	elementsArray = elementsArray or {}
	
	local obj = {}
	setmetatable(obj, {__index=self})
	obj.elements = elementsArray
	return obj
end

----mathFuncs()----
--[[
	It returns a list of the before 
	math functions with their labels.
	
	The menu uses it to show some 
	options.
]]--
function mathFuncs(base)
	local baseStr = tostring(base)
	return {
		{
			label="f(m, n) = 0", 
			func=const0
		},
		{
			label="f(m, n) = 1", 
			func=const1
		},
		{
			label="f(m, n) = 2", 
			func=const2
		},
		{
			label="f(m, n) = 3", 
			func=const3
		},
		{
			label="f(m, n) = (m+n)%"..baseStr, 
			func=pattern1
		},
		{
			label="f(m, n) = (m*2+n)%"..baseStr, 
			func=pattern2
		},
		{
			label="f(m, n) = (m+n*2)%"..baseStr, 
			func=pattern3
		},
		{
			label="f(m, n) = (m*m+n)%"..baseStr, 
			func=pattern4
		},
		{
			label="f(m, n) = (m*m+n*2)%"..baseStr, 
			func=pattern5
		},
		{
			label="f(m, n) = ((m*1.5+n)%"..baseStr..")//1", 
			func=pattern6
		},
		{
			label="f(m, n) = ((m+n*1.5)%"..baseStr..")//1", 
			func=pattern7
		},
		{
			label="f(m, n) = (((m+n)*1.5)%"..baseStr..")//1", 
			func=pattern8
		},
		{
			label="f(m, n) = ((m+n)^2)%"..baseStr, 
			func=pattern9
		},
		{
			label="f(m, n) = ((m*2+n)^2)%"..baseStr, 
			func=pattern10
		},
		{
			label="f(m, n) = ((m+n)^3)%"..baseStr, 
			func=pattern11
		},
		{
			label="f(m, n) = ((m*2+n)^3)%"..baseStr, 
			func=pattern12
		},
		{
			label="f(m, n) = ((m+n)//2)%"..baseStr, 
			func=pattern13
		},
		{
			label="f(m, n) = ((m+n)//3)%"..baseStr, 
			func=pattern14
		},
		{
			label="f(m, n) = (m)%"..baseStr, 
			func=pattern15
		},
		{
			label="f(m, n) = (n)%"..baseStr, 
			func=pattern16
		},
		{
			label="(m*m)%"..baseStr,
			func=pattern17
		},
		{
			label="(m*2)%"..baseStr,
			func=pattern18
		},
		{
			label="(m*3)%"..baseStr,
			func=pattern19
		},
		{
			label="(m//2)%"..baseStr,
			func=pattern20
		},
		{
			label="(m//3)%"..baseStr,
			func=pattern21
		},
		{
			label="(((m+n)*m*n)%"..baseStr..")//1",
			func=pattern22
		}
	}
end

----tileTypes----
--[[
	List of the before tile functions 
	to the menu.
]]--
tileTypes = 
{
	{
		label = "Triangle",
		func = Tile_Triangle
	},
	{
		label = "Triangle2",
		func = Tile_Triangle2
	},
	{
		label = "Mini Triangles",
		func = Tile_MiniTriangle
	},
	{
		label = "Square",
		func = Tile_Square
	},
	{
		label = "Double-Square",
		func = Tile_DoubleSquare
	},
	{
		label = "Rectangle",
		func = Tile_Rectangle
	}
}

----tilesOrders----
--[[
	List with different orders of tiles 
	options.
]]--
tilesOrders = {
	{
		label = "0, 1, 2, 3",
		order = {0, 1, 2, 3}
	},
	{
		label = "3, 2, 1, 0",
		order = {3, 2, 1, 0}
	},
	{
		label = "0, 2, 1, 3",
		order = {0, 2, 1, 3}
	},
	{
		label = "3, 1, 2, 0",
		order = {3, 1, 2, 0}
	},
	{
		label = "1, 3, 0, 2",
		order = {1, 3, 0, 2}
	},
	{
		label = "2, 0, 3, 1",
		order = {2, 0, 3, 1}
	}
}

----The menu Object----
--[[
	The menu is simply a list of lists.
	
	Each list chooses a setting to draw 
	the layer, like the tile function.
]]--
menu = {}
menu.x = WIDTH*0.03
menu.y = HEIGHT*0.03
--Modulo base for the menu options
tileMthFBs = 4
palMthFBs  = #PATTERN_PAL
fillMthFBs = 2
drawMthFBs = 2
--menu options
menu.tileTypes = List:new(tileTypes)
menu.tileMthFs = List:new(mathFuncs(tileMthFBs))
menu.palMthFs = List:new(mathFuncs(palMthFBs))
menu.fillMthFs = List:new(mathFuncs(fillMthFBs))
menu.drawMthFs = List:new(mathFuncs(drawMthFBs))
menu.tilesOrders = List:new(tilesOrders)
--list of the options
menu.options = List:new({
	{
		label = "Tile Type: ",
		list = menu.tileTypes
	},
	{
		label = "Tiles Func.: ",
		list = menu.tileMthFs
	},
	{
		label = "Palette Func.: ",
		list = menu.palMthFs
	},
	{
		label = "Filling Func.: ",
		list = menu.fillMthFs
	},
	{
		label = "Visibility Func.: ",
		list = menu.drawMthFs
	},
	{
		label = "Tiles Order: ",
		list = menu.tilesOrders
	}
})

function menu.update()
	menu.options:updateIndex(UP, DOWN)
	menu.options:getCurrElement().list:updateIndex()
end
menu.render = function()		
	local texts = {}
	for index, option in pairs(menu.options.elements) do
		local text = option.list:getCurrElement().label
		
		local arrow = 
			index==menu.options.index
			and "> " 
			or "  "
		
		text = arrow..option.label..text			
		
		table.insert(texts, text)
	end
	
	printWithRect(texts, menu.x, menu.y)
end

----TIC()----
function TIC()
	menu.update()
		
	--Current values for each menu option
	tileType = menu.tileTypes:getCurrElement().func
	tileMthF = menu.tileMthFs:getCurrElement().func
	palMthF  = menu.palMthFs:getCurrElement().func
	fillMthF = menu.fillMthFs:getCurrElement().func
	drawMthF = menu.drawMthFs:getCurrElement().func
	tileOrder= menu.tilesOrders:getCurrElement().order
	
	drawMultiLayer(
		BG_COLOR,
		{
			matricesSizes = {rows={bg=1, endg=15}, cols={bg=1, endg=9}},
			
			tileMatrix = {func=tileMthF, moduloBs=tileMthFBs},
			palMatrix = {func=palMthF, moduloBs=palMthFBs},
			fillMatrix = {func=fillMthF, moduloBs=fillMthFBs},
			drawMatrix = {func=drawMthF, moduloBs=drawMthFBs},
			
			tileFunc = tileType,
			tileSize = 16,
			tileOpts = tileOrder,
			palette = PATTERN_PAL,
		}
	)
	
	--Print menu and tutorial texts
	updateShowTexts()
	if showTexts then
		menu.render()
	end
	
	--drawCover()
end
