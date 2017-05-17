-- CONFIG --
-- true/false - enable/disable
addonnotification=true
addonemote=true
soundalert=true 
devmode=false
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
			--ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM",true) --disable sunwell notification
		   local system_msg = select(1, ...)
		    if (system_msg:find("Warning! Player:.") ~= nil) then
				local robbers = {}
				local attentionrobbers=0
				sub_system_msg = strsub (system_msg, 17)
				robbers[1], robbers[2] = sub_system_msg:match("(%w+)(.+)")
				--print(robbers[1])
				--print("NumRaidMembers "..GetNumRaidMembers())
				for i=1,GetNumRaidMembers() do
					local u="raid"..i 
					raidlist[u]=UnitName(u)
					--DEBUG START--
					if(devmode==true)
					then
						raidlist[u]=testnickname
					end					
					--DEBUG END----
					if(raidlist[u]==robbers[1])
					then
						attentionrobbers=robbers[1]			
					else
						attentionrobbers=0
					end
				end				
				if(attentionrobbers~=0)
				then
					if(addonnotification==true)then UIErrorsFrame:AddMessage("Ninjalooter in your party: " ..attentionrobbers)	end
					if(addonemote==true)then SendChatMessage("sees ninjalooter in your party: " ..attentionrobbers, "EMOTE", DEFAULT_CHAT_FRAME.editBox.languageID) end			
					if(soundalert==true)then PlaySound("AuctionWindowOpen")	end
					attentionrobbers=0			
				end
			else	
				--ChatFrame_RemoveMessageEventFilter("CHAT_MSG_SYSTEM", true)	-- enable sunwell notification					
		    end
	    end	
	end

 )