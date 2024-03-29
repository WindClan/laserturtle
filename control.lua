local m = peripheral.find("modem")
local args = {...}
if args[1] ~= "stop" then
	m.transmit(420, 420, {
		type = "laser",
		dir = args[1],
		amount = args[2]
	})
else
	m.transmit(420, 420, "LASERSTOP")
end
