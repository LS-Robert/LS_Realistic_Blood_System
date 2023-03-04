ESX = exports["es_extended"]:getSharedObject()

local Blood = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local player = GetPlayerPed(-1)
        local playerHealth = GetEntityHealth(player)
        if playerHealth < Config.playerHealthBloodOn then
            Blood = true
            Wait(Config.TimeBlood)
            Blood = false
            Wait(Config.TimeBlood)
        end
        if playerHealth > Config.playerHealthBloodOff then
            Blood = false
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        if Blood then

            local particleDictionary = Config.particleDictionary
            local particleName = Config.particleName

            RequestNamedPtfxAsset(particleDictionary)

            while not HasNamedPtfxAssetLoaded(particleDictionary) do
                Citizen.Wait(0)
            end
            
            bone = GetPedBoneIndex(GetPlayerPed(-1), 18905)

            SetPtfxAssetNextCall(particleDictionary)
            Blood1 =  StartNetworkedParticleFxNonLoopedOnPedBone(particleName, PlayerPedId(), 0.05, -0.0000, 0.0000, 0.0, 180.0, 0.0, 57005, 0.2, false, false, false)
            SetPtfxAssetNextCall(particleDictionary)
            Blood2 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName, PlayerPedId(), 0.15, -0.0000, 0.0000, 0.0, 180.0, 0.0, 18905, 0.2, false, false, false)
        end
    end
end)
