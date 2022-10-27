local spawnX, spawnY, spawnZ = 1959.55, -1714.46, 20

function joinHandler()
	spawnPlayer( source, spawnX, spawnY, spawnZ )
	fadeCamera( source, true )
	setCameraTarget( source, source )
	outputChatBox( "Команды войса - /voicehelp", source )
end

addEventHandler( "onPlayerJoin", root, joinHandler )

local voiceCols = {}
local broadcoastTo = {}
local speakArea = 100
 
addEventHandler( "onPlayerVoiceStart", root,
    function()
        local voiceSource = source
        local sx, sy, sz = getElementPosition( voiceSource )
        voiceCols[voiceSource] = createColSphere( sx, sy, sz, speakArea )
        attachElements( voiceCols[voiceSource], voiceSource )
        broadcoastTo[voiceSource] = getElementsWithinColShape( voiceCols[voiceSource], "player" )
        setPlayerVoiceBroadcastTo( voiceSource, broadcoastTo[voiceSource] )
        addEventHandler( "onColshapeHit", voiceCols[voiceSource],
            function( element )
                if ( getElementType(element ) == "player" ) then
                    table.insert( broadcoastTo[voiceSource], element )
                    setPlayerVoiceBroadcastTo( voiceSource, broadcoastTo[voiceSource] )
                end
            end
         )
       
        addEventHandler( "onColshapeLeave", voiceCols[voiceSource],
            function( element )
                if ( getElementType(element ) == "player" ) then
                    for key, player in pairs( broadcoastTo[voiceSource] ) do
                        if ( element == player ) then
                            table.remove( broadcoastTo[voiceSource], key )
                            break
                        end
                    end
                    setPlayerVoiceBroadcastTo( voiceSource, broadcoastTo[voiceSource] )
                end
            end
         )
    end
 )      
 
addEventHandler( "onPlayerVoiceStop", root,
    function()
        if isElement( voiceCols[source] ) then
            destroyElement( voiceCols[source] )
        end
       
        if ( broadcoastTo[source] ) then
            table.remove( broadcoastTo, source )
        end
 
        setPlayerVoiceBroadcastTo( source )
    end
 )

function voiceHelp( thePlayer, command )
   outputChatBox( "Команды войса: /mychannel, /setchannel [id], /pmute [nickname], /punmute [nickname], /ismuted [nickname]", thePlayer )
end
addCommandHandler( "voicehelp", voiceHelp )

function getPlayerChannel( thePlayer, command )
	local channelid = exports.voice:getPlayerChannel( thePlayer )
	if type( channelid ) == 'number'
	then
		outputChatBox( "Установлен канал под номером "..tostring( channelid ), thePlayer )
	else
		outputChatBox( "Установить канал - /setchannel [id канала]", thePlayer )
	end
end
addCommandHandler( "mychannel", getPlayerChannel )

function setChannel( thePlayer, command, id )
	local channel = exports.voice:setPlayerChannel( thePlayer, id )
	if channel == true and getPlayerFromName( name ) ~= false
	then
		local channelid = exports.voice:getPlayerChannel( thePlayer )
		outputChatBox( "Установлен канал под номером "..tostring( channelid ), thePlayer )
	else
		outputChatBox( "/setchannel [id канала]", thePlayer )
	end
end
addCommandHandler( "setchannel", setChannel )