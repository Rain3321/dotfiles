hs.hotkey.bind({'option', 'cmd'}, 'r', hs.reload)

-- 키보드 매핑 (카라비너 대체)
local fRemap = require('modules.foundation_remapping')
local remapper = fRemap.new()
remapper:remap('capslock', 'f18')
remapper:remap('rshift' ,'f17')
remapper:remap('ropt', 'f14')
remapper:remap('rcmd', 'f14')
remapper:remap('end', 'f13')
-- remapper:remap('escape', 'f16')
remapper:register()
-- end

local app_mode = hs.hotkey.modal.new()
local tap_mode = hs.hotkey.modal.new()

hs.hotkey.bind({}, 'f17', function() app_mode:enter() end, function() app_mode:exit() end)
hs.hotkey.bind({}, 'f14', function() tap_mode:enter() end, function() tap_mode:exit() end)

local boxes = {}
-- 자신이 사용하고 있는 English 인풋 소스 이름을 넣어준다
local inputEnglish = "com.apple.keylayout.ABC"
local inputKorean = "org.youknowone.inputmethod.Gureum.han2"
local box_height = 23
local box_alpha = 0.35
local GREEN = hs.drawing.color.osx_green

-- 입력소스 변경 이벤트에 이벤트 리스너를 달아준다
hs.keycodes.inputSourceChanged(function()
    disable_show()
    if hs.keycodes.currentSourceID() ~= inputEnglish then
        enable_show()
    end
end)

upper_color = {
    hex="#00FFFF",
    alpha=1
}

function enable_show()
    reset_boxes()
    hs.fnutils.each(hs.screen.allScreens(), function(scr)
        local frame = scr:fullFrame()

        local box = newBox()
        draw_rectangle(box, frame.x, frame.y, frame.w, box_height, upper_color)
        table.insert(boxes, box)

        -- 이 부분의 주석을 풀면 화면 아래쪽에도 보여준다
        -- local box2 = newBox()
        -- draw_rectangle(box2, frame.x, frame.y + frame.h - 10, frame.w, box_height, GREEN)
        -- table.insert(boxes, box2)
    end)
end

function disable_show()
    hs.fnutils.each(boxes, function(box)
        if box ~= nil then
            box:delete()
        end
    end)
    reset_boxes()
end

function newBox()
    return hs.drawing.rectangle(hs.geometry.rect(0,0,0,0))
end

function reset_boxes()
    boxes = {}
end

function draw_rectangle(target_draw, x, y, width, height, fill_color)
  target_draw:setSize(hs.geometry.rect(x, y, width, height))
  target_draw:setTopLeft(hs.geometry.point(x, y))

  target_draw:setFillColor(fill_color)
  target_draw:setFill(true)
  target_draw:setAlpha(box_alpha)
  target_draw:setLevel(hs.drawing.windowLevels.overlay)
  target_draw:setStroke(false)
  target_draw:setBehavior(hs.drawing.windowBehaviors.canJoinAllSpaces)
  target_draw:show()
end

do  -- tab move
    local tabTable = {}

    tabTable['Slack'] = {
        left = { mod = {'option'}, key = 'up' },
        right = { mod = {'option'}, key = 'down' }
    }
    tabTable['Safari'] = {
        left = { mod = {'control', 'shift'}, key = 'tab' },
        right = { mod = {'control'}, key = 'tab' }
    }
    tabTable['터미널'] = {
        left = { mod = {'control', 'shift'}, key = 'tab' },
        right = { mod = {'control'}, key = 'tab' }
    }
    tabTable['Terminal'] = {
        left = { mod = {'control', 'shift'}, key = 'tab' },
        right = { mod = {'control'}, key = 'tab' }
    }
    tabTable['iTerm2'] = {
        left = { mod = {'shift', 'command'}, key = '[' },
        right = { mod = {'shift', 'command'}, key = ']' }
    }
    tabTable['IntelliJ IDEA'] = {
        left = { mod = {'command', 'shift'}, key = '[' },
        right = { mod = {'command', 'shift'}, key = ']' }
    }
    tabTable['PhpStorm'] = {
        left = { mod = {'command', 'shift'}, key = '[' },
        right = { mod = {'command', 'shift'}, key = ']' }
    }
    tabTable['Code'] = {
        left = { mod = {'command', 'shift'}, key = '[' },
        right = { mod = {'command', 'shift'}, key = ']' }
    }
    tabTable['DataGrip'] = {
        left = { mod = {'command', 'shift'}, key = '[' },
        right = { mod = {'command', 'shift'}, key = ']' }
    }
    tabTable['_else_'] = {
        left = { mod = {'control'}, key = 'pageup' },
        right = { mod = {'control'}, key = 'pagedown' }
    }

    local function tabMove(dir)
        return function()
            local activeAppName = hs.application.frontmostApplication():name()
            local tab = tabTable[activeAppName] or tabTable['_else_']
            hs.eventtap.keyStroke(tab[dir]['mod'], tab[dir]['key'])
        end
    end

    tap_mode:bind({}, ',', tabMove('left'))
    tap_mode:bind({}, '.', tabMove('right'))
end

do  -- app manager
    local app_man = require('modules.appman')
    local mode = app_mode

    -- mode:bind({'shift'}, 'space', app_man:toggle('Alacritty'))
    -- mode:bind({}, 'b', app_man:toggle('Robo 3T'))
    -- mode:bind({}, 'e', app_man:toggle('SpringToolSuite4'))
    -- mode:bind({}, 'i', app_man:toggle('PhpStorm'))
    -- mode:bind({}, 'r', app_man:toggle('Reminders'))
    -- mode:bind({}, 'space', app_man:toggle('Alacritty'))
    -- mode:bind({}, 'space', app_man:toggle('iTerm'))
    -- mode:bind({}, 'v', app_man:toggle('MacVim'))

    mode:bind({}, ',', app_man:toggle('System Preferences'))
    mode:bind({}, '/', app_man:toggle('Activity Monitor'))
    -- mode:bind({}, 'a', app_man:toggle('Authy Desktop'))
    -- mode:bind({}, 'b', app_man:toggle('DBeaver'))
    mode:bind({}, 'c', app_man:toggle('Google Chrome'))
    -- mode:bind({}, 'd', app_man:toggle('Docker'))
    -- mode:bind({'option'}, 'd', app_man:toggle('Discord'))
    mode:bind({}, 'e', app_man:toggle('Finder'))
    -- mode:bind({}, 'f', app_man:toggle('Firefox'))
    -- mode:bind({}, 'g', app_man:toggle('DataGrip'))
    -- mode:bind({}, 'd', app_man:toggle('MYSQLWorkbench'))
    -- mode:bind({}, 'd', app_man:toggle('Docker Desktop'))
    mode:bind({}, 'i', app_man:toggle('IntelliJ IDEA'))
    -- mode:bind({}, 'k', app_man:toggle('KakaoTalk'))
    -- mode:bind({}, 'n', app_man:toggle('Notes'))
    -- mode:bind({}, 'n', app_man:toggle('Notion'))
    mode:bind({}, 'p', app_man:toggle('Postman'))
    -- mode:bind({}, 'r', app_man:toggle('Trello'))
    --  mode:bind({}, 'r', app_man:toggle('draw.io'))
    mode:bind({}, 's', app_man:toggle('Slack'))
    mode:bind({}, 'space', app_man:toggle('Terminal'))
    -- mode:bind({}, 'space', app_man:toggle('iTerm'))
    -- mode:bind({}, 'v', app_man:toggle('VimR'))
    mode:bind({}, 'v', app_man:toggle('Visual Studio Code'))
    mode:bind({'shift'}, 'v', app_man:toggle('VMware Horizon Client'))
    -- mode:bind({}, 'w', app_man:toggle('Microsoft Word'))
    mode:bind({}, 'z', app_man:toggle('zoom.us'))
    -- mode:bind({}, 'y', app_man:toggle('YouTube Music'))
    mode:bind({}, 'o', app_man:toggle('Obsidian'))
    mode:bind({}, 'g', app_man:toggle('GitKraken'))

    -- mode:bind({'shift'}, 'tab', app_man.focusPreviousScreen)
    -- mode:bind({}, 'tab', app_man.focusNextScreen)

    mode:bind({}, 'tab', hs.hints.windowHints)
    hs.hints.hintChars = {
        'q', 'w', 'e', 'r',
        'a', 's', 'd', 'f',
        'z', 'x', 'c', 'v',
        '1', '2', '3', '4',
        'j', 'k',
        'i', 'o',
        'm', ','
    }

    -- mvim = true
    mode:bind({'control'}, 'v', function()

    end)
end

local app_map = {
	{ key = 'c', mod = {}, app = 'Google Chrome'},
	{ key = 'e', mod = {}, app = 'Finder'},
	{ key = 's', mod = {}, app = 'Slack'},
	{ key = 'd', mod = {}, app = 'MYSQLWorkbench'},
	{ key = 'g', mod = {}, app = 'GitKraken'},
	{ key = 'i', mod = {}, app = 'IntelliJ IDEA'},
	{ key = 'p', mod = {}, app = 'Postman'},
	{ key = 'v', mod = {}, app = 'Visual Studio Code'},
	{ key = 'v', mod = {'shift'}, app = 'VMware Horizon Client'},
	{ key = 'space', mode = {}, app = 'Terminal'},
	{ key = 'z', mod = {}, app = 'zoom.us'},
	{ key = 'o', mod = {}, app = 'Obsidian'},
	{ key = '/', mod = {}, app = 'Activiry Monitor'},
        { key = ',', mod = {}, app = 'System Preferences'},
}

do  -- winmove
    local win_move = require('modules.winmove')
    local mode = app_mode

    mode:bind({}, '0', win_move.default)
    mode:bind({'shift'}, '0', win_move.move(1/6, 0, 4/6, 1))
    mode:bind({}, '1', win_move.left_bottom)
    mode:bind({}, '2', win_move.bottom)
    mode:bind({}, '3', win_move.right_bottom)
    mode:bind({}, '4', win_move.left)
    mode:bind({'shift'}, '4', win_move.move(0, 0, 2/3, 1))
    mode:bind({'ctrl'}, '4', win_move.move(0, 0, 1/3, 1))
    mode:bind({}, '5', win_move.full_screen)
    mode:bind({}, '6', win_move.right)
    mode:bind({'shift'}, '6', win_move.move(1/3, 0, 2/3, 1))
    mode:bind({'ctrl'}, '6', win_move.move(2/3, 0, 1/3, 1))
    mode:bind({}, '7', win_move.left_top)
    mode:bind({}, '8', win_move.top)
    mode:bind({}, '9', win_move.right_top)
    mode:bind({}, '-', win_move.prev_screen)
     mode:bind({}, '=', win_move.next_screen)
    -- mode:bind({}, 'left', win_move.move_relative(-10, 0), function() end, win_move.move_relative(-10, 0))
    -- mode:bind({}, 'right', win_move.move_relative(10, 0), function() end, win_move.move_relative(10, 0))
    -- mode:bind({}, 'up', win_move.move_relative(0, -10), function() end, win_move.move_relative(0, -10))
    -- mode:bind({}, 'down', win_move.move_relative(0, 10), function() end, win_move.move_relative(0, 10))
end

require('modules.vim')

function mod_key(tb)
    if 'table' ~= type(tb) then
        return ''
    end
    found = ''
    for _, v in pairs(tb) do
        found = found..v
    end 
    if found == '' then
    	return ''
    end 
    return found..'+'
end 

hs.hotkey.bind({}, 'F15', function ()
-- 	local help_string = ''
--	for _, value in next, app_map do
--		help_string = help_string..(mod_key(value["mod"])..value["key"] .. " : " .. value["app"].. "\n")
--	end
--	hs.alert.show(help_string, 5)
    hs.alert.showWithImage('', hs.image.imageFromPath('~/Downloads/vim2.webp'), 5)
end)


-- vim esc to English
local caps_mode = hs.hotkey.modal.new()
local inputEnglish = "com.apple.keylayout.ABC"


local on_caps_mode = function()
    caps_mode:enter()
end

local off_caps_mode = function()
    caps_mode:exit()

    local input_source = hs.keycodes.currentSourceID()
    

    if not (input_source == inputEnglish) then
        hs.eventtap.keyStroke({}, 'right')
        hs.keycodes.currentSourceID(inputEnglish)
        hs.eventtap.keyStroke({}, 'escape')
    end

    hs.eventtap.keyStroke({},'escape')

end

hs.hotkey.bind({}, 'f16', on_caps_mode, off_caps_mode)
