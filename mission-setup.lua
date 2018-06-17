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


-- Redfor IADS Setup

iran_border = ZONE_POLYGON:New("Iran Border", GROUP:FindByName("iran border"))

red_ewr_grp = SET_GROUP:New()
red_ewr_grp:FilterPrefixes({
	"Bander Abbas West", "Jask North", "Kuh-e Genow", -- ewr sites
	"SAM Bn SA-10", "Jask SA-11 Btry", "SAM Bn SA-6",
	"SAM Hq SA-2 Bn"
})
red_ewr_grp:FilterStart()

red_ewr = DETECTION_AREAS:New(red_ewr_grp, 60000)

red_dispatcher = AI_A2A_DISPATCHER:New(red_ewr)
red_dispatcher:SetBorderZone(iran_border)
red_dispatcher:SetEngageRadius(148160) -- 80 nm
red_dispatcher:SetGciRadius(148160)    -- 80 nm
red_dispatcher:SetDefaultTakeoffFromRunway()
red_dispatcher:SetDefaultLandingAtEngineShutdown()
red_dispatcher:SetDefaultOverhead(1)
red_dispatcher:SetDefaultGrouping(2)
red_dispatcher:SetDefaultFuelThreshold(.35)
red_dispatcher:SetDefaultDamageThreshold(.80)
red_dispatcher:SetDefaultCapLimit(1)
red_dispatcher:SetDefaultCapTimeInterval(600, 1800)
red_dispatcher:SetIntercept(450)
red_dispatcher:SetDisengageRadius(370400)  -- 200 nm

-- Bandar Abbas Squadron setup (Mig-21 squadron)
sqdname = "cap_abbas"
red_dispatcher:SetSquadron(sqdname, "Bandar Abbas Intl",
		{"abbas_cap_mig21_novice", "abbas_cap_mig21_std"},
		14)
cap_zone_abbas = ZONE_POLYGON:NewFromGroupName("cap_zone_abbas",
		"cap zone abbas")
red_dispatcher:SetSquadronCap(sqdname, cap_zone_abbas,
		11582, 13411, -- 38k to 44k feet
		1363, 1602,  -- 736 (400) to 865 (470) KTAS (KIAS)
		1363, 1704,  -- 736 (400) to 920 (500) KTAS (KIAS)
		"BARO")
red_dispatcher:SetSquadronCapInterval(sqdname, 2, 600, 1800, 0)
red_dispatcher:SetSquadronGci(sqdname, 900, 1200)

-- Qeshm Squadron setup (Mig-29A squadron)
sqdname = "cap_qeshm"
red_dispatcher:SetSquadron(sqdname, "Qeshm Island",
		{"qeshm_cap_mig29_novice", "qeshm_cap_mig29_std"},
		6)
cap_zone_jask = ZONE_POLYGON:NewFromGroupName("cap_zone_jask",
		"cap zone jask")
red_dispatcher:SetSquadronCap(sqdname, cap_zone_jask,
		9449, 10058, -- 31k to 33k feet
		1102, 1139,  -- 595 (365) to 615 (375) KTAS (KIAS)
		1102, 1518,  -- 595 (365) to 819 (500) knots ground speed
		"BARO")

-- Lar Squadron setup (F-14A squadron)
sqdname = "cap_lar"
red_dispatcher:SetSquadron(sqdname, "Lar Airbase",
		{"cap_f14a_novice", "cap_f14a_std"},
		8)
cap_zone_f14 = ZONE_POLYGON:NewFromGroupName("cap_zone_f14",
		"cap zone f14")
red_dispatcher:SetSquadronCap(sqdname, cap_zone_f14,
		9449, 10058, -- 31k to 33k feet
		1102, 1139,  -- 595 (365) to 615 (375) KTAS (KIAS)
		1102, 1518,  -- 595 (365) to 819 (500) knots ground speed
		"BARO")
red_dispatcher:SetSquadronCapInterval(sqdname, 2, 600, 1800, 0)
red_dispatcher:SetSquadronLandingAtRunway(sqdname)
red_dispatcher:SetSquadronTanker(sqdname, "red tanker")
red_dispatcher:SetSquadronOverhead(sqdname, .5)

-- Setup Redfor AWACS Respawn - max 3 a/c only 1 up at any one time
red_awacs = SPAWN:New("red awacs")
red_awacs:InitLimit(1, 3)
red_awacs:SpawnAtAirBase(AIRBASE:FindByName("Bandar Abbas Intl"),
		SPAWN.Takeoff.Cold)
red_awacs:InitRepeatOnLanding()
red_awacs:SpawnScheduled(300, .2)

-- Setup Redfor Tanker Respawn - max 3 a/c only 1 up at any one time
red_tanker = SPAWN:New("red tanker")
red_tanker:InitLimit(1, 3)
red_tanker:SpawnAtAirBase(AIRBASE:FindByName("Lar Airbase"),
		SPAWN.Takeoff.Runway)
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
