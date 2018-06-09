-- Created: 16:03 09.07.2018
local Liker = {}

Liker.IsToggled = Menu.AddOptionBool({"Kiyoshi","Liker"},"Activate", false)
Liker.sleepers = {}

local NPCsTable = {}
function Liker.OnUpdate()
	if not Menu.IsEnabled(Liker.IsToggled) or not Liker.SleepCheck(0.5, "updaterate") then return end
		
		NPCsTable = NPCs.GetAll()
		NPCsTableLenght = tablelength(NPCsTable)
		
		local AncientCount = 0
		for i=1, NPCsTableLenght do
		
			if NPC.IsAncient(NPCsTable[i]) then 
				--Log.Write(Entity.GetHealth(NPCsTable[i]))
				if Entity.GetHealth(NPCsTable[i]) < 1 then
						Liker.Message1()
				end
			end
		
		end
		--Log.Write("Liker Script by Kiyoshi")
		--Log.Write(dump(NPCsTable))
		--Log.Write(NPCsTableLenght)
		--Liker.Sleep(10,"updaterate")
end


function Liker.Message1()

	Engine.ExecuteCommand("say Всем спасибо за игру. Киньте лайк пожалуйста и я вам")
end

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end


function Liker.SleepCheck(delay, id)
	if not Liker.sleepers[id] or(os.clock() - Liker.sleepers[id]) > delay then
		return true
	end
	return false
end

function Liker.Sleep(delay, id)
	if not Liker.sleepers[id] or Liker.sleepers[id] < os.clock() + delay then
		Liker.sleepers[id] = os.clock() + delay
	end
end

return Liker
