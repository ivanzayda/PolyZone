local function createCircleZone(center, radius, options)
    return CircleZone:Create(center, radius, options)
end

local function createBoxZone(center, length, width, options)
    return BoxZone:Create(center, length, width, options)
end

local function createComboZone(zones, options)
    return ComboZone:Create(zones, options)
end

local function createEntityZone(entity, options)
    return EntityZone:Create(entity, options)
end

exports('CircleZone:Create', createCircleZone)
exports('BoxZone:Create', createBoxZone)
exports('ComboZone:Create', createComboZone)
exports('EntityZone:Create', createEntityZone)



