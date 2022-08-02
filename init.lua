local pi_file = minetest.get_worldpath() .. "/pi"

local pi = minetest.create_detached_inventory("pi", {
	on_put = function(inv, listname, index, stack, player) 
		local list = inv:get_list("main")
		if list then
			local output = io.open(pi_file, "w")
			local str = ""
			table.foreach(list,function(index) 
				str = str..list[index]:to_string()..","
			end
			)
			str = str:sub(1, #str - 1)
			output:write(str)
			io.close(output)
		end
	end,
	on_take = function(inv, listname, index, stack, player) 
		local list = inv:get_list("main")
		if list then
			local output = io.open(pi_file, "w")
			local str = ""
			table.foreach(list,function(index) 
				str = str..list[index]:to_string()..","
			end
			)
			str = str:sub(1, #str - 1)
			output:write(str)
			io.close(output)
		end
	end,
})
pi:set_size("main", 128)

local function load_pi()
	local input = io.open(pi_file, "r")
	if input then
		local str = input:read()
		if str then
			for item in str.gmatch(str, '([^,]+)') do
    				pi:add_item("main", item)
			end
		end
		io.close(input)
	end
end


load_pi()

minetest.register_chatcommand("pi", {
	params = "",
	description = "shows the public inventory",
	func = function(name, param)
		minetest.show_formspec(name, "public_inventory:pi",
				"size[16,11;]"..
				"list[detached:pi;main;0,0;16,8;]"..
				"list[current_player;main;0,9;16,2;]")
		return true, ""
	end,
})

