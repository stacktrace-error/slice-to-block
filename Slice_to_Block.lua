local sprite = app.activeSprite;
local cel = app.activeCel;
local img
local shades = {}
local clear = (sprite.colorMode == ColorMode.INDEXED and sprite.transparentColor or "ffffff00")

local w = sprite.width - 1
local w2 = sprite.width/2 - 1
local h = sprite.height - 1
local h2 = sprite.height/2 - 1

--Find layer containing shades to swap.
local shadeLayer
for _, layer in ipairs(sprite.layers) do
	if layer.name == "swaps" then
        shadeLayer = layer
        break
    end
end
if not shadeLayer then return app.alert("No 'swaps' layer found. See the image provided on the GitHub page.")end


--Get shades to swap.
local shImg = shadeLayer:cel(cel.frame and cel.frame.frameNumber or 1).image

local i = 0
while i < shImg.height do
	if shImg:getPixel(0, i) == clear then
		i = shImg.height
	else
		shades[i] = {shImg:getPixel(0, i), shImg:getPixel(1, i), shImg:getPixel(2, i)}
	end
	i = i + 1
end


--Turn the block into an 8th.
img = cel.image:clone()	
local pos = cel.position
for it in img:pixels() do
	local px = it.x + pos.x
	local py = it.y + pos.y
	if px <= w2 or py + px > w then
		it(clear)
	end
end
cel.image = img


--Un-8th the block.
app.command.Flip{target="mask"}
img = cel.image:clone()
--copy 8th to make a full quarter corner
for y=0, h2 do
	for x=y, w2 do
		img:drawPixel(y, x, img:getPixel(x, y))
	end
end
--mirror quarter for half
for y=0, h do
	for x=w2+1, w do
		img:drawPixel(x, y, img:getPixel(w - x, y))
	end
end
--mirror half for full
for y=h2+1, h do
	for x=0, w do
		img:drawPixel(x, y, img:getPixel(x, h - y))
	end
end


--Shade the block.
for _, arr in pairs(shades) do 
	local c1 = arr[1]
	local c2 = arr[2]
	local c3 = arr[3]
	local wh = img.width/2 - img.height/2

	for it in img:pixels() do
		local c = it()
		local g = it.x - it.y
		if g < wh then
			if c == c1 then
				it(c3)
			elseif c == c3 then
				it(c1)
			end
		elseif g == wh then 
			if c == c1 or c == c3 then
				it(c2)
			end
		end
	end
end
cel.image = img