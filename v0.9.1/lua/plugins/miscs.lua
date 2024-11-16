return {
	--  "folke/neodev.nvim",
	{
		"folke/which-key.nvim", 
		tag = "v3.3.0" , 
		opts = { 
			spec = { { 
				"<BS>",
				desc = "Decrement Selection", 
				mode = "x" }, { 
					"<c-space>", 
					desc= "Increment Selection", 
		mode = { "x", "n" } }, }, },
	},
	--  { "folke/neoconf.nvim", cmd = "Neoconf" },
}
