print("Lua Version: " .. _VERSION)
local fontSize = 20
local font = render.setup_font("C:/Windows/Fonts/verdana.ttf", fontSize, 0)

local colorDic = 
{
    ["r"] = {1, 0, 0, 1},
    ["g"] = {0, 1, 0, 1},
    ["b"] = {0, 0, 1, 1},
    ["m"] = {0, 0.5647058823529412, 1, 1}
}

function strWidth(str, font)

    local sum = 0
    local isColor = false
    for j = 1, #str do
        local ch = str:sub(j, j)

        if ch == "%" then
            isColor = true
        elseif isColor then
            isColor = false
        else
            local size = render.calc_text_size(ch, font, fontSize)
            sum = sum + size.x
        end
    end

    return sum
end

function strHeight(font)
    local size = render.calc_text_size("LUL", font, fontSize)
    return size.y
end

function drawString(font, str, pos, color)

    local startPos = pos
    local isColor = false    
    for j = 1, #str do
        local ch = str:sub(j, j)

        if ch == "%" then
            isColor = true
        elseif isColor then
            local tuple = colorDic[ch]

            if not (tuple == nil) then
                color.r = tuple[1]
                color.g = tuple[2]
                color.b = tuple[3]
                color.a = tuple[4]
            else
                color.r = 1
                color.g = 1
                color.b = 1
                color.a = 1
            end

            isColor = false

        else
            render.text(ch, font, startPos, color)
            startPos.x = startPos.x + strWidth(ch, font)
        end
    end
end

function drawArray(font, arr, leftAlign)

    local spacing = 4

    local x = spacing
    local y = spacing
    local scWidth = render.screen_size().x
    local scHeight = render.screen_size().y
    
    if not leftAlign then
        x = scWidth - spacing
    end

    for i = 1, #arr do

        local pos = vec2_t.new(x, y)

        if not leftAlign then
            pos.x = scWidth - spacing - strWidth(arr[i], font)
        end

        local color = color_t.new(1, 1, 1, 1)

        drawString(font, arr[i], pos, color)

        y = y + strHeight(font)

    end
end

register_callback("paint", function()
    info = {
        "Nixware Scripts By IzumiiKonata/ImXianyu",
        "UserName: %m" .. get_user_name()
    }

    drawArray(font, info, false)


end)