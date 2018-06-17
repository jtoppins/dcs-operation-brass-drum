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


-- Redfor IADS Setup

iran_border = ZONE_POLYGON:New("Iran Border", GROUP:FindByName("Iran Border"))

red_ewr_grp = SET_GROUP:New()
red_ewr_grp:FilterPrefixes({"", ""})
red_ewr_grp:FilterStart()

red_ewr = DETECTION_AREAS:New(red_ewr_grp, 60000)

red_dispatcher = AI_A2A_DISPATCHER:New(red_ewr)
red_dispatcher:SetBorderZone(iran_border)
red_dispatcher:SetEngageRadius(148160) -- 80 nm
red_dispatcher:SetGciRadius(231500)    -- 125 nm
red_dispatcher:SetDefaultTakeoffFromRunway()
red_dispatcher:SetDefaultLandingAtEngineShutdown()
red_dispatcher:SetDefaultOverhead(1)
red_dispatcher:SetDefaultGrouping(2)
red_dispatcher:SetDefaultFuelThreshold(.35)
red_dispatcher:SetDefaultDamageThreshold(.80)
red_dispatcher:SetDefaultCapLimit(1)
red_dispatcher:SetDefaultCapTimeInterval(900, 2700)
red_dispatcher:SetIntercept(450)
red_dispatcher:SetDisengageRadius(324100)  -- 175 nm

-- Bandar Abbas Squadron setup (Mig-21 squadron)
sqdname = "abbas_cap"
red_dispatcher:SetSquadron(sqdname, "Bandar Abbas",
                           {"abbas_cap_mig21_novice", "abbas_cap_mig21_std"},
			   14)
abbas_cap_zone = ZONE_POLYGON:NewFromGroupName("abbas_cap_zone", "abbas cap zone")
red_dispatcher:SetSquadronCap(sqdname, abbas_cap_zone,
			      9449, 10058, -- 31k to 33k feet
			      1102, 1139,  -- 595 to 615 knots ground speed
                              1102, 1518,  -- 595 to 819 knots ground speed
			      "BARO")
red_dispatcher:SetSquadronCapInterval(sqdname, 2, 600, 1800, 0)
red_dispatcher:SetSquadronGci(sqdname, 1102, 1518)

-- Qeshm Squadron setup (Mig-29A squadron)
sqdname = "qeshm_cap"
red_dispatcher:SetSquadron(sqdname, "Qeshm",
                           {"qeshm_cap_mig29_novice", "qeshm_cap_mig29_std"},
			   8)
jask_cap_zone = ZONE_POLYGON:NewFromGroupName("jask_cap_zone", "jask cap zone")
red_dispatcher:SetSquadronCap(sqdname, jask_cap_zone,
			      9449, 10058, -- 31k to 33k feet
			      1102, 1139,  -- 595 to 615 knots ground speed
                              1102, 1518,  -- 595 to 819 knots ground speed
			      "BARO")
red_dispatcher:SetSquadronCapInterval(sqdname, 1, 600, 1800, 0)

-- ?? Squadron setup (Mig-29A squadron)
sqdname = "??_cap" -- TODO: fix name
red_dispatcher:SetSquadron(sqdname, "??",
                           {"cap_f14a_novice", "cap_f14a_std"},
			   8)
cap_zone = ZONE_POLYGON:NewFromGroupName("cap_zone", "cap zone")
red_dispatcher:SetSquadronCap(sqdname, jask_cap_zone,
			      9449, 10058, -- 31k to 33k feet
			      1102, 1139,  -- 595 to 615 knots ground speed
                              1102, 1518,  -- 595 to 819 knots ground speed
			      "BARO")
red_dispatcher:SetSquadronCapInterval(sqdname, 2, 600, 1800, 0)
red_dispatcher:SetSquadronLandingAtRunway(sqdname)
red_dispatcher:SetSquadronFuelThreshold(sqdname, .45)
red_dispatcher:SetSquadronOverhead(sqdname, .5)

-- Setup Redfor AWACS Respawn - max 3 a/c only 1 up at any one time
red_awacs = SPAWN:New("red awacs")
red_awacs:InitLimit(1, 3)
red_awacs:InitRepeatOnLanding()
red_awacs:SpawnScheduled(300, .2)

-- Setup Redfor Tanker Respawn - max 3 a/c only 1 up at any one time
red_tanker = SPAWN:New("red tanker")
red_tanker:InitLimit(1, 3)
red_tanker:InitRepeatOnLanding()
red_tanker:SpawnScheduled(300, .2)


-- blue_ewr_grp = SET_GROUP:New()
-- blue_ewr_grp:FilterPrefixes({"CVN AWACS", "Stennis CVBG",
--                              "Tarawa ARG", "Bunker Hill SAG"})
-- blue_ewr_grp:FilterStart()

-- blue_ewr = DETECTION_AREAS:New(blue_ewr_grp, 60000)

-- blue_dispatcher = AI_A2A_DISPATCHER:New(blue_ewr)
-- blue_dispatcher:SetEngageRadius(166680)
-- blue_dispatcher:SetGciRadius(277800)
