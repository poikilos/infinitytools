--[[
	InfinityTools
	Author: Vortexlabs (mrtux)
	Edited a bit by AndDT for minetest 0.4.6
	See See README.md for further information.
	Licencing info:
		Code: GPLv3
		Graphics: See README.md
]]--

-- Register nodes and tools

-- Infinity Block (used to make tools)
minetest.register_node("infinitytools:infinityblock", {
	description = "Infinity Block",
	tile_images = {"infinitytools_infinity_block.png"},
	is_ground_content = true,
	groups = {snappy=1,choppy=2,cracky=2},
})

-- Pickaxe
minetest.register_tool("infinitytools:pickaxe", {
	description = "Infinity Pickaxe",
	inventory_image = "infinitytools_pick.png",
	tool_capabilities = {
		max_drop_level=3,
		groupcaps={
			unbreakable={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			cracky={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
})

-- Shovel
minetest.register_tool("infinitytools:shovel", {
	description = "Infinity Shovel",
	inventory_image = "infinitytools_shovel.png",
	tool_capabilities = {
		max_drop_level=3,
		groupcaps={
			unbreakable={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			crumbly={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
})

-- Axe
minetest.register_tool("infinitytools:axe", {
	description = "Infinity Axe",
	inventory_image = "infinitytools_axe.png",
	tool_capabilities = {
		max_drop_level=3,
		groupcaps={
			unbreakable={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			fleshy = {times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			choppy={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
		},
		damage_groups = {fleshy=7},
	},
})

-- Sword
minetest.register_tool("infinitytools:sword", {
	description = "Infinity Sword",
	inventory_image = "infinitytools_sword.png",
	tool_capabilities = {
		max_drop_level=3,
		groupcaps={
			unbreakable={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			fleshy = {times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			choppy={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			snappy={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
		},
		damage_groups = {fleshy=10},
	},
})


-- Register crafting recipies

-- Infinity Block
minetest.register_craft({
	output = 'infinitytools:infinityblock',
	recipe = {
		{'default:mese', 'default:steel_ingot', 'default:mese'},
	}
})
-- Infinity Pickaxe
minetest.register_craft({
	output = 'infinitytools:pickaxe',
	recipe = {
		{'infinitytools:infinityblock', 'infinitytools:infinityblock', 'infinitytools:infinityblock'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

-- Infinity Shovel
minetest.register_craft({
	output = 'infinitytools:shovel',
	recipe = {
		{'', 'infinitytools:infinityblock', ''},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

-- Infinity Axe
minetest.register_craft({
	output = 'infinitytools:axe',
	recipe = {
		{'infinitytools:infinityblock', 'infinitytools:infinityblock', ''},
		{'infinitytools:infinityblock', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

-- Infinity Sword
minetest.register_craft({
	output = 'infinitytools:sword',
	recipe = {
		{'', 'infinitytools:infinityblock', ''},
		{'', 'infinitytools:infinityblock', ''},
		{'', 'group:stick', ''},
	}
})


-- Mod loaded message
print("[InfinityTools] Mod loaded!")
