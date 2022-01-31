local buttons_prompt = GetRandomIntInRange(0, 0xffffff)
local active = false

local keys = { ['G'] = 0x760A9C6F, ['S'] = 0xD27782E3, ['W'] = 0x8FD015D8, ['H'] = 0x24978A28, ['G'] = 0x5415BE48, ["ENTER"] = 0xC7B5340A, ['E'] = 0xDFF812F9,["BACKSPACE"] = 0x156F7119 }
local WaterTypes = {
    [1] =  {["name"] = "Sea of Coronado",       ["waterhash"] = -247856387, ["watertype"] = "lake"},
    [2] =  {["name"] = "San Luis River",        ["waterhash"] = -1504425495, ["watertype"] = "river"},
    [3] =  {["name"] = "Lake Don Julio",        ["waterhash"] = -1369817450, ["watertype"] = "lake"},
    [4] =  {["name"] = "Flat Iron Lake",        ["waterhash"] = -1356490953, ["watertype"] = "lake"},
    [5] =  {["name"] = "Upper Montana River",   ["waterhash"] = -1781130443, ["watertype"] = "river"},
    [6] =  {["name"] = "Owanjila",              ["waterhash"] = -1300497193, ["watertype"] = "river"},
    [7] =  {["name"] = "HawkEye Creek",         ["waterhash"] = -1276586360, ["watertype"] = "river"},
    [8] =  {["name"] = "Little Creek River",    ["waterhash"] = -1410384421, ["watertype"] = "river"},
    [9] =  {["name"] = "Dakota River",          ["waterhash"] = 370072007, ["watertype"] = "river"},
    [10] =  {["name"] = "Beartooth Beck",       ["waterhash"] = 650214731, ["watertype"] = "river"},
    [11] =  {["name"] = "Lake Isabella",        ["waterhash"] = 592454541, ["watertype"] = "lake"},
    [12] =  {["name"] = "Cattail Pond",         ["waterhash"] = -804804953, ["watertype"] = "lake"},
    [13] =  {["name"] = "Deadboot Creek",       ["waterhash"] = 1245451421, ["watertype"] = "river"},
    [14] =  {["name"] = "Spider Gorge",         ["waterhash"] = -218679770, ["watertype"] = "river"},
    [15] =  {["name"] = "O'Creagh's Run",       ["waterhash"] = -1817904483, ["watertype"] = "lake"},
    [16] =  {["name"] = "Moonstone Pond",       ["waterhash"] = -811730579, ["watertype"] = "lake"},
    [17] =  {["name"] = "Roanoke Valley",       ["waterhash"] = -1229593481, ["watertype"] = "river"},
    [18] =  {["name"] = "Elysian Pool",         ["waterhash"] = -105598602, ["watertype"] = "lake"},
    [19] =  {["name"] = "Heartland Overflow",   ["waterhash"] = 1755369577, ["watertype"] = "swamp"},
    [20] =  {["name"] = "Lagras",               ["waterhash"] = -557290573, ["watertype"] = "swamp"},
    [21] =  {["name"] = "Lannahechee River",    ["waterhash"] = -2040708515, ["watertype"] = "river"},
    [22] =  {["name"] = "Dakota River",         ["waterhash"] = 370072007, ["watertype"] = "river"},
    [23] =  {["name"] = "Random1",              ["waterhash"] = 231313522, ["watertype"] = "river"},
    [24] =  {["name"] = "Random2",              ["waterhash"] = 2005774838, ["watertype"] = "river"},
    [25] =  {["name"] = "Random3",              ["waterhash"] = -1287619521, ["watertype"] = "river"},
    [26] =  {["name"] = "Random4",              ["waterhash"] = -1308233316, ["watertype"] = "river"},
    [27] =  {["name"] = "Random5",              ["waterhash"] = -196675805, ["watertype"] = "river"},
}

--menu

Citizen.CreateThread(function()
   prompts()
    while true do
       local sun = 500
        local coords = GetEntityCoords(PlayerPedId())
        local Water = Citizen.InvokeNative(0x5BA7A68A346A5A91,coords.x+3, coords.y+3, coords.z)
        local playerPed = PlayerPedId()
            for k,v in pairs(WaterTypes) do 
            if Water == WaterTypes[k]["waterhash"]  then
               if IsPedOnFoot(PlayerPedId()) then
                    if IsEntityInWater(PlayerPedId()) then
                      sun = 4     
                        if active == false then
                            local label = CreateVarString(10, 'LITERAL_STRING', "Water")
                            PromptSetActiveGroupThisFrame(buttons_prompt, label)
                        end
                        if Citizen.InvokeNative(0xC92AC953F0A982AE,washbutton) then
                            StartWash("amb_misc@world_human_wash_face_bucket@ground@male_a@idle_d", "idle_l")
                        end
                        if Citizen.InvokeNative(0xC92AC953F0A982AE,drinkbutton) then
                        TriggerEvent("drp:rio")
                        Citizen.Wait(17000)
                       TriggerEvent("vorpmetabolism:changeValue", "Thirst", 75)
                        PlaySoundFrontend("Core_Fill_Up", "Consumption_Sounds", true, 0)

                    end
                end
                
            end
          end
      end
   Citizen.Wait(sun)          
   end
end)

function prompts()
    Citizen.CreateThread(function()
    local str = "Waschen"
    washbutton = PromptRegisterBegin()
    PromptSetControlAction(washbutton, 0x760A9C6F)
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(washbutton, str)
    PromptSetEnabled(washbutton, 1)
    PromptSetVisible(washbutton, 1)
    PromptSetStandardMode(washbutton,1)
    PromptSetGroup(washbutton, buttons_prompt)
    Citizen.InvokeNative(0xC5F428EE08FA7F2C,washbutton,true)
    PromptRegisterEnd(washbutton)
    end)

    Citizen.CreateThread(function()
    local str = "Trinken"
    drinkbutton = PromptRegisterBegin()
    PromptSetControlAction(drinkbutton, 0xC7B5340A)
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(drinkbutton, str)
    PromptSetEnabled(drinkbutton, 1)
    PromptSetVisible(drinkbutton, 1)
    PromptSetStandardMode(drinkbutton,1)
    PromptSetGroup(drinkbutton, buttons_prompt)
    Citizen.InvokeNative(0xC5F428EE08FA7F2C,drinkbutton,true)
    PromptRegisterEnd(drinkbutton)
    end) 
end


AddEventHandler('drp:rio', function()
    local _source = source
            if rio ~= 0 then
                SetEntityAsMissionEntity(rio)
                DeleteObject(nativerioprop)
                rio = 0
                end
                local playerPed = PlayerPedId()
                Citizen.Wait(0)
                ClearPedTasksImmediately(PlayerPedId())
                RequestAnimDict('amb_rest_drunk@world_human_bucket_drink@ground@male_a@idle_b')
                while not HasAnimDictLoaded('amb_rest_drunk@world_human_bucket_drink@ground@male_a@idle_b') do
                    Citizen.Wait(100)
                end
                TaskPlayAnim(PlayerPedId(), 'amb_rest_drunk@world_human_bucket_drink@ground@male_a@idle_b', 'idle_e', 1.0, -1.0, 999999999, 1, 0, true, 0, false, 0, false)
                Citizen.Wait(17000)
                ClearPedTasks(PlayerPedId())
end)



StartWash = function(dic, anim)
    LoadAnim(dic)
    TaskPlayAnim(PlayerPedId(), dic, anim, 1.0, 8.0, 5000, 0, 0.0, false, false, false)
    Citizen.Wait(5000)
    ClearPedTasks(PlayerPedId())
    Citizen.InvokeNative(0x6585D955A68452A5, PlayerPedId())
    Citizen.InvokeNative(0x9C720776DAA43E7E, PlayerPedId())
    Citizen.InvokeNative(0x8FE22675A5A45817, PlayerPedId())
end

LoadAnim = function(dic)
    RequestAnimDict(dic)

    while not (HasAnimDictLoaded(dic)) do
        Citizen.Wait(0)
    end
end
