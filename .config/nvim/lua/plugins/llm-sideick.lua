return {
	"default-anton/llm-sidekick.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("llm-sidekick").setup({
			-- Model aliases configuration
			aliases = {
				pro = "gemini-2.0-pro",
				flash = "gemini-2.0-flash",
				sonnet = "claude-3-5-sonnet-latest",
				bedrock_sonnet = "anthropic.claude-3-7-sonnet",
				deepseek = "deepseek-chat",
				gpt4o = "gpt-4o-2024-11-20",
				high_o3_mini = "o3-mini-high",
				low_o3_mini = "o3-mini-low",
				medium_o3_mini = "o3-mini-medium",
			},
			yolo_mode = {
				file_operations = false, -- Automatically accept file operations
				terminal_commands = false, -- Automatically accept terminal commands
			},
			safe_terminal_commands = {}, -- List of terminal commands to automatically accept
			guidelines = "", -- Global guidelines that will be added to every chat
			default = "sonnet",
		})
	end,
}
