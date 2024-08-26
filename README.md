# loveButtons
Uma biblioteca extremamente simples para botões e joysticks em touchScreen para LÖVE2D

# Funções 
- Criar botões 
- Criar Joystick
- Gráficos simples de botões 

# Instalação
Primeiro instale [LÖVE 2D](https://love2d.org)
Baixe o arquivo [loveButtons.Lua](loveButtons.Lua) e coloque ele na mesma pasta que seu main.lua

# Utilização (usage)
```Lua
loveButtons = require("loveButtons")
```


# Exemplos

```Lua
loveButtons = require("loveButtons")

function love.load()
    loveButtons.createButton("button",50,450,100,100) --cria o botão
    loveButtons.createJoystick("joystick",600,400,50,100) --cria o joystick
end

function love.update()
    loveButtons.run() --roda os testes dos botões
end

function love.draw()
    loveButtons.render() --renderiza na tela os botoes de maneira simples

    btnBool,btnInt = loveButtons.checkButton("button") --obtem as variaveis do botão
    joyX,joyY,joyAngle,joyForce = loveButtons.checkJoystick("joystick") --obtem as variaveis do joystick

    --Mostra as variaveis na tela para você testar
    love.graphics.print("btnBool: "..tostring(btnBool),0,0)
    love.graphics.print("btnInt: "..tostring(btnInt),0,10)
    love.graphics.print("joyX: "..tostring(joyX),0,20)
    love.graphics.print("joyY: "..tostring(joyY),0,30)
    love.graphics.print("joyAngle: "..tostring(joyAngle),0,40)
    love.graphics.print("joyForce: "..tostring(joyForce),0,50)
end
```

# Documentação 

