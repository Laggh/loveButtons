local loveButtons = {}
loveButtons.buttons = {}

function loveButtons.getAngle(_X1,_Y1,_X2,_Y2,_IsDeg)
    -- angle in radians
    local angleRadians = math.atan2(_Y2 - _Y1, _X2 - _X1);
        
    --[[ angle in degrees
    local angleDeg = angleRadians * 180 / math.pi;
    ]]
    return angleRadians
end

function loveButtons.createButton(_Id,_X,_Y,_Width,_Height)
    local itExists = false
    for i,v in ipairs(loveButtons.buttons) do
        if v.id == _Id and v.type == "button" then 
            v.x = _X
            v.y = _Y
            v.width = _Width
            v.height = _Height
            itExists = true
        end
    end
    if not itExists then
        local button = {}
        button.x = _X
        button.y = _Y
        button.width = _Width
        button.height = _Height
        button.type = "button"
        button.press = false 
        button.id = _Id
        button.length = 0

        table.insert(loveButtons.buttons,button)
    end
end

function loveButtons.createJoystick(_Id,_X,_Y,_SizeInner,_SizeOuter)
    for i,v in ipairs(loveButtons.buttons) do
        if v.id == _Id and v.type == "joystick" then
            table.remove(loveButtons.buttons,i) 
        end
    end
    local joystick = {}
    joystick.x = _X
    joystick.y = _Y
    joystick.sizeInner = _SizeInner
    joystick.sizeOuter = _SizeOuter
    joystick.type = "joystick"
    joystick.inputX = 0
    joystick.inputY = 0
    joystick.angle = 0
    joystick.force = 0
    joystick.id = _Id
    joystick.touchId = 0

    table.insert(loveButtons.buttons,joystick)
end

function loveButtons.deleteButton(_Id)
    for i,v in ipairs(loveButtons.buttons) do
        if v.id == _Id and v.type == "button" then 
            table.remove(loveButtons.buttons,i)
        end
    end
end

function loveButtons.deleteJoystick(_Id)
    for i,v in ipairs(loveButtons.buttons) do
        if v.id == _Id and v.type == "joystick" then
            table.remove(loveButtons.buttons,i)
        end
    end
end

function loveButtons.run()
    local x,y
    local touches = love.touch.getTouches()
    if love.mouse.isDown(1) then
        table.insert(touches,"mouse")
    end
    for i,v in ipairs(loveButtons.buttons) do
        if v.type == "button" then
            v.press = false            
            for ii,vv in ipairs(touches) do
                if vv == "mouse" then
                    x,y = love.mouse.getPosition()
                else
                    x,y = love.touch.getPosition(vv)
                end
                if x > v.x and x < v.x + v.width and y > v.y and y < v.y + v.height then 
                    v.press = true
                end
            end

            if v.press then v.length = v.length + 1 else v.length = 0 end
            if loveButtons.onPress and v.length == 1 then loveButtons.onPress(v.id) end
        end

        if v.type == "joystick" then
            v.force = ((v.inputX)^2+(v.inputY)^2)^0.5
            v.angle = loveButtons.getAngle(0,0,v.inputX,v.inputY)
            if v.touchId == 0 then
                v.inputX , v.inputY = 0,0            
                for ii,vv in ipairs(touches) do
                    if vv == "mouse" then
                        x,y = love.mouse.getPosition()
                    else
                        x,y = love.touch.getPosition(vv)
                    end
                    local dist = ((v.x-x)^2+(v.y-y)^2)^0.5
                    if dist < v.sizeOuter then 
                        v.touchId = vv
                    end
                end
            else
                local touchExists = false
                for ii,vv in ipairs(touches) do
                    if vv == v.touchId then touchExists = true end
                end

                if touchExists then 
                    if v.touchId == "mouse" then
                        x,y = love.mouse.getPosition()
                    else
                        x,y = love.touch.getPosition(v.touchId)
                    end
                    v.inputX = (x - v.x)/v.sizeOuter
                    v.inputY = (y - v.y)/v.sizeOuter
                    if v.inputX > 1 then v.inputX = 1 end
                    if v.inputX < -1 then v.inputX = -1 end
                    if v.inputY > 1 then v.inputY = 1 end
                    if v.inputY < -1 then v.inputY = -1 end
                else
                    v.touchId = 0
                end
            end
        end
    end    

end

function loveButtons.checkButton(_Id)
    for i,v in ipairs(loveButtons.buttons) do
        if v.type == "button" and v.id == _Id then
            return v.press, v.length
        end
    end
    return nil
end

function loveButtons.checkJoystick(_Id)
    for i,v in ipairs(loveButtons.buttons) do
        if v.type == "joystick" and v.id == _Id then
            return v.inputX, v.inputY ,v.angle, v.force
        end
    end
    return nil
end


function loveButtons.render()
    for i,v in ipairs(loveButtons.buttons) do
        if v.type == "button" then            
            local RENDER -- "line" / "fill"
            if v.press then RENDER = "fill" else RENDER = "line" end
            love.graphics.rectangle(RENDER,v.x,v.y,v.width,v.height)
        end

        if v.type == "joystick" then
            love.graphics.circle("line",v.x,v.y,v.sizeOuter)
            love.graphics.circle("line",v.x+(v.inputX*v.sizeOuter),v.y+(v.inputY*v.sizeOuter),v.sizeInner)  
            love.graphics.print(tostring(v.touchId),v.x,v.y)
        end
    end
end




return loveButtons
