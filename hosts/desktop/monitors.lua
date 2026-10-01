hl.monitor({
	output = "DP-1",
	mode = "3840x2160@120",
	position = "1080x0",
	scale = 1.5,
	vrr = 2,
	bitdepth = 10,
	cm = "auto",
})
hl.monitor({
	output = "DP-2",
	mode = "1920x1080@60",
	position = "0x0",
	scale = 1.0,
	cm = "auto",
	bitdepth = 8,
	transform = 3,
})
