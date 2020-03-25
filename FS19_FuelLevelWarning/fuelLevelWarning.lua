--
-- FillLevel Warning for LS 19
--
-- # Author:  	LS-Farmers.de
-- # date: 		24.03.2020
--

fuelLevelWarning = {}

AGCOBeepSound = createSample("AGCOBeep")
local file = g_currentModDirectory.."sounds/AGCO_beep.wav"
loadSample(AGCOBeepSound, file, false)

local count = 0

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
	if self:getIsActive() and not self.attacheble then
	local fuelFillType = self:getConsumerFillUnitIndex(FillType.DIESEL)
	local fillLevel = self:getFillUnitFillLevel(fuelFillType)
	local capacity = self:getFillUnitCapacity(fuelFillType)
	local fuelLevelPercentage = fillLevel / capacity * 100
	local warnFrequency = 0
	
	-- print ("DEBUG: Actual Fuel Level: " .. fillLevel)
	-- print ("DEBUG: Actual Fuel Capacity: " .. capacity)
    -- print ("DEBUG: Actual Fuel Level Percentage: " .. fuelLevelPercentage)
	-- print ("DEBUG: Count: " .. count)
	
		if fuelLevelPercentage <= 10 and self:getIsEntered() then
			
			if count == 0 then
				playSample(AGCOBeepSound ,1 ,1 ,1 ,0 ,0)
			end
			
			count = count + 1
			
			if fuelLevelPercentage > 5 then
				warnFrequency = 750
			elseif fuelLevelPercentage <= 5 and fuelLevelPercentage > 2 then
				warnFrequency = 250
			elseif  fuelLevelPercentage <= 2 then
				warnFrequency = 100
			end
			
			--print ("DEBUG: Frequency: " .. warnFrequency)
			
			if count > warnFrequency then
				count = 0
			end
			
		else
			count = 0
		end
	
  	end

end

