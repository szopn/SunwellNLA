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
  for _, word in ipairs(badWords) 
  do
    if (string.match(msg, word)) 
	then
      matchCount = matchCount + 1;
    end
  end
  if (matchCount > 1) 
  then
    return true;
  else
    return false;
  end
end

local nrobbers = {}

if not NINJAS 
then
	NINJAS = CreateFrame("Frame")
end

local frame = NINJAS

frame:RegisterEvent("CHAT_MSG_SYSTEM")
--frame:RegisterEvent("RAID_INSTANCE_WELCOME")
--frame:RegisterEvent("RAID_ROSTER_UPDATE")
--frame:RegisterEvent("PARTY_MEMBERS_CHANGED")
--frame:RegisterEvent("PARTY_LOOT_METHOD_CHANGED")
--frame:RegisterEvent("PARTY_LEADER_CHANGED")
frame:SetScript("OnEvent", function(self, event, ...)
		local raidlist={}
		
		--if(event == "RAID_INSTANCE_WELCOME" or event == "RAID_ROSTER_UPDATE" or event == "PARTY_MEMBERS_CHANGED" or event == "PARTY_LOOT_METHOD_CHANGED" or event == "PARTY_LEADER_CHANGED")
		--then
		--	ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM",ListNinjaFilter)
		--	SendChatMessage(".listninja ", "SAY", DEFAULT_CHAT_FRAME.editBox.languageID);
		--end	
		
		if(event == "CHAT_MSG_SYSTEM")
		then
		   local system_msg = select(1, ...)
		    if (system_msg:find("Warning! Player:.") ~= nil) 
			then
				local robbers = {}
				local attentionrobbers=0
				local function hasnot_value (tab, val)
   				 for index, value in ipairs(tab) 
				 do
    				    if value == val 
						then
     				       return false
    				    end
 				 end
 				   return true
				end
				
				sub_system_msg = strsub (system_msg, 17)
				robbers[1], robbers[2] = sub_system_msg:match("(%w+)(.+)")
				--print(robbers[1])
				--print("NumPartyMembers "..GetNumPartyMembers())
				if(GetNumPartyMembers() > 0) 
				then
					for i=1,GetNumPartyMembers() 
					do
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
				elseif(GetNumRaidMembers() > 0) 
				then				
					for i=1,GetNumRaidMembers() 
					do
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
				else
					for k,v in pairs(nrobbers) 
					do 
						nrobbers[k]=nil 
					end
				end
				
				if(attentionrobbers~=0 and hasnot_value (nrobbers, attentionrobbers))
				then
					table.insert(nrobbers,robbers[1]);
					if(addonnotification==true)
					then 
						UIErrorsFrame:AddMessage("Ninjalooter in your party: " ..attentionrobbers)	
					end
					if(addonemote==true)
					then 
						SendChatMessage("sees ninjalooter in your party: " ..attentionrobbers.." [NLA]", "EMOTE", DEFAULT_CHAT_FRAME.editBox.languageID) 
					end			
					if(soundalert==true)
					then 
						PlaySound("AuctionWindowOpen")	
					end
					attentionrobbers=0
				end
			else
				ChatFrame_RemoveMessageEventFilter("CHAT_MSG_SYSTEM",ListNinjaFilter)			
		    end	
	    end	
	end

)

SLASH_NLA1 = '/nla';
local function handler(msg, editbox)
	if msg == 'help' 
	then
		print('NLA commands:');
		print('    /nla - Pokazuje sunwellowa liste (.listninja) wraz z ostrzeżeniem jesli w naszej grupie znajduje sie osoba z tej listy');
		print('    /nla reset - Usuwa z pamieciu nicku osob pojawionych sie w ostrzeżeniach ( w tej grupie )');		
	elseif msg =='reset' 
	then
		for k,v in pairs(nrobbers) 
		do 
			nrobbers[k]=nil 
		end
		print('Zresetowano')
	else
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_SYSTEM",ListNinjaFilter)	
		for k,v in pairs(nrobbers) 
		do 
			nrobbers[k]=nil 
		end
		SendChatMessage(".listninja ", "SAY", DEFAULT_CHAT_FRAME.editBox.languageID);		
	end
end
SlashCmdList["NLA"] = handler;