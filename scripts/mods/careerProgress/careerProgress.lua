local mod = get_mod("careerProgress")

-- this turned out to be very similar to the mod:hook_safe(AchievementTemplateHelper, "check_level_list_difficulty", mod.check_level_list_difficulty)
-- level_list is now a level_id
-- return value is the highest difficulty index for given level and career
mod.check_level_list_difficulty = function(self, statistics_db, stats_id, level_id, difficulty_rank, career)
	local difficulty_manager = Managers.state.difficulty
	local difficulty_index = 0
	if not difficulty_manager then
		return difficulty_index
	end

	local s = statistics_db["statistics"][stats_id]["completed_career_levels"][career["name"]]
	local difficulties = difficulty_manager:get_level_difficulties(level_id)
	if career then
		for i, r in ipairs(difficulties) do
			local wins = s[level_id][r]["persistent_value"]
			if wins > 0 then
				difficulty_index = i
			end
		end
	else
		difficulty_index = LevelUnlockUtils.completed_level_difficulty_index(statistics_db, stats_id, level_id)
	end
	return difficulty_index
end

mod.getCareer = function()
	-- get career id in order to check difficulty against it
	local player_manager = Managers.player
	--		self._achievement_manager:setup_achievement_data()
	local player = player_manager:local_player()
	local profile_index = player:profile_index()
	local profile = SPProfiles[profile_index]
	local careers = profile.careers
	local career_index = player:career_index()
	local career = careers[career_index]
	return career
end

mod.getDifficultyIndex = function(self, statistics_db, stats_id, level_key, career)
	-- get the difficulty index dependent on current selected career
	local completed_difficulty_index = 0
	-- get all difficulties for this level
	local difficulty_manager = Managers.state.difficulty

	if not difficulty_manager then
		completed_difficulty_index = LevelUnlockUtils.completed_level_difficulty_index(statistics_db, stats_id, level_key)
	else
		local difficulties = difficulty_manager:get_level_difficulties(level_key)
		if career then
			local completed = mod:check_level_list_difficulty(statistics_db, stats_id, level_key, r, career)
			if completed then
				completed_difficulty_index = completed
			end
		else
			completed_difficulty_index = LevelUnlockUtils.completed_level_difficulty_index(statistics_db, stats_id, level_key)
		end
	end
	return completed_difficulty_index
end

mod:hook_origin(
	LevelUnlockUtils,
	"completed_level_difficulty_index",
	function(statistics_db, player_stats_id, level_key)
		local career = mod:getCareer()
		return mod:getDifficultyIndex(statistics_db, player_stats_id, level_key, career)
	end
)
