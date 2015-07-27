-- additional modules
	
local multiedit = require'multiedit'
local textredux = require'textredux'

local editing = textadept.editing

textredux.hijack()

-- helper functions

local last_dir = nil
local snapopen_woot = function()
	local directory = io.get_project_root() or (buffer.filename and buffer.filename:match('^(.+)[/\\]')) or last_dir or _USERHOME
  last_dir = directory
	textredux.fs.snapopen(directory, filter, exclude_FILTER)
end

local print = function(...)
	local tmp = ui.SILENT_PRINT
	ui.SILENT_PRINT = true
	ui.print(...)
	ui.SILENT_PRINT = tmp
end

-- parameters

io.SNAPOPEN_MAX = 10000
editing.AUTOCOMPLETE_ALL = true

-- events

events.connect(events.LEXER_LOADED, function(lang)
	buffer.tab_width = 4
	buffer.use_tabs = true
	buffer.auto_c_ignore_case = true
	editing.AUTOCOMPLETE_ALL = true
end)

events.connect(events.DOUBLE_CLICK, function(lang)
	editing.highlight_word()
end)

-- keys

keys.cp = snapopen_woot

keys['c '] = {editing.autocomplete, 'word'}
keys.ac = {ui.command_entry.enter_mode, 'lua_command', 'lua'}
keys.cq = editing.block_comment
keys.ar = reset
keys['c.'] = {ui.goto_view, 1, true}
keys['c,'] = {ui.goto_view, -1, true}


-- why we need modifiers? 
keys['"'] = {multiedit.enclose, '"', '"'}
keys["'"] = {multiedit.enclose, "'", "'"}
keys["("] = {multiedit.enclose, "(", ")"}
keys["["] = {multiedit.enclose, "[", "]"}
keys["{"] = {multiedit.enclose, "{", "}"}

-- mimics sublimes ctrl-d
keys.cd = multiedit.select_word
keys.af3 = multiedit.select_all_words

-- exchange all standard bindings with the multiedit version
keys['\n'] = multiedit.newline
keys.left = multiedit.char_left
keys.cleft = multiedit.word_left
keys.sleft = multiedit.char_left_extend
keys.csleft = multiedit.word_left_extend
keys.right = multiedit.char_right
keys.sright = multiedit.char_right_extend
keys.cright = multiedit.word_right
keys.csright = multiedit.word_right_extend
keys.home = multiedit.line_start
keys.shome = multiedit.line_start_extend
keys["end"] = multiedit.line_end
keys["send"] = multiedit.line_end_extend

-- i'm not sure how to handle these events yet...
-- just be careful for now :>

--keys.sup = multiedit.prevent_crap
--keys.sdown = multiedit.prevent_crap
--keys.spgup = multiedit.prevent_crap
--keys.spgdn = multiedit.prevent_crap
--keys.csup = multiedit.prevent_crap
--keys.csdown = multiedit.prevent_crap
