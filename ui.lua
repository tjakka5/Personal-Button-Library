local ui = {}
ui.list = {}
ui.defaultFont = love.graphics.getFont()

function ui.newButton(info)
   local info = info or {}
   info.fg = info.fg or {}
   info.fg.normal = info.fg.normal or {}
   info.fg.hover = info.fg.hover or {}
   info.fg.click = info.fg.click or {}

   info.bg = info.bg or {normal = {}, hover = {}, click = {}}
   info.bg.normal = info.bg.normal or {}
   info.bg.hover = info.bg.hover or {}
   info.bg.click = info.bg.click or {}

   info.flags = info.flags or {}
   info.flags.buttons = info.flags.buttons or {}

   local self = {}

   self.text = info.text or ""
   self.pos = Vector.new(info.x or 0, info.y or 0)
   self.dimensions = Vector.new(info.width or 100, info.height or 35)

   self.state = "normal"
   self.wasHovered = false
   self.wasClicked = false

   self.fg = {
      normal = {info.fg.normal[1] or 225, info.fg.normal[2] or 225, info.fg.normal[3] or 225, info.fg.normal[4] or 255},
      hover = {info.fg.hover[1] or 225, info.fg.hover[2] or 225, info.fg.hover[3] or 225, info.fg.hover[4] or 255},
      click = {info.fg.click[1] or 225, info.fg.click[2] or 225, info.fg.click[3] or 225, info.fg.click[4] or 255},
   }
   self.bg = {
      normal = {info.bg.normal[1] or 30, info.bg.normal[2] or 30, info.bg.normal[3] or 30, info.bg.normal[4] or 255},
      hover = {info.bg.hover[1] or 30, info.bg.hover[2] or 30, info.bg.hover[3] or 30, info.bg.hover[4] or 255},
      click = {info.bg.click[1] or 30, info.bg.click[2] or 30, info.bg.click[3] or 30, info.bg.click[4] or 255},
   }

   self.font = font or ui.defaultFont

   self.flags = {
      active = info.flags.active or true,
      visible = info.flags.visible or true,
      cleanRelease = info.flags.cleanRelease or false,
      exclusiveHover = info.flags.exclusiveHover or false,

      buttons = {
         [1] = info.flags.buttons[1] or false,
         [2] = info.flags.buttons[2] or true,
         [3] = info.flags.buttons[3] or true,
      },
   }


   self.onHover = info.onHover or function(button) end
   self.onBlur = info.onBlur or function(button) end
   self.onClick = info.onClick or function(button) end
   self.onRelease = info.onRelease or function(button) end

   self.update = info.update or function() end
   self.draw = info.draw or function()
      love.graphics.setColor(self:getCurrentBg())
      love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.dimensions.x, self.dimensions.y, 10, 10)

      love.graphics.setFont(self.font)
      love.graphics.setColor(self:getCurrentFg())
      love.graphics.printf(self.text, self.pos.x, self.pos.y + self.font:getHeight(self.text) / 2, self.dimensions.x, "center")
   end

   love.graphics.printf(self.text, self.pos.x, self.pos.y + self.font:getHeight(self.text) / 2, self.dimensions.x, "center")

   function self.remove() for i, b in ipairs(ui.list) do if self == b then table.remove(ui.list, i) end end end

   function self:setText(text) self.text = text or "" end
   function self:setPos(x, y) self.pos.x = x or 0 self.pos.y = y or 0 end
   function self:setSize(x, y) self.dimensions.x = x or 0 self.dimensions.y = y or 0 end

   function self:setState(state) self.state = state or "normal" end
   function self:setClicked(state) self.wasClicked = state end
   function self:setHovered(state) self.wasHovered = state end

   function self:setNormalFg(colors) self.fg.normal[1] = colors[1] or 225 self.fg.normal[2] = colors[4] or 225 self.fg.normal[3] = colors[3] or 225 self.fg.normal[4] = colors[4] or 255 end
   function self:setHoverFg(colors) self.fg.hover[1] = colors[1] or 225 self.fg.hover[2] = colors[2] or 225 self.fg.hover[3] = colors[3] or 225 self.fg.hover[4] = colors[4] or 255 end
   function self:setClickFg(colors) self.fg.click[1] = colors[1] or 225 self.fg.click[2] = colors[2] or 225 self.fg.click[3] = colors[3] or 225 self.fg.click[4] = colors[4] or 255 end

   function self:setNormalBg(colors) self.bg.normal[1] = colors[1] or 225 self.bg.normal[2] = colors[2] or 225 self.bg.normal[3] = colors[3] or 225 self.bg.normal[4] = colors[4] or 255 end
   function self:setHoverBg(colors) self.bg.hover[1] = colors[1] or 225 self.bg.hover[2] = colors[2] or 225 self.bg.hover[3] = colors[3] or 225 self.bg.hover[4] = colors[4] or 255 end
   function self:setClickBg(colors) self.bg.click[1] = colors[1] or 225 self.bg.click[2] = colors[2] or 225 self.bg.click[3] = colors[3] or 225 self.bg.click[4] = colors[4] or 255 end

   function self:setFont(font) self.font = font or ui.defaultFont end

   function self:setActive(state) self.flags.active = state end
   function self:setVisible(state) self.flags.visible = state end
   function self:setCleanRelease(state) self.flags.cleanRelease = state end
   function self:setExclusiveHover(state) self.flags.exclusiveHover = state end
   function self:setButton(buttons) self.flags.buttons[1] = buttons[1] or true self.flags.buttons[2] = buttons[2] or false self.flags.buttons[3] = buttons[3] or false end



   function self:getText() return self.text end
   function self:getPos() return self.pos.x, self.pos.y end
   function self:getSize() return self.dimensions.x, self.dimensions.y end

   function self:getState() return self.state end
   function self:getClicked() return self.wasClicked end
   function self:getHovered() return self.wasHovered end

   function self:getActive() return self.flags.active end
   function self:getVisible() return self.flags.visible end
   function self:getCleanRelease() return self.flags.cleanRelease end
   function self:getExclusiveHover() return self.flags.exclusiveHover end
   function self:getButton(button) return self.flags.buttons[button] end

   function self:getNormalFg() return self.fg.normal[1], self.fg.normal[2], self.fg.normal[3], self.fg.normal[4] end
   function self:getHoverFg() return self.fg.hover[1], self.fg.hover[2], self.fg.hover[3], self.fg.hover[4] end
   function self:getClickFg() return self.fg.click[1], self.fg.click[2], self.fg.click[3], self.fg.click[4] end
   function self:getCurrentFg()
      if self.state == "normal" then return self:getNormalFg()
      elseif self.state == "hover" then return self:getHoverFg()
      elseif self.state == "click" then return self:getClickFg()
      end
   end

   function self:getNormalBg() return self.bg.normal[1], self.bg.normal[2], self.bg.normal[3], self.bg.normal[4] end
   function self:getHoverBg() return self.bg.hover[1], self.bg.hover[2], self.bg.hover[3], self.bg.hover[4] end
   function self:getClickBg() return self.bg.click[1], self.bg.click[2], self.bg.click[3], self.bg.click[4] end
   function self:getCurrentBg()
      if self.state == "normal" then return self:getNormalBg()
      elseif self.state == "hover" then return self:getHoverBg()
      elseif self.state == "click" then return self:getClickBg()
      end
   end

   table.insert(ui.list, self)
   return self
end

function ui.update(dt)
   for i, b in ipairs(ui.list) do
      if not (b:getExclusiveHover() and b:getClicked()) and b:getActive() then
         local mx, my = love.mouse.getPosition()
         local x, y = b.pos.x, b.pos.y
         local w, h = b.dimensions.x, b.dimensions.y

         if mx > x and mx < x + w and
            my > y and my < y + h then

            if not b:getClicked() then
               b:setState("hover")
            end
            b:onHover()
            b:setHovered(true)
         else
            if b:getHovered() then
               if b:getClicked() then
                  b:setState("click")

               else
                  b:setState("normal")
               end
               b:onBlur()
               b:setHovered()
            end

            if b:getCleanRelease() and b:getClicked() then
               b:setState("normal")
               b:onRelease()
               b:setClicked()
            end
         end

         b:update(dt)
      end
   end
end

function ui.draw()
   for i, b in ipairs(ui.list) do
      if b:getVisible() then
         b:draw()
      end
   end
end

function ui.mousepressed(x, y, button)
   local clickedButton

   for i, b in ipairs(ui.list) do
      if  b:getActive() and b:getButton(button) then
         local mx, my = love.mouse.getPosition()
         local x, y = b.pos.x, b.pos.y
         local w, h = b.dimensions.x, b.dimensions.y

         if mx > x and mx < x + w and
            my > y and my < y + h then
            b:setState("click")
            b:onClick(x, y, button)
            b:setClicked(true)

            clickedButton = true
         end
      end
   end

   return clickedButton
end

function ui.mousereleased(x, y, button)
   for i, b in ipairs(ui.list) do
      if b:getActive() and b:getButton(button) then
         local mx, my = love.mouse.getPosition()
         local x, y = b.pos.x, b.pos.y
         local w, h = b.dimensions.x, b.dimensions.y

         if b:getClicked() then
            b:setState("normal")
            b:onRelease(x, y, button)
            b:setClicked()
         end
      end
   end
end

return ui
