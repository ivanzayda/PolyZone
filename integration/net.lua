local _zones = {}


local function triggerEvent(id, eventToTriggerOnEnter, eventToTriggerOnExit)
    return function(isIn)
        if isIn then
            TriggerServerEvent(eventToTriggerOnEnter, id)
        else
            TriggerServerEvent(eventToTriggerOnExit, id)
        end
    end
end

local function registerEvent(event, callback)
    local eventName = eventPrefix..event
    RegisterNetEvent(eventName, callback)
end

local function createCircleZone(id, center, radius, options, eventToTriggerOnEnter, eventToTriggerOnExit)
    if(_zones[id]) then
        return print(('ENTITY %s IS ALREADY REGISTERED'):format(id))
    end
    local zone =  CircleZone:Create(center, radius, options)
    _zones[id] = id
    zone:onPointInOut(triggerEvent(id, eventToTriggerOnEnter, eventToTriggerOnExit))
end

local function createBoxZone(id, center, length, width, options, eventToTriggerOnEnter, eventToTriggerOnExit)
    if(_zones[id]) then
        return print(('ENTITY %s IS ALREADY REGISTERED'):format(id))
    end
    local zone =  BoxZone:Create(center, length, width, options)
    _zones[id] = id
    zone:onPointInOut(triggerEvent(id, eventToTriggerOnEnter, eventToTriggerOnExit))
end

local function createComboZone(id, zones, options, eventToTriggerOnEnter, eventToTriggerOnExit)
    if(zones[id]) then
        return print(('ENTITY %s IS ALREADY REGISTERED'):format(id))
    end
    local zone = ComboZone:Create(zones, options)
    _zones[id] = id
    zone:onPointInOut(triggerEvent(id, eventToTriggerOnEnter, eventToTriggerOnExit))
end

local function createEntityZone(id, netId, options, eventToTriggerOnEnter, eventToTriggerOnExit, eventToTriggerOnDamage)
    if(_zones[id]) then
        return print(('ENTITY %s IS ALREADY REGISTERED'):format(id))
    end
    local entity = NetworkGetEntityFromNetworkId(netId)
    if entity <= 0 then
        return
    end
    local zone = EntityZone:Create(entity, options)
    _zones[id] = id
    zone:onPointInOut(triggerEvent(id, eventToTriggerOnEnter, eventToTriggerOnExit))
    if(eventToTriggerOnDamage) then
        zone:onEntityDamaged(function(victimDied, attacker, weaponHash, isMelee)
            TriggerServerEvent(eventToTriggerOnDamage, id, victimDied, NetworkGetNetworkIdFromEntity(attacker), weaponHash, isMelee)
        end)
    end
end

registerEvent('CircleZone:Create', createCircleZone)
registerEvent('BoxZone:Create', createBoxZone)
registerEvent('ComboZone:Create', createComboZone)
registerEvent('EntityZone:Create', createEntityZone)



