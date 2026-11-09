local dap = require("dap")
local dapui = require("dapui")

-- Setup UI & Virtual Text
dapui.setup({
	layouts = {
		{
			elements = {
				{ id = "scopes", size = 0.35 },
				{ id = "breakpoints", size = 0.20 },
				{ id = "stacks", size = 0.25 },
				{ id = "watches", size = 0.20 },
			},
			position = "right",
			size = 60,
		},
		{
			elements = {
				{ id = "repl", size = 0.6 },
				{ id = "console", size = 0.4 },
			},
			position = "bottom",
			size = 10,
		},
	},
})
require("nvim-dap-virtual-text").setup({
	commented = true,
})

-- Automatically open/close dap-ui during debug sessions
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

-- Adapters for C/C++
dap.adapters["lldb-dap"] = {
	type = "executable",
	command = "lldb-dap",
	name = "lldb-dap",
}

dap.adapters.gdb = {
	type = "executable",
	command = "gdb",
	args = { "-i", "dap" },
}

-- Helper to pick or suggest executable
local function get_executable()
	local current_file = vim.fn.expand("%:t:r")
	local cwd = vim.fn.getcwd()
	local default_path = cwd .. "/" .. (current_file ~= "" and current_file or "a.out")

	if vim.fn.filereadable(default_path) == 0 then
		if vim.fn.filereadable(cwd .. "/a.out") == 1 then
			default_path = cwd .. "/a.out"
		elseif current_file ~= "" and vim.fn.filereadable(cwd .. "/build/" .. current_file) == 1 then
			default_path = cwd .. "/build/" .. current_file
		end
	end

	local path = vim.fn.input("Path to executable: ", default_path, "file")
	if path == "" then
		return dap.ABORT
	end
	return path
end

-- Configurations for C and C++
local c_configurations = {
	{
		name = "Launch with LLDB (lldb-dap)",
		type = "lldb-dap",
		request = "launch",
		program = get_executable,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = function()
			local args_str = vim.fn.input("Arguments (optional): ")
			if args_str == "" then
				return {}
			end
			return vim.split(args_str, " +")
		end,
		runInTerminal = false,
	},
	{
		name = "Launch with GDB",
		type = "gdb",
		request = "launch",
		program = get_executable,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = function()
			local args_str = vim.fn.input("Arguments (optional): ")
			if args_str == "" then
				return {}
			end
			return vim.split(args_str, " +")
		end,
	},
	{
		name = "Attach to process (lldb-dap)",
		type = "lldb-dap",
		request = "attach",
		pid = require("dap.utils").pick_process,
		cwd = "${workspaceFolder}",
	},
}

dap.configurations.c = c_configurations
dap.configurations.cpp = c_configurations

-- Breakpoint and Debugger Signs
vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticOk", linehl = "Visual", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticHint", linehl = "", numhl = "" })

-- Keymaps
local map = vim.keymap.set

-- Stepping & Execution
map("n", "<leader>dc", dap.continue, { desc = "Debug: Start / Continue" })
map("n", "<leader>do", dap.step_over, { desc = "Debug: Step Over" })
map("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })
map("n", "<leader>dO", dap.step_out, { desc = "Debug: Step Out" })
map("n", "<leader>dt", function()
	dap.terminate()
	dapui.close()
end, { desc = "Debug: Terminate" })

-- Breakpoints
map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
map("n", "<leader>dB", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Debug: Set Conditional Breakpoint" })
map("n", "<leader>lp", function()
	dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, { desc = "Debug: Set Log Point" })

-- UI & Inspection
map("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })
map("n", "<leader>dr", dap.repl.open, { desc = "Debug: Open REPL" })
map("n", "<leader>dl", dap.run_last, { desc = "Debug: Run Last" })
map({ "n", "v" }, "<leader>dh", function()
	require("dap.ui.widgets").hover()
end, { desc = "Debug: Hover Variable" })

-- Standard Function Keys (IDE parity)
map("n", "<F5>", dap.continue, { desc = "Debug: Continue" })
map("n", "<F9>", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
map("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
map("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
map("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
