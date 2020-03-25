--
-- register
--
-- # Author: LS-Farmers.de 
-- # date: 24.03.2020
--

if g_specializationManager:getSpecializationByName("fuelLevelWarning") == nil then

  g_specializationManager:addSpecialization("fuelLevelWarning", "fuelLevelWarning", Utils.getFilename("fuelLevelWarning.lua", g_currentModDirectory), true, nil)

  for typeName, typeEntry in pairs(g_vehicleTypeManager:getVehicleTypes()) do
    if SpecializationUtil.hasSpecialization(Drivable, typeEntry.specializations) and not SpecializationUtil.hasSpecialization(Locomotive, typeEntry.specializations) then
      g_vehicleTypeManager:addSpecialization(typeName, "fuelLevelWarning")
    end
  end
end