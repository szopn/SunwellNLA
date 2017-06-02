--[[ 	Sunwell Ninja Looter Alert by Deadwood/szopn 	]]--

-- CONFIG --
-- true/false - enable/disable
addonnotification=true
addonemote=true
soundalert=true 
devmode=false
testnickname="Cap" -- example nickname from .listninja
-- CONFIG --

--------------------------------------------------------
-- don't edit below unless you know what you're doing --
--------------------------------------------------------
function ListNinjaFilter(self,event,msg)
  local badWords = {"ninja","looter"}
  local matchCount = 0;
  for _, word in ipairs(badWords) do
    if (string.match(msg, word)) then
      matchCount = matchCount + 1;
    end
  end
  if (matchCount > 1) then
    return true;
  else
    return false;
  end
end

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
			ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM",ListNinjaFilter)
			SendChatMessage(".listninja ", "SAY", DEFAULT_CHAT_FRAME.editBox.languageID);
		end	
		if(event == "CHAT_MSG_SYSTEM")
		then
		   local system_msg = select(1, ...)
		    if (system_msg:find("Warning! Player:.") ~= nil) then
				local robbers = {}
				local attentionrobbers=0
				sub_system_msg = strsub (system_msg, 17)
				robbers[1], robbers[2] = sub_system_msg:match("(%w+)(.+)")
				--print(robbers[1])
				--print("NumPartyMembers "..GetNumPartyMembers())
				if(GetNumPartyMembers() > 0) then
					for i=1,GetNumPartyMembers() do
						local u="party"..i 
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
				--print("NumRaidMembers "..GetNumRaidMembers())					
				elseif(GetNumRaidMembers() > 0) then				
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
				end
				
				if(attentionrobbers~=0)
				then
					if(addonnotification==true)then UIErrorsFrame:AddMessage("Ninjalooter in your party: " ..attentionrobbers)	end
					if(addonemote==true)then SendChatMessage("sees ninjalooter in your party: " ..attentionrobbers.." [NLA]", "EMOTE", DEFAULT_CHAT_FRAME.editBox.languageID) end			
					if(soundalert==true)then PlaySound("AuctionWindowOpen")	end
					attentionrobbers=0			
				end
			else	
				ChatFrame_RemoveMessageEventFilter("CHAT_MSG_SYSTEM",ListNinjaFilter)					
		    end
		
	    end	
	end

 )