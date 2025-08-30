local uiLoader = loadstring(
    game:HttpGet(
        'https://gist.githubusercontent.com/FriFrai/88e75ee4a579094931ef2cf948b1b197/raw/b197e009bef061df125c5fce25ba72861f3a053b/xc'
    )
)

local ui = uiLoader({
    rounding = false,
    theme = 'blueberry',
    smoothDragging = false,
})

ui.autoDisableToggles = true

local window = ui.newWindow({
    text = 'Dollarware demo',
    resize = true,
    size = Vector2.new(550, 450), 
    position = nil,
})


local toggle, smallButton, largeButton, dropdown, multidropdown, hotkey
local slider, toggledDropdown, colorPicker, textbox

local menu = window:addMenu({
    text = 'menu 1',
})
do
    local section = menu:addSection({
        text = 'section 1',
        side = 'left',
    })
    do
        section:addLabel({ text = 'text' })

        
        toggle = section:addToggle({
            text = 'toggle',
            state = false,
        })
        toggle:bindToEvent('onToggle', function(newState)
            ui.notify({
                title = 'toggle',
                message = 'Toggle was toggled to ' .. tostring(newState),
                duration = 3,
            })
        end)

        smallButton = section:addButton({
            text = 'button (small)',
            style = 'small',
        })
        smallButton:bindToEvent('onClick', function()
            ui.notify({
                title = 'button',
                message = 'The button got clicked!',
                duration = 3,
            })
        end)

        largeButton = section:addButton({
            text = 'button (large)',
            style = 'large',
        }, function()
            ui.notify({
                title = 'button',
                message = 'The large button got clicked!',
                duration = 3,
            })
        end)
        largeButton:setTooltip('this is a large button')

        dropdown = section:addDropdown({
            text = 'dropdown',
            options = {
                { text = 'First Choice', value = 1 },
                { text = 'Second Choice', value = 'two' },
            },
            default = 'two',
        })
        dropdown:bindToEvent('onSelectionChanged', function(newValue, newText)
            ui.notify({
                title = 'dropdown',
                message = string.format(
                    "Selected '%s' (Value: %s)",
                    newText,
                    tostring(newValue)
                ),
                duration = 3,
            })
        end)

        multidropdown = section:addMultidropdown({
            text = 'multidropdown',
            options = {
                { text = 'Option A', value = 'a' },
                { text = 'Option B', value = 'b' },
                { text = 'Option C', value = 'c' },
                { text = 'Option D', value = 'd' },
            },
            defaults = { 'a', 'c' },
        })
        multidropdown:bindToEvent('onSelectionChanged', function(selectedValues)
            local message = 'Selected: ' .. table.concat(selectedValues, ', ')
            if #selectedValues == 0 then
                message = 'Nothing selected'
            end
            ui.notify({
                title = 'multidropdown',
                message = message,
                duration = 3,
            })
        end)

        hotkey = section:addHotkey({ text = 'hotkey' })
        hotkey:setHotkey(Enum.KeyCode.G)
        hotkey:setTooltip('This is a hotkey linked to the toggle!')
        hotkey:linkToControl(toggle)
    end

    local section2 = menu:addSection({
        text = 'section 2',
        side = 'right',
    })
    do
        slider = section2:addSlider({
            text = 'slider',
            min = 1,
            max = 150,
            step = 0.01,
            val = 50,
        }, function(newValue)
            print(newValue)
        end)
        slider:setTooltip('Heres a slider!')

        toggledDropdown = section2:addToggledDropdown({
            text = 'A dropdown with toggles inside',
            options = {
                { text = 'Enable Speed', value = 'speed', state = true },
                { text = 'Enable Flight', value = 'flight', state = false },
                { text = 'Enable ESP', value = 'esp', state = true },
                { text = 'Enable Noclip', value = 'noclip', state = false },
            },
        })
        toggledDropdown:bindToEvent('onStateChanged', function(toggledItems)
            local message = 'Enabled features: '
                .. table.concat(toggledItems, ', ')
            if #toggledItems == 0 then
                message = 'All features are disabled'
            end
            ui.notify({
                title = 'Toggled Dropdown',
                message = message,
                duration = 4,
            })
        end)

        colorPicker = section2:addColorPicker({
            text = 'color picker',
            color = Color3.fromRGB(255, 0, 0),
        }, function(newColor)
            print(newColor)
        end)

        textbox = section2:addTextbox({ text = 'textbox' })
        textbox:bindToEvent('onFocusLost', function(text)
            ui.notify({ title = 'textbox', message = text, duration = 4 })
            textbox:setText(text)
        end)
    end
end

local menu2 = window:addMenu({
    text = 'menu 2',
})
do
    local debugSectionLeft = menu2:addSection({
        text = 'Debug Controls 1',
        side = 'left',
    })
    do
        debugSectionLeft:addLabel({
            text = 'Call methods on controls above:',
        })

        debugSectionLeft:addButton({ text = 'Get Toggle State' }, function()
            ui.notify({
                title = 'Debug',
                message = 'Toggle state is: ' .. tostring(toggle:getState()),
            })
        end)

        debugSectionLeft:addButton({ text = 'Get Slider Value' }, function()
            ui.notify({
                title = 'Debug',
                message = 'Slider value is: ' .. slider:getValue(),
            })
        end)

        debugSectionLeft:addButton({ text = 'Set Slider to 75' }, function()
            slider:setValue(75)
            ui.notify({ title = 'Debug', message = 'Slider value set to 75' })
        end)

        debugSectionLeft:addButton(
            { text = 'Get ColorPicker Color' },
            function()
                ui.notify({
                    title = 'Debug',
                    message = 'Color is: ' .. tostring(colorPicker:getColor()),
                })
            end
        )

        debugSectionLeft:addButton({ text = 'Set Color to Blue' }, function()
            colorPicker:setColor(Color3.new(0, 0, 1))
            ui.notify({ title = 'Debug', message = 'Color set to blue' })
        end)

        debugSectionLeft:addButton({ text = 'Get Hotkey' }, function()
            ui.notify({
                title = 'Debug',
                message = 'Hotkey is: ' .. tostring(hotkey:getHotkey()),
            })
        end)
    end

    local debugSectionRight = menu2:addSection({
        text = 'Debug Controls 2',
        side = 'right',
    })
    do
        debugSectionRight:addLabel({ text = 'Call methods on controls above:' }) 

        debugSectionRight:addButton({ text = 'Get Textbox Text' }, function()
            ui.notify({
                title = 'Debug',
                message = 'Textbox text is: "' .. textbox:getText() .. '"',
            })
        end)

        debugSectionRight:addButton(
            { text = "Set Textbox to 'Hello'" },
            function()
                textbox:setText('Hello')
                ui.notify({
                    title = 'Debug',
                    message = "Textbox text set to 'Hello'",
                })
            end
        )

        debugSectionRight:addButton(
            { text = 'Get Dropdown Value/Text' },
            function()
                local msg = string.format(
                    'Value: %s, Text: %s',
                    tostring(dropdown:getValue()),
                    dropdown:getText()
                )
                ui.notify({ title = 'Debug', message = msg })
            end
        )

        debugSectionRight:addButton(
            { text = 'Get Multidropdown Values' },
            function()
                local values = multidropdown:getValues()
                ui.notify({
                    title = 'Debug',
                    message = 'Selected: ' .. table.concat(values, ', '),
                })
            end
        )

        debugSectionRight:addButton(
            { text = 'Get ToggledDropdown Values' },
            function()
                local toggled = toggledDropdown:getToggled()
                ui.notify({
                    title = 'Debug',
                    message = 'Enabled: ' .. table.concat(toggled, ', '),
                })
            end
        )
    end
end
