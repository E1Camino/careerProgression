return {
	run = function()
		fassert(rawget(_G, "new_mod"), "careerProgress must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("careerProgress", {
			mod_script       = "scripts/mods/careerProgress/careerProgress",
			mod_data         = "scripts/mods/careerProgress/careerProgress_data",
			mod_localization = "scripts/mods/careerProgress/careerProgress_localization"
		})
	end,
	packages = {
		"resource_packages/careerProgress/careerProgress"
	}
}
