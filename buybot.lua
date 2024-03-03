
local clock = os.clock
local timer = clock()

register_callback("round_start", function()
    is_round_started = true

    timer = clock()
end)

register_callback("round_prestart", function()
    is_round_started = true

    timer = clock()
end)




register_callback("create_move", function()

	if is_round_started and clock() - timer > 1 then
		buy_bot()
		is_round_started = false
	end

end)

is_round_started = false

pistols_list = {
	["0"] = "",
	["1"] = "buy glock; buy hkp2000; buy usp_silencer;",
	["2"] = "buy elite;",
	["3"] = "buy p250;",
	["4"] = "buy tec9; buy fiveseven;",
	["5"] = "buy deagle; buy revolver;",
}

pistols_name_list = {

	"None",
	"Glock-18/HKP2000/USP-S",
	"Dual Berretas",
	"P250",
	"Tec-9/Five7",
	"Deagle/Revolver"

}

weapons_list = {
	["0"] = "",
	["1"] = "buy ssg08;",
	["2"] = "buy awp;",
	["3"] = "buy scar20; buy g3sg1;",
	["4"] = "buy galilar; buy famas;",
	["5"] = "buy ak47; buy m4a1; buy m4a1_silencer;",
	["6"] = "buy sg556; buy aug;",
	["7"] = "buy nova;",
	["8"] = "buy xm1014;",
	["9"] = "buy mag7;",
	["10"] = "buy m249;",
	["11"] = "buy negev;",
	["12"] = "buy mac10; buy mp9;",
	["13"] = "buy mp7;",
	["14"] = "buy ump45;",
	["15"] = "buy p90;",
	["16"] = "buy bizon;"
}

weapons_name_list = {

	"None",
	"SSG08",
	"AWP",
	"Scar20/G3SG1",
	"GalilAR/Famas",
	"AK-47/M4A1",
	"AUG/SG556",
	"Nova",
	"XM1014",
	"Mag-7",
	"M249",
	"Negev",
	"Mac-10/MP9",
	"MP7",
	"UMP-45",
	"P90",
	"Bizon"

}

other_list = {
	["0"] = "buy vesthelm;",
	["1"] = "buy hegrenade;",
	["2"] = "buy molotov; buy incgrenade;",
	["3"] = "buy smokegrenade;",
	["4"] = "buy taser;",
	["5"] = "buy defuser;"
}

other_name_list = {

	"Armor",
	"HE",
	"Molotov/Incgrenade",
	"Smoke",
	"Taser",
	"Defuser"

}

local buy_pistol = menu.add_combo_box("Buybot Pistol", "Misc/Misc", pistols_name_list, 0)
local buy_weapon = menu.add_combo_box("Buybot Weapon", "Misc/Misc", weapons_name_list, 0)
local buy_other = menu.add_multi_combo_box("Buybot Other", "Misc/Misc", other_name_list, { 0, 0, 0, 0, 0, 0 })



function buy_bot()

	local pistol = pistols_list[tostring(buy_pistol:get())]
	local weapon = weapons_list[tostring(buy_weapon:get())]
	local other  = ""

	for i = 0, 5 do
		if buy_other:get(i) then
			other = other .. other_list[tostring(i)]
		end
	end

	print("Pistol: " .. pistol)
	print("Weapon: " .. weapon)
	print("Other: " .. other)

	local combined = ""
	combined = pistol .. weapon .. other


	engine.execute_client_cmd("echo pistol bought")
	engine.execute_client_cmd(pistol)
	engine.execute_client_cmd("echo weapon bought")

	engine.execute_client_cmd(weapon)
	engine.execute_client_cmd("echo other bought")

	engine.execute_client_cmd(other)

end

