local SBvars = SandboxVars.EvolvingTraitsWorld;

local original_oneat_cigarettes = OnEat_Cigarettes;
function OnEat_Cigarettes(food, character, percent)
	--print("ETW Logger: detected smoking");
	local modData = character:getModData().EvolvingTraitsWorld.SmokeSystem; -- SmokingAddiction MinutesSinceLastSmoke
	local timeSinceLastSmoke = character:getTimeSinceLastSmoke() * 60;
	--print("ETW Logger: timeSinceLastSmoke: "..timeSinceLastSmoke);
	--print("ETW Logger: modData.MinutesSinceLastSmoke: "..modData.MinutesSinceLastSmoke);
	local stress = character:getStats():getStress(); -- stress is 0-1
	local panic = character:getStats():getPanic(); -- 0-100
	local addictionGain = SBvars.SmokingAddictionMultiplier * 1 * (1 + stress) * (1 + panic / 100) * 1000 / (math.max(timeSinceLastSmoke, modData.MinutesSinceLastSmoke) + 100);
	modData.SmokingAddiction = math.min(SBvars.SmokerCounter * 2, modData.SmokingAddiction + addictionGain);
	--print("ETW Logger: addictionGain: "..addictionGain);
	--print("ETW Logger: modData.SmokingAddiction: "..modData.SmokingAddiction);
	modData.MinutesSinceLastSmoke = 0;
	original_oneat_cigarettes(food, character, percent);
end