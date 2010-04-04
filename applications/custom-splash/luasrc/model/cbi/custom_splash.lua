--[[
This file has been modified by
Andreas Pittrich <andreas.pittrich@web.de>
in behalf of the german pirate party (Piratenpartei)
www.piratenpartei.de

Original Disclaimer:
-------
LuCI - Lua Configuration Interface

Copyright 2008 Steven Barth <steven@midlink.org>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

$Id$
]]--

luci.i18n.loadc("freifunk")
local uci = require "luci.model.uci".cursor()
local fs = require "luci.fs"

m = Map("custom_splash", "Custom Splash")

d = m:section(NamedSection, "splash", "custom", "Custom Splash")
active=d:option(Flag, "active", "Custom Splash benutzen?")
active.widget="checkbox"

dpos=d:option(ListValue, "position", "Position des Disclaimers")
dpos:value("top", "oben")
dpos:value("left", "links")
dpos:value("right", "rechts")
dpos:value("bottom", "unten")

html=d:option(TextValue, "html", "HTML")
html.rows="30"
function html.cfgvalue(self, section)
	cs=fs.readfile("custom_splash.htm")
	if cs == nil then
		return ""
	else 
		return cs
	end
end

function html.write(self, section, value)
	fs.writefile("custom_splash.htm",value)
end



return m
