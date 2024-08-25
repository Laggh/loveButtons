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
 loveButtons.createButton("button",{...})
end

function love.update()
 loveButtons.run()
end

function love.draw()
 loveButtons.render()
end
```

# Documentação 

