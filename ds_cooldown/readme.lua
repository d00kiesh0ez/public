Thank you for checking out my standalone cooldown script. This script can be utilized for only server sided things such as banks, stores, vangelico or any other cooldowns you can imagine by utilizing os.time() [server time] to check & set cooldowns to a particular time to allow to happen again.

Most scripts that do cooldowns have Threads server sided that countdown until the script resets itself. Doing this causes server performance issues and you can easily bypass this by using a script like the one you just downloaded.

Example most common ways people reset scripts with cooldowns :

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(TIME) -- this TIME normally checks every second to make sure when something hits it will pick it up
		if COOLDOWN then -- this states when it should start counting down
			Citizen.Wait(TIME) -- this is the duration that it will take before it resets the cooldown
			COOLDOWN = false
		end
	end
end)

The code above is not exact but just a rough example and using this method is poor performance as doing this, server sided, will cause issues for everyone.


My script is simple as you set up CHECKS first to see if something is on cooldown and if not, it will allow you to do X thing. 

Example : 


-- Client Side
RegisterNetEvent('d00kiesh0es:clientTest')
AddEventHandler('d00kiesh0es:clientTest', function()
	TriggerServerEvent('d00kiesh0es:checkCooldown')
end)

-- checking server cooldown time
RegisterServerEvent('d00kiesh0es:checkCooldown')
AddEventHandler('d00kiesh0es:checkCooldown', function()
	local time = os.time() -- this will gather your server time and need it to send it over 

	if not exports["ds_cooldown"]:CheckTest(time) then INSERT_NOTIFICATION_SAYING_YOU_CANT_DO_THIS return end -- this line says you sent over the time, using the export shown, and it is still on cooldown

	-- INSERT TRIGGER CLIENT SIDE TO START
end)

-- CheckTest function
function CheckTest(time)
	local length = 3600 -- one hour cooldown

	if testCooldown + length <= time then 
		-- INSERT RESET VALUES TO THE SCRIPT SO IT WILL ALLOW YOU TO DO IT IF TIME IS UP
		return true
	else
		return false
	end
end

--[[
This function (above) will be broken down to give you a better understanding on how to utilize it

local length = 3600
	3600 is a value that represents 1 hour when using the os.time()
	This value can change depending on duration you want (ex : 30 min timer = 1800)
if testCooldown + length <= time then 
	testCooldown is set to 0 when script is on restart (its posted outside of triggers on line 1 as the value of 0)
	length is the cooldown duration
	<= time is saying that the time you sent over is more than the duration of the cooldown
	Example : 
		testCooldown = 0
		length = 3600 -- one hour
		Simple math : 0 + 3600 = 3600
		time = 4000 -- get this value from using exports["ds_cooldown"]:CheckTest(time) [found on line 36 of this readme]

		so for this example it would return a value of TRUE meaning the cooldown is over and the script will continue [return true]

]]


-- setting server cooldown time
RegisterServerEvent('d00kiesh0es:setCooldown')
AddEventHandler('d00kiesh0es:setCooldown', function()
	local time = os.time() -- this will send over the time after using the checkCooldown option above

	exports["ds_cooldown"]:SetTest(time) -- this will set the time, found on servers end, and will begin a cooldown
end)

-- SetTest function
function SetTest(time)
	local length = 3600 -- one hour cooldown

	if testCooldown + length <= time then 
		testCooldown = 0
		testCooldown = time
		return true
	else
		return false
	end
end


--[[
This function (above) will be broken down to give you a better understanding on how to utilize it

local length = 3600
	3600 is a value that represents 1 hour when using the os.time()
	This value can change depending on duration you want (ex : 30 min timer = 1800)
	this value SHOULD match the value checked in CheckTest function
if testCooldown + length <= time then 
	means that if the length of time is less than the time you sent over [os.time()] then it will set the timer for the cooldown
testCooldown = 0
	resets the timer to 0 everytime it attempts to set the time (need this if a cooldown is used often such as robberies)
testCooldown = time
	sets the value of the time sent over to so that then, when using CheckTest, they will have to wait 1 hour (how these examples are set up) until this will work again
]]