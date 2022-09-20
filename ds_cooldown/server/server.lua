local testCooldown = 0

Citizen.CreateThread(function()
	local currentTime = os.time() - 1800

	testCooldown = currentTime

	print('^5[ds_cooldown] ^0 :', os.date('%X', testCooldown))
end)

function CheckTest(time)
	local length = 3600 -- one hour cooldown
	local next = 0

	if testCooldown + length <= time then 
		-- INSERT RESET VALUES TO THE SCRIPT SO IT WILL ALLOW YOU TO DO IT IF TIME IS UP
		return true
	else
		return false
	end
end

function SetTest(time)
	local length = 3600 -- one hour cooldown
	local next = 0

	if testCooldown + length <= time then 
		testCooldown = 0
		testCooldown = time
		next = testCooldown + length
		return true
	else
		return false
	end
end
