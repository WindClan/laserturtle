local l = peripheral.find("plethora:laser")
local m = peripheral.find("modem")
m.open(420)
local directions = {
	forw = 0,
	down = 90,
	back = 180,
	up = 270,
}
local mine = false
local function start(angle,amount)
	if not amount then amount = 1 end
	os.setComputerLabel("Laser Turtle - MINING")
	--if not angle then angle = 90 end
	while mine do
		for i=1,amount do
			l.fire(0,angle,5)
		end
		turtle.forward()
	end
end
local function stopLoop()
	while true do
		local event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
		if type(message) == "string" and message == "LASERSTOP" then
			mine = false
		end
	end
end
local function mainLoop()
	while true do
		os.setComputerLabel("Laser Turtle - READY")
		local event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
		if distance <= 20 and type(message) == "table" and message.type == "laser" then
			mine = true
			start(directions[message.dir],message.amount)
		end
	end
end
parallel.waitForAll(mainLoop,stopLoop)