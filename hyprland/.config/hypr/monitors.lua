-- Main monitor
hl.monitor({
	output = "DP-3",
	mode = "2560x1440@144",
	position = "auto",
	scale = 1,
})

-- Secondary monitor
hl.monitor({
	output = "DP-2",
	mode = "1920x1200@60",
	position = "auto",
	scale = 1,
})

-- Keep the same workspace layout as the old Omarchy 3 config.
for _, workspace in ipairs({ "1", "2", "3" }) do
	hl.workspace_rule({
		workspace = workspace,
		monitor = "DP-3",
		default = workspace == "1",
	})
end

hl.workspace_rule({
	workspace = "4",
	monitor = "DP-2",
	default = true,
})
