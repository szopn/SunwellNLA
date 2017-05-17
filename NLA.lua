-- CONFIG --
-- true/false - enable/disable
addonnotification=true
addonemote=true
soundalert=true 
testnickname="Cap" -- example nickname from .listninja
-- CONFIG --

-- don't edit below unless you know what you're doing --
 if not NINJAS then
	NINJAS = CreateFrame("Frame")
 end

 local frame = NINJAS

 frame:RegisterEvent("CHAT_MSG_SYSTEM")
 frame:RegisterEvent("RAID_INSTANCE_WELCOME")
 frame:RegisterEvent("RAID_ROSTER_UPDATE")
 frame:SetScript("OnEvent", function(self, event, ...)
		local raidlist={}
		if(event == "RAID_INSTANCE_WELCOME" or event == "RAID_ROSTER_UPDATE")
		then
			SendChatMessage(".listninja ", "SAY", DEFAULT_CHAT_FRAME.editBox.languageID);
		end	
		if(event == "CHAT_MSG_SYSTEM")
		then

		   local system_msg = select(1, ...)
		    if (system_msg:find("Warning! Player:.") ~= nil) then
				local uwagazlodziej=0
				for i=1,GetNumRaidMembers() do
					local u="raid"..i 
					if(devmode==true)
					then
					end					
					then
					else
					end

				end				
				then
				end
			else	
		    end
	    end	
	end

 )