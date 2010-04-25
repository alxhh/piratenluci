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

m = Map("freifunk", "Custom Splash")

d = m:section(NamedSection, "custom_splash", "settings", "Custom Splash")

----------------

active=d:option(ListValue, "mode", "Custom Splash benutzen?")
active.widget="radio"
active.size=1
active:value("enabled", "Ja")
active:value("disabled", "Nein")

msg=d:option(ListValue, "messages", "Nachrichten aktivieren?")
msg.widget="radio"
msg.size=1
msg:value("enabled", "Ja")
msg:value("disabled", "Nein")

----------------

header=d:option(TextValue, "header", "Custom Header")
header.rows="20"
function header.cfgvalue(self, section)
	cs=fs.readfile("/lib/uci/upload/custom_header.htm")
	if cs == nil then
		return ""
	else 
		return cs
	end
end

function header.write(self, section, value)
	fs.writefile("/lib/uci/upload/custom_header.htm",value)
end

----------------

footer=d:option(TextValue, "footer", "Custom Footer")
footer.rows="20"
function footer.cfgvalue(self, section)
	cs=fs.readfile("/lib/uci/upload/custom_footer.htm")
	if cs == nil then
		return ""
	else 
		return cs
	end
end

function footer.write(self, section, value)
	fs.writefile("/lib/uci/upload/custom_footer.htm",value)
end



return m
