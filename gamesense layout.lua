local fraction = 1 / 255;

function color_t.rgba(r, g, b, a)
    return color_t.new(r * fraction, g * fraction, b * fraction, a * fraction);
end

local function on_paint()
    if not menu.is_visible() then
        return
    end

    local menu_rect = menu.get_menu_rect();
    local menu_from = vec2_t.new(menu_rect.x, menu_rect.y);
    local menu_to = vec2_t.new(menu_rect.z, menu_rect.w);

    render.rect_filled(menu_from, menu_to, color_t.rgba(12, 12, 12, 255));

    do
        local colors = { 12, 60, 40, 40, 40, 60, 12 };

        for i = #colors, 1, -1 do
            local scale = colors[i];
            render.rect(vec2_t.new(menu_from.x - ((#colors + 1) - i), menu_from.y - ((#colors + 1) - i) - 4), vec2_t.new(menu_to.x + ((#colors + 1) - i), menu_to.y + ((#colors + 1) - i)), color_t.rgba(scale, scale, scale, 255));
        end
    end

    render.rect_filled(vec2_t.new(menu_from.x, menu_from.y - -1), vec2_t.new(menu_to.x, menu_from.y - 4), color_t.rgba(12, 12, 12, 255));
    render.rect_filled(vec2_t.new(menu_from.x, menu_from.y - 1), vec2_t.new(menu_to.x, menu_from.y - 4), color_t.rgba(6, 6, 6, 255));

    local gradient_start = vec2_t.new(menu_from.x, menu_from.y - 4);
    local gradient_size = vec2_t.new((menu_to.x - menu_from.x) / 2, 1);

    render.rect_filled_fade(gradient_start, vec2_t.new(gradient_start.x + gradient_size.x, gradient_start.y + gradient_size.y), color_t.rgba(55, 177, 218, 255), color_t.rgba(204, 70, 205, 255), color_t.rgba(204, 70, 205, 255), color_t.rgba(55, 177, 218, 255));
    render.rect_filled_fade(vec2_t.new(gradient_start.x, gradient_start.y + 1) , vec2_t.new(gradient_start.x + gradient_size.x, gradient_start.y + gradient_size.y + 1), color_t.rgba(55, 177, 218, 127), color_t.rgba(204, 70, 205, 127), color_t.rgba(204, 70, 205, 127), color_t.rgba(55, 177, 218, 127));

    gradient_start = vec2_t.new(gradient_start.x + gradient_size.x, gradient_start.y);
    render.rect_filled_fade(gradient_start, vec2_t.new(gradient_start.x + gradient_size.x, gradient_start.y + gradient_size.y), color_t.rgba(204, 70, 205, 255), color_t.rgba(204, 227, 53, 255), color_t.rgba(204, 227, 53, 255), color_t.rgba(204, 70, 205, 255));
    render.rect_filled_fade(vec2_t.new(gradient_start.x, gradient_start.y + 1) , vec2_t.new(gradient_start.x + gradient_size.x, gradient_start.y + gradient_size.y + 1), color_t.rgba(204, 70, 205, 127), color_t.rgba(204, 227, 53, 127), color_t.rgba(204, 227, 53, 127), color_t.rgba(204, 70, 205, 127));
end

register_callback("paint", on_paint)
