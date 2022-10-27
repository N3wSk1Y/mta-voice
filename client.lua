function personalMute(thePlayer, command, name)
	local player = getPlayerFromName(name)
	if player ~= false
	then
		exports.voice:setPlayerMuted(player, true)
		outputChatBox("Игрок "..getPlayerName(player).." замучен", thePlayer)
	else
		outputChatBox("Игрока с таким ником нет на сервере", thePlayer)
	end
end
addCommandHandler("pmute", personalMute)

function personalUnMute(thePlayer, command, name)
	local player = getPlayerFromName(name)
	if player ~= false
	then
		exports.voice:setPlayerMuted(player, false)
		outputChatBox("Игрок "..getPlayerName(player).." размучен", thePlayer)
	else
		outputChatBox("Игрока с таким ником нет на сервере", thePlayer)
	end
end
addCommandHandler("punmute", personalUnMute)

function isPlayerMuted(thePlayer, command, name)
	local player = getPlayerFromName(name)
	if player ~= false
	then
		if exports.voice:setPlayerMuted(player)
		then
			outputChatBox("Игрок замучен", thePlayer)
		else
			outputChatBox("Игрок не замучен", thePlayer)
		end
	end
end
addCommandHandler("ismuted", personalUnMute)