-- CONFIG --
powiadomieniegora=true
powiadomieniechat=true
soundalert=true
devmode=true --tryp developerski
testnickname="Cap" -- nick osoby z ninjalisty do testow
-- CONFIG


 if not NINJAS then
	NINJAS = CreateFrame("Frame")
 end

 local frame = NINJAS

 frame:RegisterEvent("CHAT_MSG_SYSTEM")
 frame:RegisterEvent("RAID_INSTANCE_WELCOME")
 frame:RegisterEvent("RAID_ROSTER_UPDATE")
 frame:SetScript("OnEvent", function(self, event, ...)
		local raid={}
		if(event == "RAID_INSTANCE_WELCOME" or event == "RAID_ROSTER_UPDATE")
		then
			SendChatMessage(".listninja ", "SAY", DEFAULT_CHAT_FRAME.editBox.languageID);
		end	
		if(event == "CHAT_MSG_SYSTEM")
		then
			ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM",true)

		   local system_msg = select(1, ...)
		    if (system_msg:find("Warning! Player:.") ~= nil) then
				local zlodzieje = {}
				local uwagazlodziej=0
				komunikat = strsub (system_msg, 17)
				zlodzieje[1], zlodzieje[2] = komunikat:match("(%w+)(.+)")
				--print(zlodzieje[1])
				--print("Liczba czlonkow party "..GetNumRaidMembers())
				for i=1,GetNumRaidMembers() do
					local u="raid"..i 
					raid[u]=UnitName(u)
					--DEBUG--
					if(devmode==true)
					then
						raid[u]=testnickname
					end					
					--DEBUG--
					if(raid[u]==zlodzieje[1])
					then
						uwagazlodziej=zlodzieje[1]			
					else
						uwagazlodziej=0
					end

				end				
				if(uwagazlodziej~=0)
				then
				
				
				if(powiadomieniegora==true)then UIErrorsFrame:AddMessage("Ninjalooter in your party: " ..uwagazlodziej)	end
				if(powiadomieniechat==true)then SendChatMessage("sees ninjalooter in your party: " ..uwagazlodziej, "EMOTE", DEFAULT_CHAT_FRAME.editBox.languageID)		end			
				if(soundalert==true)then PlaySound("AuctionWindowOpen")	end
					uwagazlodziej=0			
				end
			else	
				ChatFrame_RemoveMessageEventFilter("CHAT_MSG_SYSTEM", true)						
		    end
	    end	
	end

 )