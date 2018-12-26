local mod = get_mod("careerProgress")

-- Everything here is optional. You can remove unused parts.
return {
	name = mod:localize("mod_name"), -- Readable mod name
	description = mod:localize("mod_description"), -- Mod description
	is_togglable = true, -- If the mod can be enabled/disabled
	is_mutator = false, -- If the mod is mutator
	mutator_settings = {} -- Extra settings, if it's mutator
}
