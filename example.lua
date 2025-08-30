-- Dollarware example script


local uiLoader = loadstring(game:HttpGet('https://gist.githubusercontent.com/FriFrai/88e75ee4a579094931ef2cf948b1b197/raw/b197e009bef061df125c5fce25ba72861f3a053b/xc'))

local ui = uiLoader({
    rounding = false, 
    theme = 'cherry', 
    smoothDragging = false 
})

ui.autoDisableToggles = true 





local window = ui.newWindow({
    text = 'Dollarware demo', 
    resize = true, 
    size = Vector2.new(550, 376), 
    position = nil 
})

local menu = window:addMenu({
    text = 'menu 1' 
})
do 
    
    local section = menu:addSection({
        text = 'section 1', 
        side = 'auto', 
        showMinButton = true, 
    })
    
    do 
        section:addLabel({
            text = 'text' 
        })
        
        local toggle = section:addToggle({
            text = 'toggle', 
            state = false 
        })
        
        toggle:bindToEvent('onToggle', function(newState) 
            ui.notify({
                title = 'toggle',
                message = 'Toggle was toggled to ' .. tostring(newState),
                duration = 3
            })
        end)
        
        section:addButton({
            text = 'button (small)', 
            style = 'small' 
        }):bindToEvent('onClick', function() 
            ui.notify({
                title = 'button',
                message = 'The button got clicked!',
                duration = 3
            })
        end)
        
        section:addButton({
            text = 'button (large)', 
            style = 'large' 
        }, function() 
            ui.notify({
                title = 'button',
                message = 'The large button got clicked!',
                duration = 3
            })
        end):setTooltip('this is a large button')
        
        section:addDropdown({
            text = 'dropdown', -- Text for the tooltip
            options = { -- The list of options {text = "Display Name", value = "ActualValue"}
                {text = 'First Choice', value = 1},
                {text = 'Second Choice', value = 'two'},
            },
            default = 'two' -- The default selected value
        }):bindToEvent('onSelectionChanged', function(newValue, newText) -- Callback for when the selection changes
            ui.notify({
                title = 'dropdown',
                message = string.format("Selected '%s' (Value: %s)", newText, tostring(newValue)),
                duration = 3
            })
        end)

        section:addMultidropdown({
            text = 'multidropdown',
            options = { 
                {text = 'Option A', value = 'a'},
                {text = 'Option B', value = 'b'},
                {text = 'Option C', value = 'c'},
                {text = 'Option D', value = 'd'},
            },
            defaults = {'a', 'c'} 
        }):bindToEvent('onSelectionChanged', function(selectedValues) 
            local message = "Selected: " .. table.concat(selectedValues, ", ")
            if #selectedValues == 0 then
                message = "Nothing selected"
            end
            ui.notify({
                title = 'multidropdown',
                message = message,
                duration = 3
            })
        end)
        
        local hotkey = section:addHotkey({
            text = 'hotkey'
        })
        hotkey:setHotkey(Enum.KeyCode.G)
        hotkey:setTooltip('This is a hotkey linked to the toggle!')
        hotkey:linkToControl(toggle)
    end
    
    local section = menu:addSection({
        text = 'section 2',
        side = 'right',
        showMinButton = false
    })
    do 
        section:addSlider({
            text = 'slider',
            min = 1,
            max = 150,
            step = 0.01,
            val = 50
        }, function(newValue) 
            print(newValue)
        end):setTooltip('Heres a slider!')

        section:addToggledDropdown({
            text = 'A dropdown with toggles inside', 
            options = { 
                {text = "Enable Speed", value = "speed", state = true},
                {text = "Enable Flight", value = "flight", state = false},
                {text = "Enable ESP", value = "esp", state = true},
                {text = "Enable Noclip", value = "noclip", state = false},
            }
        }):bindToEvent('onStateChanged', function(toggledItems) 
            local message = "Enabled features: " .. table.concat(toggledItems, ", ")
            if #toggledItems == 0 then
                message = "All features are disabled"
            end
            ui.notify({
                title = 'Toggled Dropdown',
                message = message,
                duration = 4
            })
        end)

        section:addColorPicker({
            text = 'color picker',
            color = Color3.fromRGB(255, 0, 0)
        }, function(newColor) 
            print(newColor)
        end)
        
        section:addTextbox({
            text = 'textbox'
        }):bindToEvent('onFocusLost', function(text) 
            ui.notify({
                title = 'textbox',
                message = text,
                duration = 4
            })
        end)
    end
    
end

window:addMenu({
    text = 'menu 2'
})
