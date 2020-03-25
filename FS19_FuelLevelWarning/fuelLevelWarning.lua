--
-- FillLevel Warning for LS 19
--
-- # Author:  	LS-Farmers.de
-- # date: 		24.03.2020
--

fuelLevelWarning = {}

FuelBeepSound5 = createSample("FuelBeepSound5")
local file = g_currentModDirectory.."sounds/FuelBeepSound5.wav"
loadSample(FuelBeepSound5, file, false)

local beepInActive = true

function fuelLevelWarning.prerequisitesPresent(specializations)
  return true
end

function fuelLevelWarning.registerEventListeners(vehicleType)
  SpecializationUtil.registerEventListener(vehicleType, "onUpdate", fuelLevelWarning)
  SpecializationUtil.registerEventListener(vehicleType, "onLoad", fuelLevelWarning)
end

function fuelLevelWarning:onLoad(savegame)
	self.attacheble = hasXMLProperty(self.xmlFile, "vehicle.attachable")
	self.brand = getXMLString (self.xmlFile, "vehicle.storeData.brand")
end

function fuelLevelWarning:onUpdate(dt)
	if self:getIsActive() and self:getIsEntered() and not self.attacheble and self.isClient and self:getIsMotorStarted() ~= false then

        local fuelFillType = self:getConsumerFillUnitIndex(FillType.DIESEL)
        local fillLevel = self:getFillUnitFillLevel(fuelFillType)
        local capacity = self:getFillUnitCapacity(fuelFillType)
        local fuelLevelPercentage = fillLevel / capacity * 100
        local warnFrequency = 0
        
        -- print ("DEBUG: Actual Fuel Level: " .. fillLevel)
        -- print ("DEBUG: Actual Fuel Capacity: " .. capacity)
        -- print ("DEBUG: Actual Fuel Level Percentage: " .. fuelLevelPercentage)
        -- print ("DEBUG: dt: " .. dt)
        -- print ("DEBUG: Count: " .. count)
	
        if fuelLevelPercentage <= 10 then
            if beepInActive == true then
              print ("DEBUG: Activate 5sec BEEP")
              playSample(FuelBeepSound5,0,1,0,0,0)
              beepInActive = false
            end
        end
    else
        if beepInActive == false then
            print ("DEBUG: Deactivate 5sec BEEP")
            stopSample(FuelBeepSound5,0,0)
            beepInActive = true
        end
  	end

end

