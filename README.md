# Documentation

### Format
-   `class:function(argument: type) -> return; [aliases]`
    -   Funções que retornam `self` podem ser encadeadas.
    -   Exemplo: ``toggle:enable():setTooltip('this works!')``
-   `!eventName (arguments)`
    -   Eventos que podem ser conectados usando ``:bindToEvent('eventName', callback)``.

### General `settings` Table
Muitas funções de criação de elementos aceitam uma tabela de `settings`. Aqui estão as chaves mais comuns:

-   `text: string`: O texto de exibição para um controle (título, label, etc.).
-   `state: boolean`: O estado inicial (ligado/desligado) para `toggle` e `dropdowntoggle`.
-   `options: table`: Uma lista de opções para dropdowns. Formato: `{ {text="Display Name", value="InternalValue"}, ... }`.
-   `default: any`: O `value` da opção que deve ser selecionada por padrão em `dropdown` e `dropdowntoggle`.
-   `defaults: table`: Uma lista de `values` que devem ser selecionados por padrão em `multidropdown`.
-   `callback: function`: Uma função a ser chamada no evento principal do controle (atalho para `bindToEvent`).

---

## API Documentation

### UI
O objeto principal da biblioteca, retornado pela chamada `uiLoader({...})`.

-   ``ui.newWindow(settings: table) -> window``
    -   Cria e retorna a janela principal da UI. **Não é uma namecall.**
    -   `settings.text: string`: Título da janela.
    -   `settings.resize: boolean`: Se a janela pode ser redimensionada.
    -   `settings.size: Vector2/UDim2`: Tamanho inicial da janela.
    -   `settings.position: Vector2/UDim2`: Posição inicial da janela.
-   ``ui.notify(settings: table) -> nil``
    -   Exibe uma notificação temporária no canto da tela.
    -   `settings.title: string`: O título da notificação.
    -   `settings.message: string`: O corpo da notificação.
    -   `settings.duration: number`: Quantos segundos a notificação ficará visível.
-   ``ui.destroy() -> nil``
    -   Destrói completamente a UI e todas as suas conexões.

#### Eventos
-   `!onPreDestroy ()`: Disparado imediatamente quando `ui.destroy()` é chamado. Todos os recursos (janelas, toggles) ainda existem. Ideal para salvar configurações.
-   `!onDestroy ()`: Disparado após todos os recursos da UI terem sido destruídos.

---

### Window
A janela principal que contém todos os menus e seções.

-   ``window:destroy() -> self``
-   ``window:setTitle(newTitle: string) -> self``
-   ``window:setIcon(assetId: string) -> self``
-   ``window:setPosition(newPosition: Vector2/UDim2) -> self``
-   ``window:setSize(newSize: Vector2/UDim2) -> self``
-   ``window:getPosition() -> UDim2``
-   ``window:getSize() -> UDim2``
-   ``window:minimize() -> self``
-   ``window:addMenu(settings: table) -> menu``
    -   Adiciona uma aba (menu) na barra lateral.

### Menu
As abas na barra lateral que contêm as seções com os controles.

-   ``menu:select() -> self``
-   ``menu:deselect() -> self``
-   ``menu:addSection(settings: table) -> section``
    -   Cria um container dentro do menu para agrupar controles.
    -   `settings.text: string`: Título da seção.
    -   `settings.side: string`: `'left'`, `'right'`, ou `'auto'`.
    -   `settings.showMinButton: boolean`: Se a seção pode ser minimizada.

### Section
O container final para todos os controles da UI.

-   ``section:minimize() -> nil``
-   ``section:addToggle(settings: table, callback?: function) -> toggle``
-   ``section:addButton(settings: table, callback?: function) -> button``
-   ``section:addLabel(settings: table) -> label``
-   ``section:addColorPicker(settings: table, callback?: function) -> picker``
-   ``section:addTextbox(settings: table, callback?: function) -> textbox``
-   ``section:addSlider(settings: table, callback?: function) -> slider``
-   ``section:addHotkey(settings: table) -> hotkey``
-   ``section:addDropdown(settings: table, callback?: function) -> dropdown``
-   ``section:addMultidropdown(settings: table, callback?: function) -> multidropdown``
-   ``section:addDropdownToggle(settings: table, callback?: function) -> dropdowntoggle``
-   ``section:addToggledDropdown(settings: table, callback?: function) -> toggleddropdown``

---

## Controls

### Label
Um simples texto não interativo.

-   ``label:getText() -> string``
-   ``label:setText(text: string) -> self``

#### Exemplo
```lua
section:addLabel({ text = "This is an informational label." })
```

### Toggle
Um interruptor liga/desliga.

-   ``toggle:getState() -> boolean; [getValue, isEnabled]``
-   ``toggle:disable() -> self``
-   ``toggle:enable() -> self``
-   ``toggle:toggle() -> self``
-   ``toggle:setTooltip(tooltip: string) -> self``

#### Eventos
-   `!onEnable ()`
-   `!onDisable ()`
-   `!onToggle (state: boolean)`

#### Exemplo
```lua
local myToggle = section:addToggle({ text = "Fly", state = false })
myToggle:bindToEvent('onToggle', function(newState)
    print("Fly is now:", newState)
end)
```

### Button
Um botão clicável.

-   ``button:click() -> self``
-   ``button:setTooltip(tooltip: string) -> self``

#### Eventos
-   `!onClick ()`

#### Exemplo
```lua
section:addButton({ text = "Click Me", style = "large" }, function()
    print("Button was clicked!")
end)
```

### Slider
Um controle deslizante para selecionar um número em um intervalo.

-   ``slider:getValue() -> number``
-   ``slider:setValue(newValue: number) -> nil``
-   ``slider:setTooltip(tooltip: string) -> self``

#### Eventos
-   `!onNewValue (value: number)`

#### Exemplo
```lua
section:addSlider({
    text = "Speed",
    min = 16, max = 100, step = 1, val = 50
}, function(newSpeed)
    print("Speed set to:", newSpeed)
end)
```

### ColorPicker
Um botão que abre uma janela de seleção de cores.

-   ``picker:getColor() -> Color3``
-   ``picker:setColor(color: Color3) -> nil``
-   ``picker:setTooltip(tooltip: string) -> self``

#### Eventos
-   `!onNewColor (color: Color3)`

#### Exemplo
```lua
section:addColorPicker({
    text = "ESP Color",
    color = Color3.new(1, 0, 0)
}, function(newColor)
    print("New color is:", newColor)
end)
```

### Textbox
Um campo para entrada de texto.

-   ``textbox:getText() -> string``
-   ``textbox:setText(newText: string) -> nil``
-   ``textbox:setTooltip(tooltip: string) -> self``

#### Eventos
-   `!onTextChange (text: string)`: Dispara a cada caractere digitado.
-   `!onFocusLost (text: string)`: Dispara quando o usuário pressiona Enter ou clica fora.

#### Exemplo
```lua
section:addTextbox({ text = "Player Name" })
    :bindToEvent('onFocusLost', function(playerName)
        print("Target player:", playerName)
    end)
```

### Hotkey
Um controle para definir uma tecla de atalho.

-   ``hotkey:setHotkey(key: Enum.KeyCode/string) -> nil``
-   ``hotkey:getHotkey() -> Enum.KeyCode``
-   ``hotkey:linkToControl(control: toggle/button) -> self``
-   ``hotkey:setTooltip(tooltip: string) -> self``

#### Exemplo
```lua
local myToggle = section:addToggle({ text = "Auto Click" })
section:addHotkey({ text = "Click Hotkey" }):linkToControl(myToggle)
```

### Dropdown
Uma lista suspensa de seleção única.

-   ``dropdown:getValue() -> any``: Retorna o `value` da opção selecionada.
-   ``dropdown:getText() -> string``: Retorna o `text` da opção selecionada.
-   ``dropdown:setOptions(options: table) -> self``
-   ``dropdown:clearOptions() -> self``
-   ``dropdown:addOption(text: string, value: any) -> self``
-   ``dropdown:setTooltip(tooltip: string) -> self``

#### Eventos
-   `!onSelectionChanged (value: any, text: string)`
-   `!onOpen ()`
-   `!onClose ()`

#### Exemplo
```lua
section:addDropdown({
    text = "Target Part",
    options = {
        {text = "Head", value = "Head"},
        {text = "Torso", value = "HumanoidRootPart"}
    },
    default = "Head"
}, function(value, text)
    print("Selected part:", text, "with value:", value)
end)
```

### Multidropdown
Uma lista suspensa de múltipla seleção.

-   ``multidropdown:getValues() -> table``: Retorna uma tabela com os `values` de todas as opções selecionadas.
-   ``multidropdown:setOptions(options: table) -> self``
-   ``multidropdown:toggleValue(value: any) -> self``
-   ``multidropdown:setTooltip(tooltip: string) -> self``

#### Eventos
-   `!onSelectionChanged (selectedValues: table)`

#### Exemplo
```lua
section:addMultidropdown({
    text = "Visuals",
    options = {
        {text = "Tracers", value = "tracers"},
        {text = "Boxes", value = "boxes"},
        {text = "Names", value = "names"}
    },
    defaults = {"boxes", "names"}
}, function(selected)
    print("Visuals enabled:", table.concat(selected, ", "))
end)
```

### DropdownToggle
Um controle híbrido: um toggle que possui um menu dropdown acessível por uma seta.

-   **Toggle:** ``getState()``, ``toggle()``, ``enable()``, ``disable()``
-   **Dropdown:** ``getValue()``, ``getText()``, ``setOptions(options: table)``
-   **Comum:** ``setTooltip(tooltip: string) -> self``

#### Eventos
-   `!onToggle (state: boolean)`: Dispara ao clicar na área principal.
-   `!onSelectionChanged (value: any, text: string)`: Dispara ao selecionar um item no menu.
-   `!onEnable ()` / `!onDisable ()`

#### Exemplo
```lua
section:addDropdownToggle({
    text = "Aimbot", state = true,
    options = {{text="Head", value="Head"}, {text="Body", value="Torso"}},
    default = "Head"
}):bindToEvent('onToggle', function(enabled)
    print("Aimbot enabled:", enabled)
end):bindToEvent('onSelectionChanged', function(value)
    print("Aimbot target part:", value)
end)
```

### ToggledDropdown
Uma lista suspensa que contém uma lista de toggles independentes.

-   ``toggleddropdown:getToggled() -> table``: Retorna uma tabela com os `values` de todos os toggles ativados.
-   ``toggleddropdown:setOptions(options: table) -> self``
-   ``toggleddropdown:setTooltip(tooltip: string) -> self``

#### Eventos
-   `!onStateChanged (toggledItems: table)`

#### Exemplo
```lua
section:addToggledDropdown({
    text = "Auto Farm",
    options = {
        {text = "Chests", value = "chests", state = true},
        {text = "Mobs", value = "mobs", state = true},
        {text = "Quests", value = "quests", state = false}
    }
}, function(enabledFarming)
    print("Currently farming:", table.concat(enabledFarming, ", "))
end)
```
