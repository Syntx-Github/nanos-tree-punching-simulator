Package.Subscribe("Load", function()
    for i, spawns in pairs(Config.TreeSpawnPoints) do
        spawns.Tree = Prop(Vector(spawns.X, spawns.Y, spawns.Z),  Rotator(0, 0, 0),  "nanos-world::SM_Tree_Acacia_01", CollisionType.Normal, true, false, false)
        spawns.Tree:SetGravityEnabled(false)
        spawns.Tree:SetValue("TreeResource", 50)
        spawns.Tree:Subscribe("TakeDamage", function(self, damage, bone, type, from_direction, instigator, causer)
            spawns.Tree:SetValue("TreeResource", spawns.Tree:GetValue("TreeResource") - 10)
            if spawns.Tree:GetValue("TreeResource") < 0 then
                spawns.Tree:SetGravityEnabled(true)
                Timer.SetTimeout(function()
                    spawns.Tree:Destroy()
                    SetTreeRespawn(i)
                end, 5000)
            end
            if instigator:GetType() == "Player" and causer:GetType() == "Character" then
                Events.CallRemote("GivePlayerWood", instigator, 10)
            end
        end)
    end
end)

function SetTreeRespawn(index)
    for i, spawns in pairs(Config.TreeSpawnPoints) do
        if spawns.Tree:GetType() ~= "Prop" and i == index then
            Timer.SetTimeout(function()
                spawns.Tree = Prop(Vector(spawns.X, spawns.Y, spawns.Z),  Rotator(0, 0, 0),  "nanos-world::SM_Tree_Acacia_01", CollisionType.Normal, true, false, false)
                spawns.Tree:SetGravityEnabled(false)
                spawns.Tree:SetValue("TreeResource", 50)
                spawns.Tree:Subscribe("TakeDamage", function(self, damage, bone, type, from_direction, instigator, causer)
                spawns.Tree:SetValue("TreeResource", spawns.Tree:GetValue("TreeResource") - 10)
                if spawns.Tree:GetValue("TreeResource") < 0 then
                    spawns.Tree:SetGravityEnabled(true)
                    Timer.SetTimeout(function()
                        spawns.Tree:Destroy()
                        SetTreeRespawn(i)
                    end, 5000)
                end
                if instigator:GetType() == "Player" then
                    Events.CallRemote("GivePlayerWood", instigator, 10)
                end
            end)
            end, 5000)
        end
    end
end

