-- Operation Brass Drum - MOOSE mission setup script
-- Copyright (C) 2018 Jonathan Toppins <jtoppins@users.sourceforge.net>
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.
--

-- TODO:
-- setup iran boarder
-- setup ewr group
-- setup squadrons

iran_border = ZONE_POLYGON:New("Iran Border", GROUP:FindByName("Iran Border"))

red_ewr_grp = SET_GROUP:New()
red_ewr_grp:FilterPrefixes({"", ""})
red_ewr_grp:FilterStart()

red_ewr = DETECTION_AREAS:New(red_ewr_grp, 60000)

red_dispatcher = AI_A2A_DISPATCHER:New(red_ewr)
red_dispatcher:SetBorderZone(iran_border)
red_dispatcher:SetEngageRadius(148160)
red_dispatcher:SetGciRadius(555600)
red_dispatcher:SetDefaultTakeoffFromRunway()
red_dispatcher:SetDefaultLandingAtEngineShutdown()
red_dispatcher:SetDefaultOverhead(1)
red_dispatcher:SetDefaultGrouping(2)
red_dispatcher:SetDefaultFuelThreshold(.35)
red_dispatcher:SetDefaultDamageThreshold(.80)
red_dispatcher:SetDefaultCapLimit(1)
red_dispatcher:SetDefaultCapTimeInterval(900, 2700)
red_dispatcher:SetIntercept(450)
red_dispatcher:SetDisengageRadius(277800)

-- Squadron setup
red_dispatcher:SetSquadron("Abbas", AIRBASE.PursanGulf.foobar,
                           {"template1", "template2"},
			   14)
-- red_dispatcher:SetSquadronGrouping("a", 2)
-- red_dispatcher:SetSquadronOverhead("a", .5)
-- red_dispatcher:SetSquadronFuelThreshold("a", .35)
cap_zone = ZONE_foo:New("name", GROUP:FindByName("Name"))
red_dispatcher:SetSquadronCap("a", cap_zone, 9449, 10058, 1102, 1139,
                              1102, 1518 , "BARO")
-- red_dispatcher:SetSquadronCapInterval("a", 1, 900, 2700, 0)



-- blue_ewr_grp = SET_GROUP:New()
-- blue_ewr_grp:FilterPrefixes({"CVN AWACS", "Stennis CVBG",
--                              "Tarawa ARG", "Bunker Hill SAG"})
-- blue_ewr_grp:FilterStart()

-- blue_ewr = DETECTION_AREAS:New(blue_ewr_grp, 60000)

-- blue_dispatcher = AI_A2A_DISPATCHER:New(blue_ewr)
-- blue_dispatcher:SetEngageRadius(166680)
-- blue_dispatcher:SetGciRadius(277800)
