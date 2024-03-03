local FindElement = ffi.cast("unsigned long(__thiscall*)(void*, const char*)", find_pattern("client.dll", "55 8B EC 53 8B 5D 08 56 57 8B F9 33 F6 39 77 28"))
local death_notice = FindElement(ffi.cast("unsigned long**", ffi.cast("uintptr_t", find_pattern("client.dll", "B9 ? ? ? ? E8 ? ? ? ? 8B 5D 08")) + 1)[0], "CCSGO_HudDeathNotice")
local clear_notice = ffi.cast("void(__thiscall*)(unsigned long)", find_pattern("client.dll", "55 8B EC 83 EC 0C 53 56 8B 71 58"))




local preserve_killfeed_box = menu.add_check_box("Preserve killfeed [  ]", "Misc/Misc", false, "Misc/Misc/Notice")


register_callback("paint", function()
	if not globals.is_in_game or not globals.is_connected or entitylist.get_local_player() == nil then
		return
	end

	if preserve_killfeed_box:get() == true then
		ffi.cast("float*", death_notice + 0x50)[0] = 999
	elseif preserve_killfeed_box:get() == false then
		ffi.cast("float*", death_notice + 0x50)[0] = 1.5
	end
end)

function clear_notices()
	clear_notice(death_notice - 20)
end

function unload()
	clear_notices()
	ffi.cast("float*", death_notice + 0x50)[0] = 1.5
end
menu.add_button("Reset death notice", "Misc/Misc/Notice", clear_notices)
register_callback("round_start", clear_notices)
register_callback("round_prestart", clear_notices)
register_callback("round_poststart", clear_notices)
register_callback("round_freeze_end", clear_notices)
register_callback("unload", unload)