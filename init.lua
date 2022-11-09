local storage = minetest.get_mod_storage()

local function save(inv_list)
	local data = {}
	for _, item in ipairs(inv_list) do
		table.insert(data, item:to_string())
	end
	storage:set_string("main", minetest.serialize(data))
end

local pi = minetest.create_detached_inventory("pi", {
	on_put = function(inv)
		save(inv:get_list("main"))
	end,
	on_take = function(inv)
		save(inv:get_list("main"))
	end,
})
pi:set_size("main", 128)

local function load()
	local data = storage:get("main")
	if data then
		local inv_list = minetest.deserialize(data)
		pi:set_list("main", inv_list)
	end
end

load()

minetest.register_chatcommand("pi", {
	params = "",
	description = "shows the public inventory",
	func = function(name)
		minetest.show_formspec(name, "public_inventory:pi",
				"size[16,11;]"..
				"list[detached:pi;main;0,0;16,8;]"..
				"list[current_player;main;0,9;16,2;]" ..
				"listring[]")
		return true, ""
	end,
})

