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

m = Map("freifunk", "Heartbeat")

d = m:section(NamedSection, "heartbeat", "settings", "Heartbeat")
hbm=d:option(ListValue, "mode", "Heartbeatmodus")
hbm.widget="radio"
hbm.size=1
uci:foreach("freifunk", "heartbeat_mode", function(s)
	hbm:value(s[".name"], "%s (%s)" %{s.name, s.description})
end)
return m
