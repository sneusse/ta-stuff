# ta-stuff
Textadept stuff for you to play with

## [init.lua](init.lua)

This file contains my init.lua contents and should serve as an example for the multiedit module.
Please don't mind my other weird keybindings :>

## [multiedit.lua](multiedit.lua)

This is a drop-in replacement for most of the text navigation (cleft, cright, csleft, csright, ...) supporting multiple cursors. The behaviour mimics the one of sublime (or the one I would expect).

`buffer.multi_paste = buffer.MULTIPASTE_EACH` could be set, but does not work as expected imho. 

There is one parameter to tune (`STAY_IN_LINE`) which will prevent the user from navigating beyond the end or before the start of the line containing the selection. True is the default as i prefer this behaviour.
