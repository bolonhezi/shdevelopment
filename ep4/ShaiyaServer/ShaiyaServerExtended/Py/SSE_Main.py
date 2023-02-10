def OnStartup():
	print("Loading core func...")
	return "05Shaiya Europe Console 2.1"

def OnCommand(Cmd, oj, etype, Charname, UserUID, Status, country, charid, arg1, arg2, arg3, arg4, optn, posx, pozy, posz, map, charlevel, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10):
	#AlertServer(Cmd)
	ret = ""
	if Cmd == "instantlvl":	
		ret = "000"
		args = oj.split(" ")
		if 1 < len(args):
			lvl = args[1]
			lvl = int(lvl)		
			slvl = [15,30,60, 70, 80]
			if lvl in slvl:	
				#AlertPlayer("You issued instant level "+str(lvl),Charname)				
				#getting LegacyMode var
				connection = SqlConnection(SSE_GetPyConnString())
				connection.Open()
				command = connection.CreateCommand()
				command.CommandText = """SELECT Level,LegacyMode,Grow FROM PS_GameData.dbo.Chars WHERE CharID = @CharID"""
				command.Parameters.Add(SqlParameter("@CharID", charid))
				CharID = int(charid)
				LegacyMode = 0
				Level = 0
				Grow = 0
				reader = command.ExecuteReader()
				while reader.Read():
					LegacyMode = LegacyMode + int(reader["LegacyMode"])
					Level = Level + int(reader["Level"])
					Grow = Grow + int(reader["Grow"])
				connection.Close()
				if LegacyMode == 2 and Grow < 3:
					MapID = 0
					PosX = 0
					PosZ = 0
					PosZ = 0
					AlertPlayer("Valid instant lvl from level: "+str(Level)+" to level: "+str(lvl),Charname)
					connection.Open()
					command = connection.CreateCommand()
					command.CommandText = """SELECT Job, Str, Dex, Rec, Int, Luc, Wis FROM PS_GameData.dbo.Chars WHERE CharID = @CharID"""
					command.Parameters.Add(SqlParameter("@CharID", charid))
					reader = command.ExecuteReader()
					Job = 0
					Str = 0
					Dex = 0 
					Rec = 0 
					Int = 0 
					Luc = 0 
					Wis = 0
					while reader.Read():
						Job = Job + int(reader["Job"])
						Str = Str + int(reader["Str"])
						Dex = Dex + int(reader["Dex"])
						Rec = Rec + int(reader["Rec"])
						Int = Int + int(reader["Int"])
						Luc = Luc + int(reader["Luc"])
						Wis = Wis + int(reader["Wis"])
					connection.Close()
					#
					connection.Open()
					command = connection.CreateCommand()
					command.CommandText = """SELECT	Country FROM PS_GameData.dbo.UserMaxGrow WHERE UserUID = @UserUID"""
					command.Parameters.Add(SqlParameter("@UserUID", UserUID))
					reader = command.ExecuteReader()
					Country = 0
					while reader.Read():		
						Country = Country + int(reader["Country"])
					connection.Close()
					MapID = 0
					PosX = ""
					PosY = "" 
					PosZ = "" 
					SkillPoint = lvl * 4
					StatPoint = (lvl - 1) * 7
					if Job == 0:
						Str = Str + (lvl - 1)
					elif Job == 1:
						Rec = Rec + (lvl - 1)
					elif Job == 2:
						Dex = Dex + (lvl - 1)
					elif Job == 3:
						Luc = Luc + (lvl - 1)	
					elif Job == 4:
						Int = Int + (lvl - 1)
					elif Job == 5:
						Wis = Wis + (lvl - 1)	
					if lvl == 15:
						MapID = 18
						if Country == 0:
							PosX = "405.350" 
							PosY = "19.539" 
							PosZ = "139.040" 
						else:
							PosX = "859.41" 
							PosY = "2.000" 
							PosZ = "641.34"
					elif lvl == 30:
						MapID = 30
						if Country == 0:
							PosX = "307.950" 
							PosY = "2.028" 
							PosZ = "314.250"
						else:
							PosX = "813.370" 
							PosY = "31.420" 
							PosZ = "752.440" 
					elif lvl == 60:
						MapID = 0
						if Country == 0:
							PosX = "217.840"
							PosY = "25.560" 
							PosZ = "1833.700" 
						else:
							PosX = "1877.100" 
							PosY = "13.891" 
							PosZ = "374.270"
					elif lvl == 70:
						MapID = 70
						if Country == 0:
							PosX = "1145.23"
							PosY = "32.26" 
							PosZ = "163.25" 
						else:
							PosX = "155.23" 
							PosY = "35.42" 
							PosZ = "58.00"
					elif lvl == 80:
						MapID = 81
						if Country == 0:
							PosX = "350.636"
							PosY = "16.865" 
							PosZ = "58.000" 
						else:
							PosX = "406.925" 
							PosY = "16.883" 
							PosZ = "62.595"
					thread.start_new_thread(UpdateChar, (charid, MapID, PosX, PosY, PosZ, lvl, SkillPoint, StatPoint, Str, Dex, Rec, Luc, Wis, Int,Charname))		
				else:
					AlertPlayer("Your Character is UM, or you already used the !instantlvl in the past.",Charname)
			else:
				AlertPlayer("Unsuported lvl, please choose level 15, 30, 60, 70 or 80",Charname)
		else:
			AlertPlayer("Unsuported arugment, must be level 15 30, 60, 70 or 80",Charname)
	elif Cmd == "uc":
		connection = SqlConnection(SSE_GetPyConnString())
		connection.Open()
		command = connection.CreateCommand()
		command.CommandText = """SELECT COUNT(*) AS Counter FROM PS_GameData.dbo.Chars WHERE LoginStatus = 1"""
		Count = 0
		reader = command.ExecuteReader()
		while reader.Read():
			Count = Count + int(reader["Counter"])
		connection.Close()
		AlertPlayer("There is currently "+str(Count)+" online players.",Charname)
		ret = "000"
	elif Cmd == "grbrank":
		connection = SqlConnection(SSE_GetPyConnString())
		connection.Open()
		command = connection.CreateCommand()
		command.CommandText = """SELECT TOP 5 * FROM PS_GameData.dbo.Guilds ORDER BY GuildPoint,TotalCount Desc"""
		reader = command.ExecuteReader()
		Count = 0
		while reader.Read():
			Count = Count + 1
			if int(reader["Country"]) == 0:
				AlertPlayer(str(Count) + ". AOL - "+reader["GuildName"]+" | Members: "+str(reader["TotalCount"])+" | Points: "+str(reader["GuildPoint"])+" ",Charname)
			else:
				AlertPlayer(str(Count) + ". UOF - "+reader["GuildName"]+" | Members: "+str(reader["TotalCount"])+" | Points: "+str(reader["GuildPoint"])+" ",Charname)
		connection.Close()
		ret = "000"
	elif Cmd == "credits":
		AlertPlayer("*~=~=~=~=~=~=~=~=~*",Charname)
		AlertPlayer("Shaiya Europe",Charname)
		AlertPlayer("(c) Lyros Games and Mo 2012-2017",Charname)
		AlertPlayer("*~=~=~=~=~=~=~=~=*",Charname)
		ret = "000"
	elif Cmd == "skillp":
		connection = SqlConnection(SSE_GetPyConnString())
		connection.Open()
		command = connection.CreateCommand()
		command.CommandText = """SELECT UseSP FROM PS_GameData.dbo.Chars WHERE CharID = @CharID"""
		command.Parameters.Add(SqlParameter("@CharID", charid))
		reader = command.ExecuteReader()
		Count = 0
		while reader.Read():
			Count = Count + int(reader["UseSP"])
		AlertPlayer("You already used "+str(Count)+" / 5 Skill Potions.",Charname)
		ret = "000"
	elif Cmd == "info":
		ret = "000"
		if len(oj) < 6:
			oj = "info idontknow"
			AlertPlayer("Please use !info playername, you didn't provided any playername.",Charname)
		args = oj.split(" ")
		charn = args[1]
		connectionlvl = SqlConnection(SSE_GetPyConnString())
		connectionlvl.Open()
		command = connectionlvl.CreateCommand()
		command.CommandText = """SELECT * FROM PS_GameData.dbo.Chars WHERE CharID = @CharID"""
		command.Parameters.Add(SqlParameter("@CharID", charid))
		readerlvl = command.ExecuteReader()
		CurrentLvl = 0
		while readerlvl.Read():
			CurrentLvl = readerlvl["Level"]
		connection = SqlConnection(SSE_GetPyConnString())
		connection.Open()
		command = connection.CreateCommand()
		command.CommandText = """SELECT TOP 1 CharName, Level, Country, LoginStatus  FROM PS_GameData.dbo.Chars AS A INNER JOIN PS_GameData.dbo.UserMaxGrow AS B ON A.UserUID = B.UserUID WHERE CharName = @CharName AND A.Del = 0"""
		command.Parameters.Add(SqlParameter("@CharName", charn))
		reader = command.ExecuteReader()
		Count = 0
		while reader.Read():
			Count = Count + 1
			Fstr = ""
			if int(reader["Country"]) == 0:
				Fstr = "Light"
			else:
				Fstr = "Dark"
			AlertPlayer("Selected character is: "+str(reader["CharName"]), Charname)
			AlertPlayer("Level: "+str(reader["Level"]),Charname)
			AlertPlayer("Faction: "+str(Fstr),Charname)
			if(int(reader["LoginStatus"]) != 0):
				AlertPlayer("Status: Online :)",Charname)
			else:
				AlertPlayer("Status: Offline :(",Charname)
			if((int(CurrentLvl) - int(reader["Level"])) < 6):
				AlertPlayer("-> YOU CAN KILL HIM <-",Charname)
			else:
				AlertPlayer("> /!\ YOU CAN NOT KILL HIM <-",Charname)
		connectionlvl.Close()
		connection.Close()
		if Count == 0:
			AlertPlayer("Character was not found in our database, please check the character name again.",Charname)	
	elif Cmd == "punish":
		ret = "000"
		if len(oj) < 8:
			oj = "punish idontknow"
			AlertPlayer("Please use !punish playername, you didn't provided any playername.",Charname)
		args = oj.split(" ")
		charn = args[1]
		connection = SqlConnection(SSE_GetPyConnString())
		connection.Open()
		command = connection.CreateCommand()
		command.CommandText = """SELECT * FROM [PS_GameData].[dbo].[IllegalKiller] WHERE Killer_Name = @Killer_Name AND Death_Name = @Death_Name AND IsPunished = 'False'"""
		command.Parameters.Add(SqlParameter("@Killer_Name", charn))
		command.Parameters.Add(SqlParameter("@Death_Name", Charname))
		reader = command.ExecuteReader()
		Count = 0
		while reader.Read():
			Count = Count + 1
		connection.Close()
		if Count == 0:
			AlertPlayer("Selected player didn't killed you illegelly.",Charname)
		else:
			AlertPlayer(charn + " killed you illegally, you want to punish him...",Charname)
			KickChar(charn)
			AlertServer(charn + " was kicked by "+Charname+ " because of an illegal kill")
			connection.Open()
			command = connection.CreateCommand()
			command.CommandText = """UPDATE [PS_GameData].[dbo].[IllegalKiller] SET IsPunished = 'True' WHERE Killer_Name = @Killer_Name AND Death_Name = @Death_Name"""
			command.Parameters.Add(SqlParameter("@Killer_Name", charn))
			command.Parameters.Add(SqlParameter("@Death_Name", Charname))
			reader = command.ExecuteReader()
			connection.Close()
	elif Cmd == "forgive":
		ret = "000"
		if len(oj) < 9:
			oj = "forgive idontknow"
			AlertPlayer("Please use !forgive playername, you didn't provided any playername.",Charname)
		args = oj.split(" ")
		charn = args[1]
		connection = SqlConnection(SSE_GetPyConnString())
		connection.Open()
		command = connection.CreateCommand()
		command.CommandText = """SELECT * FROM [PS_GameData].[dbo].[IllegalKiller] WHERE Killer_Name = @Killer_Name AND Death_Name = @Death_Name AND IsPunished = 'False'"""
		command.Parameters.Add(SqlParameter("@Killer_Name", charn))
		command.Parameters.Add(SqlParameter("@Death_Name", Charname))
		reader = command.ExecuteReader()
		Count = 0
		while reader.Read():
			Count = Count + 1
		connection.Close()
		if Count == 0:
			AlertPlayer("Selected player didn't killed you illegelly.",Charname)
		else:
			AlertPlayer(charn + " killed you illegally, you want to forgive him...",Charname)
			AlertServer(charn + " was forgiven by "+Charname+ " because of an illegal kill")
			connection.Open()
			command = connection.CreateCommand()
			command.CommandText = """UPDATE [PS_GameData].[dbo].[IllegalKiller] SET IsPunished = 'True' WHERE Killer_Name = @Killer_Name AND Death_Name = @Death_Name"""
			command.Parameters.Add(SqlParameter("@Killer_Name", charn))
			command.Parameters.Add(SqlParameter("@Death_Name", Charname))
			reader = command.ExecuteReader()
			connection.Close()			
	elif Cmd == "help":
		AlertPlayer("Current commands: !grbrank !help !uc !instantlvl !credits !skillp !info !punish !forgive",Charname)
		#load_all_modules_from_dir();
		ret = "000"
	else:
		ret = ""
	return ret

def OnEvent(etype, Charname, dbstring, UserUID, Status, country, charid, arg1, arg2, arg3, arg4, optn, posx, pozy, posz, map, charlevel, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10):
	#REGION: First Login Notices
	connection = SqlConnection(SSE_GetPyConnString())
	connection.Open()
	command = connection.CreateCommand()
	command.CommandText = """SELECT ActionCount,LegacyMode,Grow,UseSP FROM PS_GameData.dbo.Chars WHERE CharID = @CharID"""
	command.Parameters.Add(SqlParameter("@CharID", charid))
	CharID = int(charid)
	ActionCount = 0
	LegacyMode = 0
	Grow = 0
	UseSP = 0
	reader = command.ExecuteReader()
	while reader.Read():
		ActionCount = ActionCount + int(reader["ActionCount"])
		LegacyMode = LegacyMode + int(reader["LegacyMode"])
		Grow = int(reader["Grow"])
		UseSP =  int(reader["UseSP"])
	connection.Close()
	#
	connection.Open()
	command = connection.CreateCommand()
	command.CommandText = """SELECT B.IsNew,A.Country FROM PS_UserData.dbo.Users_Master AS B INNER JOIN PS_GameData.dbo.UserMaxGrow as A on B.UserUID = A.UserUID WHERE B.UserUID = @UserUID"""
	command.Parameters.Add(SqlParameter("@UserUID", UserUID))
	reader = command.ExecuteReader()
	IsNew = 0
	Country = 0
	while reader.Read():		
		IsNew = IsNew + int(reader["IsNew"])
		Country = Country + int(reader["Country"])
	connection.Close()
	#REGION: On First Login
	if ActionCount == 1:
		connection.Open()
		command = connection.CreateCommand()
		command.CommandText = """UPDATE PS_GameData.dbo.Chars SET ActionCount = ActionCount + 1 WHERE CharID = @CharID"""
		command.Parameters.Add(SqlParameter("@CharID", CharID))
		reader = command.ExecuteReader()
		connection.Close()	
		if LegacyMode == 2 and Grow == 2:
			AlertPlayer("You created an Instant Level Mode Character, type '!instantlvl' xx in normal chat to use it.",Charname)
			AlertPlayer("Without quotes, also replace xx by the level that you want (15 30 60 70 or 80)",Charname)
			AlertPlayer("Once you did it, you'll repop on the wished pvp map with a ready-to-use stuff for free via npc.",Charname)
		else:
			AlertPlayer("You successfully created an Ultimate Mode Character, have fun with it!",Charname)
			AlertPlayer("NOTE: DONT FORGET TO BUY FREE 30D RES RUNE IN ITEM MALL",Charname)
	else:
		connection.Open()
		command = connection.CreateCommand()
		command.CommandText = """UPDATE PS_GameData.dbo.Chars SET ActionCount = ActionCount + 1 WHERE CharID = @CharID"""
		command.Parameters.Add(SqlParameter("@CharID", CharID))
		reader = command.ExecuteReader()
		connection.Close()	
	#END ALL REGIONS
	points = 0	
	if etype == 114:
		ncount = int(value4)
		if arg1 == "EP [5]":
			points = 5 * ncount
		elif arg1 == "EP [10]":
			points = 10 * ncount
		elif arg1 == "EP [50]":
			points = 50 * ncount
		elif arg1 == "EP [100]":
			points = 100 * ncount
		if points != 0:
			#selecing current points
			connection.Open()
			command = connection.CreateCommand()
			command.CommandText = """SELECT Point from PS_UserData.dbo.Users_Master WHERE UserUID=@uid"""
			command.Parameters.Add(SqlParameter("@uid", UserUID))
			npoints = 0
			reader = command.ExecuteReader()
			while reader.Read():
				npoints = reader["Point"]
			connection.Close()
			#notice the player
			AlertPlayer("You sold " + value4 + " x " + arg1 + " and you now have " + str(int(npoints) + points) + " Legacy Points.",int(charid))
			#update his points
			connection.Open()
			command = connection.CreateCommand()
			command.CommandText = """UPDATE PS_UserData.dbo.Users_Master SET Point = Point + @xp WHERE UserUID=@uid"""
			command.Parameters.Add(SqlParameter("@xp", points))
			command.Parameters.Add(SqlParameter("@uid", UserUID))
			ruser = "";
			reader = command.ExecuteReader()
			connection.Close()
		#Skill potion region
		if arg1 == "Skill Point Potion":
			pointperpopo = 3
			if ncount > 1:
				ncount = 1 
				SendItemToUserBank(arg1, UserUID, count=ncount-1)
				AlertPlayer("you sold more than 1 item, we send other items in your bank teller.",int(charid))
			if UseSP > 4:
				AlertPlayer("You used all of you maximum skill point potions <we sent item to bank>",int(charid))
				SendItemToUserBank(arg1, UserUID, count=1)
			else:
				UseSP = UseSP + 1
				KickChar(Charname)
				thread.start_new_thread(UpdateCharS, (charid, pointperpopo, UseSP))
		elif arg1 == "Change Mode Stone":
			if ncount > 1:
				ncount = 1 
				SendItemToUserBank(arg1, UserUID, count=ncount-1)
				AlertPlayer("you sold more than 1 item, we send other items in your bank teller.",int(charid))
			if Grow == 2:
				AlertPlayer("You are now in ULTIMATE MODE, we sent runes in your inventory, please discon/recon.",int(charid))
				connection.Open()
				command = connection.CreateCommand()
				command.CommandText = """UPDATE PS_GameData.dbo.Chars SET Grow = 3 WHERE CharID = @CharID"""
				command.Parameters.Add(SqlParameter("@CharID", charid))
				reader = command.ExecuteReader()
				connection.Close()
				SendItemToUserBank("Skill Reset Stone", UserUID, count=1)
				SendItemToUserBank("Stat Reset Stone", UserUID, count=1)
			else:
				AlertPlayer("This item is for Hard Mode (instant level or basic mode) ONLY! <we sent item in bank>"+str(UserUID),int(charid))
				SendItemToUserBank(arg1, UserUID, count=1)#end
	returnstring = ""
	etype = str(etype)	
	if etype == "103":
		returnstring = "02"+Charname+" has been killed by "+arg1
		deathlvl = 0
		killerlvl = 0
		connection = SqlConnection(SSE_GetPyConnString())
		connection.Open()
		command = connection.CreateCommand()
		command.CommandText = """SELECT SELECT * FROM PS_GameData.dbo.Chars WHERE CharName = @CharName"""
		command.Parameters.Add(SqlParameter("@CharName", Charname))
		reader = command.ExecuteReader()
		while reader.Read():
			deathlvl = int(reader["Level"])
		connection.Close()
		connection.Open()
		command = connection.CreateCommand()
		command.CommandText = """SELECT SELECT * FROM PS_GameData.dbo.Chars WHERE CharName = @CharName"""
		command.Parameters.Add(SqlParameter("@CharName", arg1))
		reader = command.ExecuteReader()
		while reader.Read():
			killerlvl = int(reader["Level"])
		connection.Close()
		if((deathlvl - killerlvl) > 6):
			AlertServer(Charname+ " was illegally killed by "+arg1)
			AlertPlayer("type this in normal chat to punish him: !punish "+arg1)
			connection.Open()
			command = connection.CreateCommand()
			command.CommandText = """SELECT SELECT * FROM [PS_GameData].[dbo].[IllegalKiller] WHERE Killer_Name = @Killer_Name AND Death_Name = @Death_Name"""
			command.Parameters.Add(SqlParameter("@Killer_Name", arg1))
			command.Parameters.Add(SqlParameter("@Death_Name", CharName))
			reader = command.ExecuteReader()
			Count = 0
			while reader.Read():
				Count = Count + 1
			connection.Close()
			if Count == 0:
				connection.Open()
				command = connection.CreateCommand()
				command.CommandText = """INSERT INTO [PS_GameData].[dbo].[IllegalKiller]
			   ([Killer_Name] ,[Death_Name] ,[IsPunished]) VALUES(@Killer_Name,@Death_Name,'False')"""
				command.Parameters.Add(SqlParameter("@Killer_Name", arg1))
				command.Parameters.Add(SqlParameter("@Death_Name", CharName))
				reader = command.ExecuteReader()
				connection.Close()
			else:
				connection.Open()
				command = connection.CreateCommand()
				command.CommandText = """UPDATE [PS_GameData].[dbo].[IllegalKiller] SET IsPunished = 'False' WHERE Killer_Name = @Killer_Name AND Death_Name = @Death_Name"""
				command.Parameters.Add(SqlParameter("@Killer_Name", arg1))
				command.Parameters.Add(SqlParameter("@Death_Name", CharName))
				reader = command.ExecuteReader()
				connection.Close()	
	elif etype == "104":
		returnstring = "02"+Charname+" killed "+arg1
	elif etype == "107":
		returnstring = "12"+Charname+" logged in. (ip: "+arg1+" char info: "+arg3+")."
		connection.Open()
		command = connection.CreateCommand()
		command.CommandText = """UPDATE PS_GameData.dbo.Chars SET [LoginStatus]=1 WHERE PS_GameData.dbo.Chars.CharID=@CharID """
		command.Parameters.Add(SqlParameter("@CharID", int(charid)))
		reader = command.ExecuteReader()
		connection.Close()
	elif etype == "108":
		returnstring = "12"+Charname+" logged out. (ip: "+arg1+" char info: "+arg3+")."
		connection.Open()
		command = connection.CreateCommand()
		command.CommandText = """UPDATE PS_GameData.dbo.Chars SET [LoginStatus]=0 WHERE PS_GameData.dbo.Chars.CharID=@CharID """
		command.Parameters.Add(SqlParameter("@CharID", int(charid)))
		reader = command.ExecuteReader()
		connection.Close()
	elif etype == "111":
		returnstring = "13"+Charname+" acquired "+arg1+"."
	elif etype == "112":
		if arg1 == "Skill Reset Stone":
			AlertPlayer("You reseted all your skills, and your skill potions uses.",int(charid))
			connection.Open()
			command = connection.CreateCommand()
			command.CommandText = """UPDATE PS_GameData.dbo.Chars SET UseSP = 0 WHERE CharID = @CharID"""
			command.Parameters.Add(SqlParameter("@CharID", charid))
			reader = command.ExecuteReader()
			connection.Close()
		returnstring = "13"+Charname+" used "+arg1+"."
	elif etype == "113":
		returnstring = "11"+Charname+" bought "+arg1+" from npc."
	elif etype == "114":
		returnstring = "11"+Charname+" sold "+value4+ " x "+arg1+" to npc."
	elif etype == "121":
		returnstring = "11"+Charname+" stored "+arg1+" in warehouse."
	elif etype == "122":
		returnstring = "11"+Charname+" took "+arg1+" from the warehouse."
	elif etype == "131":
		returnstring = "11"+Charname+" started a quest."
	elif etype == "141":
		returnstring = "15"+Charname+" unlocked a new skill: "+arg1+"."
	elif etype == "146":
		lvl = int(charlevel) + 1
		lvl = str(lvl)	
		connection = SqlConnection(SSE_GetPyConnString())
		connection.Open()
		command = connection.CreateCommand()
		command.CommandText = """SELECT LegacyMode FROM PS_GameData.dbo.Chars WHERE CharID = @CharID"""
		command.Parameters.Add(SqlParameter("@CharID", charid))
		CharID = int(charid)
		LegacyMode = 0
		reader = command.ExecuteReader()
		while reader.Read():
			LegacyMode = LegacyMode + int(reader["LegacyMode"])
		connection.Close()
		returnstring = "07"+Charname+" leveled up to lvl "+lvl+" !"
		if LegacyMode == 2:
			AlertPlayer("Why are you leveling ? You can type '!instantlvl xx' to use the instant leveling (xx = 15,30,60,70 or 80)",Charname)
			AlertPlayer("Type it in game chat ( press ENTER) without quotes, and replace xx by the wished level.",Charname)
	elif etype == "151":
		returnstring = "15"+Charname+" increased STR."	
	elif etype == "152":
		returnstring = "15"+Charname+" increased DEX."
	elif etype == "153":
		returnstring = "15"+Charname+" increased INT."
	elif etype == "154":
		returnstring = "15"+Charname+" increased WIS."
	elif etype == "155":
		returnstring = "15"+Charname+" increased REC."
	elif etype == "156":
		returnstring = "15"+Charname+" increased LUC."
	elif etype == "161":
		returnstring = "03"+Charname+" found money on the ground."
	elif etype == "164":
		returnstring = "03"+Charname+" used a gate keeper: "+arg1+"."
	elif etype == "180":
		returnstring = "14"+Charname+" issued a gm command."
	elif etype == "255":
		if Country == 0:
			thread.start_new_thread(DelayAlertServer, ("Welcome to "+Charname+" who joined Shaiya Europe for the first time ! (Faction: Alliance of Light)",90))
		else:
			thread.start_new_thread(DelayAlertServer, ("Welcome to "+Charname+" who joined Shaiya Europe for the first time ! (Faction: Union of Fury)",90))
		returnstring = "03"+Charname+" joined the server for the first time!."	
	return returnstring;

def OnInput(Cmd, param):
	retstr = ""
	if Cmd == "uc":
		connection = SqlConnection(SSE_GetPyConnString())
		connection.Open()
		command = connection.CreateCommand()
		command.CommandText = """SELECT Count(*) as Counter from PS_GameData.dbo.Chars WHERE LoginStatus = 1"""
		ncount = 0
		reader = command.ExecuteReader()
		while reader.Read():
			ncount = reader["Counter"]
		connection.Close()
		retstr = "14Online players: "+str(ncount)
	elif Cmd == "help":
		retstr = "12Current Commands: \n /help \n /uc"
	return retstr

def OnChat(Charname, map, chatmsg, chattype, country, chanal, mp, cc):
	return "";

def UpdateChar(charid, MapID, PosX, PosY, PosZ, lvl, SkillPoint, StatPoint, Str, Dex, Rec, Luc, Wis, Int,Charname):
	#print "UpdateChar()..."
	time.sleep(2)
	AlertPlayer("You'll be kicked in 10 seconds to apply the instant level",Charname)
	time.sleep(1)
	AlertPlayer("10",Charname)
	time.sleep(1)
	AlertPlayer("9",Charname)
	time.sleep(1)
	AlertPlayer("8",Charname)
	time.sleep(1)
	AlertPlayer("7",Charname)
	time.sleep(1)
	AlertPlayer("6",Charname)
	time.sleep(1)
	AlertPlayer("5",Charname)
	time.sleep(1)
	AlertPlayer("4",Charname)
	time.sleep(1)
	AlertPlayer("3",Charname)
	time.sleep(1)
	AlertPlayer("2",Charname)
	time.sleep(1)
	AlertPlayer("1",Charname)
	time.sleep(1)
	AlertPlayer("Please wait 12 seconds before relog :)",Charname)
	time.sleep(1)
	AlertPlayer("HAVE FUN IN SHAIYA EUROPE",Charname)
	time.sleep(1)
	AlertPlayer("http://shaiya.eu",Charname)
	time.sleep(1)
	KickChar(Charname)
	time.sleep(12)
	#print "Wait end"
	connection = SqlConnection(SSE_GetPyConnString())
	connection.Open()
	command = connection.CreateCommand()
	command.CommandText = """
	UPDATE PS_GameData.dbo.Chars SET Map = @MapID, PosX = @PosX, PosY = @PosY, Posz = @PosZ, StatPoint = @StatPoint, SkillPoint = @SkillPoint, Level = @Level, Str = @Str, Rec = @Rec, Dex = @Dex, Luc = @Luc, Wis = @Wis, Int = @Int, LegacyMode = 0 WHERE CharName = @CharName				
	"""
	command.Parameters.Add(SqlParameter("@CharName", Charname))				
	command.Parameters.Add(SqlParameter("@MapID", MapID))
	command.Parameters.Add(SqlParameter("@PosX", PosX))
	command.Parameters.Add(SqlParameter("@PosY", PosY))
	command.Parameters.Add(SqlParameter("@PosZ", PosZ))
	command.Parameters.Add(SqlParameter("@Level", lvl))
	command.Parameters.Add(SqlParameter("@SkillPoint", SkillPoint))
	command.Parameters.Add(SqlParameter("@StatPoint", StatPoint))
	command.Parameters.Add(SqlParameter("@Str", Str))
	command.Parameters.Add(SqlParameter("@Dex", Dex))
	command.Parameters.Add(SqlParameter("@Rec", Rec))
	command.Parameters.Add(SqlParameter("@Luc", Luc))
	command.Parameters.Add(SqlParameter("@Wis", Wis))
	command.Parameters.Add(SqlParameter("@Int", Int))
	#print "b4"
	reader = command.ExecuteReader()
	connection.Close()	
	# GETTING CHAR INFO
	connection = SqlConnection(SSE_GetPyConnString())
	connection.Open()
	command = connection.CreateCommand()
	command.CommandText = """
	SELECT * FROM PS_GameData.dbo.Chars WHERE CharName = @CharName
	"""
	command.Parameters.Add(SqlParameter("@CharName", Charname))				
	#print "b4"
	reader = command.ExecuteReader()
	Family = 0
	Job = 0
	while reader.Read():
		Family = int(reader["Family"])
		Job = int(reader["Job"])
	HelmetSlotID = 0
	HelmetSlotType = 0
	HelemtSlotTypeID = 0
	#
	ChestSlotID = 0
	ChestSlotType = 0
	ChestSlotTypeID = 0
	#
	PantsSlotID = 0
	PantsSlotType = 0
	PantsSlotTypeID = 0
	#
	GantsSlotID = 0
	GantsSlotType = 0
	GantsSlotTypeID = 0
	#
	BootsSlotID = 0
	BootsSlotType = 0
	BootsSlotTypeID = 0
	#
	WeaponSlotID = 0
	WeaponSlotType = 0
	WeaponSlotTypeID = 0
	#
	CapeSlotID = 0
	CapeSlotType = 0
	CapeSlotTypeID = 0
	if Family == 0:
		if Job == 0:
			#Fighter
			if lvl == 15:
				HelmetSlotID = 16001
				HelmetSlotType = 16
				HelemtSlotTypeID = 1
				#
				ChestSlotID = 17002
				ChestSlotType = 17
				ChestSlotTypeID = 2
				#
				PantsSlotID = 18002
				PantsSlotType = 18
				PantsSlotTypeID = 2
				#
				GantsSlotID = 20002
				GantsSlotType = 20
				GantsSlotTypeID = 2
				#
				BootsSlotID = 21002
				BootsSlotType = 21
				BootsSlotTypeID = 2
				#
				WeaponSlotID = 5013
				WeaponSlotType = 5
				WeaponSlotTypeID = 13
				#
				CapeSlotID = 24077
				CapeSlotType = 24
				CapeSlotTypeID = 77
			if lvl == 30:
				HelmetSlotID = 16017
				HelmetSlotType = 16
				HelemtSlotTypeID = 17
				#
				ChestSlotID = 17002
				ChestSlotType = 17
				ChestSlotTypeID = 8
				#
				PantsSlotID = 18008
				PantsSlotType = 18
				PantsSlotTypeID = 8
				#
				GantsSlotID = 20008
				GantsSlotType = 20
				GantsSlotTypeID = 8
				#
				BootsSlotID = 21008
				BootsSlotType = 21
				BootsSlotTypeID = 8
				#
				WeaponSlotID = 5034
				WeaponSlotType = 5
				WeaponSlotTypeID = 34
				#
				CapeSlotID = 24083
				CapeSlotType = 24
				CapeSlotTypeID = 83
			if lvl == 60:
				HelmetSlotID = 16004
				HelmetSlotType = 16
				HelemtSlotTypeID = 4
				#
				ChestSlotID = 17018
				ChestSlotType = 17
				ChestSlotTypeID = 18
				#
				PantsSlotID = 18018
				PantsSlotType = 18
				PantsSlotTypeID = 18
				#
				GantsSlotID = 20018
				GantsSlotType = 20
				GantsSlotTypeID = 18
				#
				BootsSlotID = 21018
				BootsSlotType = 21
				BootsSlotTypeID = 18
				#
				WeaponSlotID = 5063
				WeaponSlotType = 5
				WeaponSlotTypeID = 63
				#
				CapeSlotID = 24083
				CapeSlotType = 24
				CapeSlotTypeID = 1
			if lvl == 70:
				HelmetSlotID = 16049
				HelmetSlotType = 16
				HelemtSlotTypeID = 49
				#
				ChestSlotID = 17053
				ChestSlotType = 17
				ChestSlotTypeID = 53
				#
				PantsSlotID = 18053
				PantsSlotType = 18
				PantsSlotTypeID = 53
				#
				GantsSlotID = 20053
				GantsSlotType = 20
				GantsSlotTypeID = 53
				#
				BootsSlotID = 21018
				BootsSlotType = 21
				BootsSlotTypeID = 53
				#
				WeaponSlotID = 5166
				WeaponSlotType = 5
				WeaponSlotTypeID = 166
				#
				CapeSlotID = 24111
				CapeSlotType = 24
				CapeSlotTypeID = 111
			if lvl == 80:
				HelmetSlotID = 72001
				HelmetSlotType = 72
				HelemtSlotTypeID = 1
				#
				ChestSlotID = 73001
				ChestSlotType = 73
				ChestSlotTypeID = 1
				#
				PantsSlotID = 74001
				PantsSlotType = 74
				PantsSlotTypeID = 1
				#
				GantsSlotID = 76001
				GantsSlotType = 76
				GantsSlotTypeID = 1
				#
				BootsSlotID = 77001
				BootsSlotType = 77
				BootsSlotTypeID = 1
				#
				WeaponSlotID = 5205
				WeaponSlotType = 5
				WeaponSlotTypeID = 205
				#
				CapeSlotID = 24112
				CapeSlotType = 24
				CapeSlotTypeID = 112
		if Job == 1:
			#Defender
			if lvl == 15:
				HelmetSlotID = 16001
				HelmetSlotType = 16
				HelemtSlotTypeID = 1
				#
				ChestSlotID = 17002
				ChestSlotType = 17
				ChestSlotTypeID = 2
				#
				PantsSlotID = 18002
				PantsSlotType = 18
				PantsSlotTypeID = 2
				#
				GantsSlotID = 20002
				GantsSlotType = 20
				GantsSlotTypeID = 2
				#
				BootsSlotID = 21002
				BootsSlotType = 21
				BootsSlotTypeID = 2
				#
				WeaponSlotID = 2013
				WeaponSlotType = 5
				WeaponSlotTypeID = 13
				#
				CapeSlotID = 24078
				CapeSlotType = 24
				CapeSlotTypeID = 78
			if lvl == 30:
				HelmetSlotID = 16017
				HelmetSlotType = 16
				HelemtSlotTypeID = 17
				#
				ChestSlotID = 17002
				ChestSlotType = 17
				ChestSlotTypeID = 8
				#
				PantsSlotID = 18008
				PantsSlotType = 18
				PantsSlotTypeID = 8
				#
				GantsSlotID = 20008
				GantsSlotType = 20
				GantsSlotTypeID = 8
				#
				BootsSlotID = 21008
				BootsSlotType = 21
				BootsSlotTypeID = 8
				#
				WeaponSlotID = 2034
				WeaponSlotType = 5
				WeaponSlotTypeID = 34
				#
				CapeSlotID = 24083
				CapeSlotType = 24
				CapeSlotTypeID = 83
			if lvl == 60:
				HelmetSlotID = 16004
				HelmetSlotType = 16
				HelemtSlotTypeID = 4
				#
				ChestSlotID = 17018
				ChestSlotType = 17
				ChestSlotTypeID = 18
				#
				PantsSlotID = 18018
				PantsSlotType = 18
				PantsSlotTypeID = 18
				#
				GantsSlotID = 20018
				GantsSlotType = 20
				GantsSlotTypeID = 18
				#
				BootsSlotID = 21018
				BootsSlotType = 21
				BootsSlotTypeID = 18
				#
				WeaponSlotID = 2063
				WeaponSlotType = 2
				WeaponSlotTypeID = 63
				#
				CapeSlotID = 24083
				CapeSlotType = 24
				CapeSlotTypeID = 1
			if lvl == 70:
				HelmetSlotID = 16049
				HelmetSlotType = 16
				HelemtSlotTypeID = 4
				#
				ChestSlotID = 17053
				ChestSlotType = 17
				ChestSlotTypeID = 53
				#
				PantsSlotID = 18053
				PantsSlotType = 18
				PantsSlotTypeID = 53
				#
				GantsSlotID = 20053
				GantsSlotType = 20
				GantsSlotTypeID = 53
				#
				BootsSlotID = 21053
				BootsSlotType = 21
				BootsSlotTypeID = 53
				#
				WeaponSlotID = 2130
				WeaponSlotType = 2
				WeaponSlotTypeID = 130
				#
				CapeSlotID = 24111
				CapeSlotType = 24
				CapeSlotTypeID = 111
			if lvl == 80:
				HelmetSlotID = 72011
				HelmetSlotType = 72
				HelemtSlotTypeID = 11
				#
				ChestSlotID = 73011
				ChestSlotType = 73
				ChestSlotTypeID = 11
				#
				PantsSlotID = 74011
				PantsSlotType = 74
				PantsSlotTypeID = 11
				#
				GantsSlotID = 76011
				GantsSlotType = 76
				GantsSlotTypeID = 11
				#
				BootsSlotID = 77011
				BootsSlotType = 77
				BootsSlotTypeID = 11
				#
				WeaponSlotID = 2139
				WeaponSlotType = 2
				WeaponSlotTypeID = 139
				#
				CapeSlotID = 24112
				CapeSlotType = 24
				CapeSlotTypeID = 112
		if Job == 5:
			#Priest
			if lvl == 15:
				HelmetSlotID = 16171
				HelmetSlotType = 16
				HelemtSlotTypeID = 171
				#
				ChestSlotID = 17172
				ChestSlotType = 17
				ChestSlotTypeID = 172
				#
				PantsSlotID = 18172
				PantsSlotType = 18
				PantsSlotTypeID = 172
				#
				GantsSlotID = 20172
				GantsSlotType = 20
				GantsSlotTypeID = 172
				#
				BootsSlotID = 21172
				BootsSlotType = 21
				BootsSlotTypeID = 172
				#
				WeaponSlotID = 10013
				WeaponSlotType = 10
				WeaponSlotTypeID = 13
				#
				CapeSlotID = 24248
				CapeSlotType = 24
				CapeSlotTypeID = 248
			if lvl == 30:
				HelmetSlotID = 16188
				HelmetSlotType = 16
				HelemtSlotTypeID = 188
				#
				ChestSlotID = 17178
				ChestSlotType = 17
				ChestSlotTypeID = 178
				#
				PantsSlotID = 18178
				PantsSlotType = 18
				PantsSlotTypeID = 178
				#
				GantsSlotID = 20178
				GantsSlotType = 20
				GantsSlotTypeID = 178
				#
				BootsSlotID = 21178
				BootsSlotType = 21
				BootsSlotTypeID = 178
				#
				WeaponSlotID = 10034
				WeaponSlotType = 10
				WeaponSlotTypeID = 34
				#
				CapeSlotID = 24250
				CapeSlotType = 24
				CapeSlotTypeID = 250
			if lvl == 60:
				HelmetSlotID = 16188
				HelmetSlotType = 16
				HelemtSlotTypeID = 188
				#
				ChestSlotID = 17178
				ChestSlotType = 17
				ChestSlotTypeID = 178
				#
				PantsSlotID = 18178
				PantsSlotType = 18
				PantsSlotTypeID = 178
				#
				GantsSlotID = 20178
				GantsSlotType = 20
				GantsSlotTypeID = 178
				#
				BootsSlotID = 21178
				BootsSlotType = 21
				BootsSlotTypeID = 178
				#
				WeaponSlotID = 10034
				WeaponSlotType = 10
				WeaponSlotTypeID = 34
				#
				CapeSlotID = 24250
				CapeSlotType = 24
				CapeSlotTypeID = 250
			if lvl == 70:
				HelmetSlotID = 16219
				HelmetSlotType = 16
				HelemtSlotTypeID = 219
				#
				ChestSlotID = 17223
				ChestSlotType = 17
				ChestSlotTypeID = 223
				#
				PantsSlotID = 18223
				PantsSlotType = 18
				PantsSlotTypeID = 223
				#
				GantsSlotID = 20223
				GantsSlotType = 20
				GantsSlotTypeID = 223
				#
				BootsSlotID = 21223
				BootsSlotType = 21
				BootsSlotTypeID = 223
				#
				WeaponSlotID = 12177
				WeaponSlotType = 12
				WeaponSlotTypeID = 177
				#
				CapeSlotID = 24111
				CapeSlotType = 24
				CapeSlotTypeID = 111
			if lvl == 80:
				HelmetSlotID = 72051
				HelmetSlotType = 72
				HelemtSlotTypeID = 51
				#
				ChestSlotID = 73051
				ChestSlotType = 73
				ChestSlotTypeID = 51
				#
				PantsSlotID = 74051
				PantsSlotType = 74
				PantsSlotTypeID = 51
				#
				GantsSlotID = 76051
				GantsSlotType = 76
				GantsSlotTypeID = 51
				#
				BootsSlotID = 77051
				BootsSlotType = 77
				BootsSlotTypeID = 51
				#
				WeaponSlotID = 60176
				WeaponSlotType = 60
				WeaponSlotTypeID = 176
				#
				CapeSlotID = 24126
				CapeSlotType = 24
				CapeSlotTypeID = 126
	if Family == 1:
		if Job == 3:
			#Archer
			if lvl== 15:
				HelmetSlotID = 16132
				HelmetSlotType = 16
				HelemtSlotTypeID = 132
				#
				ChestSlotID = 17087
				ChestSlotType = 17
				ChestSlotTypeID = 87
				#
				PantsSlotID = 18063
				PantsSlotType = 18
				PantsSlotTypeID = 63
				#
				GantsSlotID = 20063
				GantsSlotType = 20
				GantsSlotTypeID = 63
				#
				BootsSlotID = 21064
				BootsSlotType = 21
				BootsSlotTypeID = 64
				#
				WeaponSlotID = 1013
				WeaponSlotType = 1
				WeaponSlotTypeID = 13
				#
				CapeSlotID = 24163
				CapeSlotType = 24
				CapeSlotTypeID = 163
			if lvl == 30:
				HelmetSlotID = 16103
				HelmetSlotType = 16
				HelemtSlotTypeID = 103
				#
				ChestSlotID = 17098
				ChestSlotType = 17
				ChestSlotTypeID = 98
				#
				PantsSlotID = 18098
				PantsSlotType = 18
				PantsSlotTypeID = 98
				#
				GantsSlotID = 20103
				GantsSlotType = 20
				GantsSlotTypeID = 103
				#
				BootsSlotID = 21103
				BootsSlotType = 21
				BootsSlotTypeID = 103
				#
				WeaponSlotID = 45035
				WeaponSlotType = 45
				WeaponSlotTypeID = 35
				#
				CapeSlotID = 24165
				CapeSlotType = 24
				CapeSlotTypeID = 165
			if lvl == 60:
				HelmetSlotID = 16103
				HelmetSlotType = 16
				HelemtSlotTypeID = 103
				#
				ChestSlotID = 17093
				ChestSlotType = 17
				ChestSlotTypeID = 93
				#
				PantsSlotID = 18093
				PantsSlotType = 18
				PantsSlotTypeID = 93
				#
				GantsSlotID = 20069
				GantsSlotType = 20
				GantsSlotTypeID = 69
				#
				BootsSlotID = 21070
				BootsSlotType = 21
				BootsSlotTypeID = 70
				#
				WeaponSlotID = 45034
				WeaponSlotType = 45
				WeaponSlotTypeID = 34
				#
				CapeSlotID = 24165
				CapeSlotType = 24
				CapeSlotTypeID = 165
			if lvl == 70:
				HelmetSlotID = 16134
				HelmetSlotType = 16
				HelemtSlotTypeID = 134
				#
				ChestSlotID = 17138
				ChestSlotType = 17
				ChestSlotTypeID = 138
				#
				PantsSlotID = 18138
				PantsSlotType = 18
				PantsSlotTypeID = 138
				#
				GantsSlotID = 20138
				GantsSlotType = 20
				GantsSlotTypeID = 138
				#
				BootsSlotID = 21138
				BootsSlotType = 21
				BootsSlotTypeID = 138
				#
				WeaponSlotID = 14130
				WeaponSlotType = 14
				WeaponSlotTypeID = 130
				#
				CapeSlotID = 24118
				CapeSlotType = 24
				CapeSlotTypeID = 118
			if lvl == 80:
				HelmetSlotID = 72031
				HelmetSlotType = 72
				HelemtSlotTypeID = 31
				#
				ChestSlotID = 73031
				ChestSlotType = 73
				ChestSlotTypeID = 31
				#
				PantsSlotID = 74031
				PantsSlotType = 74
				PantsSlotTypeID = 31
				#
				GantsSlotID = 76031
				GantsSlotType = 76
				GantsSlotTypeID = 31
				#
				BootsSlotID = 77031
				BootsSlotType = 77
				BootsSlotTypeID = 31
				#
				WeaponSlotID = 13209
				WeaponSlotType = 13
				WeaponSlotTypeID = 209
				#
				CapeSlotID = 24119
				CapeSlotType = 24
				CapeSlotTypeID = 119
		if Job == 2:
			#Ranger
			if lvl== 15:
				HelmetSlotID = 16132
				HelmetSlotType = 16
				HelemtSlotTypeID = 132
				#
				ChestSlotID = 17087
				ChestSlotType = 17
				ChestSlotTypeID = 87
				#
				PantsSlotID = 18063
				PantsSlotType = 18
				PantsSlotTypeID = 63
				#
				GantsSlotID = 20063
				GantsSlotType = 20
				GantsSlotTypeID = 63
				#
				BootsSlotID = 21064
				BootsSlotType = 21
				BootsSlotTypeID = 64
				#
				WeaponSlotID = 9013
				WeaponSlotType = 9
				WeaponSlotTypeID = 13
				#
				CapeSlotID = 24162
				CapeSlotType = 24
				CapeSlotTypeID = 162
			if lvl == 30:
				HelmetSlotID = 16103
				HelmetSlotType = 16
				HelemtSlotTypeID = 103
				#
				ChestSlotID = 17098
				ChestSlotType = 17
				ChestSlotTypeID = 98
				#
				PantsSlotID = 18098
				PantsSlotType = 18
				PantsSlotTypeID = 98
				#
				GantsSlotID = 20103
				GantsSlotType = 20
				GantsSlotTypeID = 103
				#
				BootsSlotID = 21103
				BootsSlotType = 21
				BootsSlotTypeID = 103
				#
				WeaponSlotID = 9043
				WeaponSlotType = 9
				WeaponSlotTypeID = 43
				#
				CapeSlotID = 24164
				CapeSlotType = 24
				CapeSlotTypeID = 164
			if lvl == 60:
				HelmetSlotID = 16103
				HelmetSlotType = 16
				HelemtSlotTypeID = 103
				#
				ChestSlotID = 17093
				ChestSlotType = 17
				ChestSlotTypeID = 93
				#
				PantsSlotID = 18093
				PantsSlotType = 18
				PantsSlotTypeID = 93
				#
				GantsSlotID = 20069
				GantsSlotType = 20
				GantsSlotTypeID = 69
				#
				BootsSlotID = 21070
				BootsSlotType = 21
				BootsSlotTypeID = 70
				#
				WeaponSlotID = 10034
				WeaponSlotType = 10
				WeaponSlotTypeID = 34
				#
				CapeSlotID = 24164
				CapeSlotType = 24
				CapeSlotTypeID = 164
			if lvl == 70:
				HelmetSlotID = 16134
				HelmetSlotType = 16
				HelemtSlotTypeID = 134
				#
				ChestSlotID = 17138
				ChestSlotType = 17
				ChestSlotTypeID = 138
				#
				PantsSlotID = 18138
				PantsSlotType = 18
				PantsSlotTypeID = 138
				#
				GantsSlotID = 20138
				GantsSlotType = 20
				GantsSlotTypeID = 138
				#
				BootsSlotID = 21138
				BootsSlotType = 21
				BootsSlotTypeID = 138
				#
				WeaponSlotID = 15160
				WeaponSlotType = 15
				WeaponSlotTypeID = 160
				#
				CapeSlotID = 24118
				CapeSlotType = 24
				CapeSlotTypeID = 118
			if lvl == 80:
				HelmetSlotID = 72031
				HelmetSlotType = 72
				HelemtSlotTypeID = 31
				#
				ChestSlotID = 73031
				ChestSlotType = 73
				ChestSlotTypeID = 31
				#
				PantsSlotID = 74031
				PantsSlotType = 74
				PantsSlotTypeID = 31
				#
				GantsSlotID = 76031
				GantsSlotType = 76
				GantsSlotTypeID = 31
				#
				BootsSlotID = 77031
				BootsSlotType = 77
				BootsSlotTypeID = 31
				#
				WeaponSlotID = 9217
				WeaponSlotType = 9
				WeaponSlotTypeID = 217
				#
				CapeSlotID = 24119
				CapeSlotType = 24
				CapeSlotTypeID = 119
		if Job == 4:
			#Mage
			if lvl== 15:
				HelmetSlotID = 16171
				HelmetSlotType = 16
				HelemtSlotTypeID = 171
				#
				ChestSlotID = 17172
				ChestSlotType = 17
				ChestSlotTypeID = 172
				#
				PantsSlotID = 18172
				PantsSlotType = 18
				PantsSlotTypeID = 172
				#
				GantsSlotID = 20172
				GantsSlotType = 20
				GantsSlotTypeID = 172
				#
				BootsSlotID = 21172
				BootsSlotType = 21
				BootsSlotTypeID = 172
				#
				WeaponSlotID = 10013
				WeaponSlotType = 10
				WeaponSlotTypeID = 13
				#
				CapeSlotID = 24248
				CapeSlotType = 24
				CapeSlotTypeID = 248
			if lvl == 30:
				HelmetSlotID = 16188
				HelmetSlotType = 16
				HelemtSlotTypeID = 188
				#
				ChestSlotID = 17178
				ChestSlotType = 17
				ChestSlotTypeID = 178
				#
				PantsSlotID = 18178
				PantsSlotType = 18
				PantsSlotTypeID = 178
				#
				GantsSlotID = 20178
				GantsSlotType = 20
				GantsSlotTypeID = 178
				#
				BootsSlotID = 21178
				BootsSlotType = 21
				BootsSlotTypeID = 178
				#
				WeaponSlotID = 10034
				WeaponSlotType = 10
				WeaponSlotTypeID = 34
				#
				CapeSlotID = 24250
				CapeSlotType = 24
				CapeSlotTypeID = 250
			if lvl == 60:
				HelmetSlotID = 16188
				HelmetSlotType = 16
				HelemtSlotTypeID = 188
				#
				ChestSlotID = 17178
				ChestSlotType = 17
				ChestSlotTypeID = 178
				#
				PantsSlotID = 18178
				PantsSlotType = 18
				PantsSlotTypeID = 178
				#
				GantsSlotID = 20178
				GantsSlotType = 20
				GantsSlotTypeID = 178
				#
				BootsSlotID = 21178
				BootsSlotType = 21
				BootsSlotTypeID = 178
				#
				WeaponSlotID = 10034
				WeaponSlotType = 10
				WeaponSlotTypeID = 34
				#
				CapeSlotID = 24250
				CapeSlotType = 24
				CapeSlotTypeID = 250
			if lvl == 70:
				HelmetSlotID = 16219
				HelmetSlotType = 16
				HelemtSlotTypeID = 219
				#
				ChestSlotID = 17223
				ChestSlotType = 17
				ChestSlotTypeID = 223
				#
				PantsSlotID = 18223
				PantsSlotType = 18
				PantsSlotTypeID = 223
				#
				GantsSlotID = 20223
				GantsSlotType = 20
				GantsSlotTypeID = 223
				#
				BootsSlotID = 21223
				BootsSlotType = 21
				BootsSlotTypeID = 223
				#
				WeaponSlotID = 12177
				WeaponSlotType = 12
				WeaponSlotTypeID = 177
				#
				CapeSlotID = 24111
				CapeSlotType = 24
				CapeSlotTypeID = 111
			if lvl == 80:
				HelmetSlotID = 72051
				HelmetSlotType = 72
				HelemtSlotTypeID = 51
				#
				ChestSlotID = 73051
				ChestSlotType = 73
				ChestSlotTypeID = 51
				#
				PantsSlotID = 74051
				PantsSlotType = 74
				PantsSlotTypeID = 51
				#
				GantsSlotID = 76051
				GantsSlotType = 76
				GantsSlotTypeID = 51
				#
				BootsSlotID = 77051
				BootsSlotType = 77
				BootsSlotTypeID = 51
				#
				WeaponSlotID = 60176
				WeaponSlotType = 60
				WeaponSlotTypeID = 176
				#
				CapeSlotID = 24125
				CapeSlotType = 24
				CapeSlotTypeID = 125
	if Family == 3:
		if Job == 0:
			#Warrior
			if lvl== 15:
				HelmetSlotID = 31001
				HelmetSlotType = 31
				HelemtSlotTypeID = 1
				#
				ChestSlotID = 32002
				ChestSlotType = 32
				ChestSlotTypeID = 2
				#
				PantsSlotID = 33002
				PantsSlotType = 33
				PantsSlotTypeID = 2
				#
				GantsSlotID = 35002
				GantsSlotType = 35
				GantsSlotTypeID = 2
				#
				BootsSlotID = 36002
				BootsSlotType = 36
				BootsSlotTypeID = 2
				#
				WeaponSlotID = 3002
				WeaponSlotType = 3
				WeaponSlotTypeID = 2
				#
				CapeSlotID = 39077
				CapeSlotType = 39
				CapeSlotTypeID = 77
			if lvl == 30:
				HelmetSlotID = 31003
				HelmetSlotType = 31
				HelemtSlotTypeID = 3
				#
				ChestSlotID = 32008
				ChestSlotType = 32
				ChestSlotTypeID = 8
				#
				PantsSlotID = 33008
				PantsSlotType = 3
				PantsSlotTypeID = 8
				#
				GantsSlotID = 35008
				GantsSlotType = 35
				GantsSlotTypeID = 8
				#
				BootsSlotID = 36008
				BootsSlotType = 36
				BootsSlotTypeID = 8
				#
				WeaponSlotID = 47050
				WeaponSlotType = 47
				WeaponSlotTypeID = 50
				#
				CapeSlotID = 39079
				CapeSlotType = 39
				CapeSlotTypeID = 79
			if lvl == 60:
				HelmetSlotID = 31018
				HelmetSlotType = 31
				HelemtSlotTypeID = 18
				#
				ChestSlotID = 32008
				ChestSlotType = 32
				ChestSlotTypeID = 8
				#
				PantsSlotID = 33008
				PantsSlotType = 33
				PantsSlotTypeID = 8
				#
				GantsSlotID = 35008
				GantsSlotType = 35
				GantsSlotTypeID = 8
				#
				BootsSlotID = 36008
				BootsSlotType = 36
				BootsSlotTypeID = 8
				#
				WeaponSlotID = 47050
				WeaponSlotType = 47
				WeaponSlotTypeID = 50
				#
				CapeSlotID = 39081
				CapeSlotType = 39
				CapeSlotTypeID = 81
			if lvl == 70:
				HelmetSlotID = 31049
				HelmetSlotType = 31
				HelemtSlotTypeID = 49
				#
				ChestSlotID = 32053
				ChestSlotType = 32
				ChestSlotTypeID = 53
				#
				PantsSlotID = 33053
				PantsSlotType = 33
				PantsSlotTypeID = 53
				#
				GantsSlotID = 35053
				GantsSlotType = 35
				GantsSlotTypeID = 53
				#
				BootsSlotID = 36053
				BootsSlotType = 36
				BootsSlotTypeID = 53
				#
				WeaponSlotID = 6186
				WeaponSlotType = 6
				WeaponSlotTypeID = 186
				#
				CapeSlotID = 39111
				CapeSlotType = 39
				CapeSlotTypeID = 111
			if lvl == 80:
				HelmetSlotID = 87001
				HelmetSlotType = 87
				HelemtSlotTypeID = 1
				#
				ChestSlotID = 88001
				ChestSlotType = 88
				ChestSlotTypeID = 1
				#
				PantsSlotID = 89001
				PantsSlotType = 89
				PantsSlotTypeID = 1
				#
				GantsSlotID = 91001
				GantsSlotType = 91
				GantsSlotTypeID = 1
				#
				BootsSlotID = 92001
				BootsSlotType = 92
				BootsSlotTypeID = 1
				#
				WeaponSlotID = 60176
				WeaponSlotType = 60
				WeaponSlotTypeID = 176
				#
				CapeSlotID = 24119
				CapeSlotType = 24
				CapeSlotTypeID = 119
		if Job == 1:
			#Guardian
			if lvl== 15:
				HelmetSlotID = 31001
				HelmetSlotType = 31
				HelemtSlotTypeID = 1
				#
				ChestSlotID = 32002
				ChestSlotType = 32
				ChestSlotTypeID = 2
				#
				PantsSlotID = 33002
				PantsSlotType = 33
				PantsSlotTypeID = 2
				#
				GantsSlotID = 35002
				GantsSlotType = 35
				GantsSlotTypeID = 2
				#
				BootsSlotID = 36002
				BootsSlotType = 36
				BootsSlotTypeID = 2
				#
				WeaponSlotID = 3002
				WeaponSlotType = 3
				WeaponSlotTypeID = 2
				#
				CapeSlotID = 39077
				CapeSlotType = 39
				CapeSlotTypeID = 77
			if lvl == 30:
				HelmetSlotID = 31003
				HelmetSlotType = 31
				HelemtSlotTypeID = 3
				#
				ChestSlotID = 32008
				ChestSlotType = 32
				ChestSlotTypeID = 8
				#
				PantsSlotID = 33008
				PantsSlotType = 3
				PantsSlotTypeID = 8
				#
				GantsSlotID = 35008
				GantsSlotType = 35
				GantsSlotTypeID = 8
				#
				BootsSlotID = 36008
				BootsSlotType = 36
				BootsSlotTypeID = 8
				#
				WeaponSlotID = 47050
				WeaponSlotType = 47
				WeaponSlotTypeID = 50
				#
				CapeSlotID = 39079
				CapeSlotType = 39
				CapeSlotTypeID = 79
			if lvl == 60:
				HelmetSlotID = 31018
				HelmetSlotType = 31
				HelemtSlotTypeID = 18
				#
				ChestSlotID = 32008
				ChestSlotType = 32
				ChestSlotTypeID = 8
				#
				PantsSlotID = 33008
				PantsSlotType = 33
				PantsSlotTypeID = 8
				#
				GantsSlotID = 35008
				GantsSlotType = 35
				GantsSlotTypeID = 8
				#
				BootsSlotID = 36008
				BootsSlotType = 36
				BootsSlotTypeID = 8
				#
				WeaponSlotID = 47050
				WeaponSlotType = 47
				WeaponSlotTypeID = 50
				#
				CapeSlotID = 3981
				CapeSlotType = 39
				CapeSlotTypeID = 81
			if lvl == 70:
				HelmetSlotID = 31049
				HelmetSlotType = 31
				HelemtSlotTypeID = 49
				#
				ChestSlotID = 32053
				ChestSlotType = 32
				ChestSlotTypeID = 53
				#
				PantsSlotID = 33053
				PantsSlotType = 33
				PantsSlotTypeID = 53
				#
				GantsSlotID = 35053
				GantsSlotType = 35
				GantsSlotTypeID = 53
				#
				BootsSlotID = 36053
				BootsSlotType = 36
				BootsSlotTypeID = 53
				#
				WeaponSlotID = 6186
				WeaponSlotType = 6
				WeaponSlotTypeID = 186
				#
				CapeSlotID = 39111
				CapeSlotType = 39
				CapeSlotTypeID = 111
			if lvl == 80:
				HelmetSlotID = 87001
				HelmetSlotType = 87
				HelemtSlotTypeID = 1
				#
				ChestSlotID = 88001
				ChestSlotType = 88
				ChestSlotTypeID = 1
				#
				PantsSlotID = 89001
				PantsSlotType = 89
				PantsSlotTypeID = 1
				#
				GantsSlotID = 91001
				GantsSlotType = 91
				GantsSlotTypeID = 1
				#
				BootsSlotID = 92001
				BootsSlotType = 92
				BootsSlotTypeID = 1
				#
				WeaponSlotID = 60176
				WeaponSlotType = 60
				WeaponSlotTypeID = 176
				#
				CapeSlotID = 24119
				CapeSlotType = 24
				CapeSlotTypeID = 119
		if Job == 3:
			#Hunter
			if lvl == 15:
				HelmetSlotID = 31084
				HelmetSlotType = 31
				HelemtSlotTypeID = 84
				#
				ChestSlotID = 32087
				ChestSlotType = 32
				ChestSlotTypeID = 87
				#
				PantsSlotID = 33087
				PantsSlotType = 33
				PantsSlotTypeID = 87
				#
				GantsSlotID = 35087
				GantsSlotType = 35
				GantsSlotTypeID = 87
				#
				BootsSlotID = 36087
				BootsSlotType = 36
				BootsSlotTypeID = 87
				#
				WeaponSlotID = 59202
				WeaponSlotType = 59
				WeaponSlotTypeID = 202
				#
				CapeSlotID = 39163
				CapeSlotType = 39
				CapeSlotTypeID = 163
			if lvl == 30:
				HelmetSlotID = 31101
				HelmetSlotType = 31
				HelemtSlotTypeID = 101
				#
				ChestSlotID = 32097
				ChestSlotType = 32
				ChestSlotTypeID = 97
				#
				PantsSlotID = 33097
				PantsSlotType = 33
				PantsSlotTypeID = 97
				#
				GantsSlotID = 35097
				GantsSlotType = 35
				GantsSlotTypeID = 97
				#
				BootsSlotID = 36097
				BootsSlotType = 36
				BootsSlotTypeID = 97
				#
				WeaponSlotID = 63220
				WeaponSlotType = 63
				WeaponSlotTypeID = 220
				#
				CapeSlotID = 39165
				CapeSlotType = 39
				CapeSlotTypeID = 165
			if lvl == 60:
				HelmetSlotID = 31103
				HelmetSlotType = 31
				HelemtSlotTypeID = 103
				#
				ChestSlotID = 32093
				ChestSlotType = 32
				ChestSlotTypeID = 93
				#
				PantsSlotID = 33093
				PantsSlotType = 33
				PantsSlotTypeID = 93
				#
				GantsSlotID = 35093
				GantsSlotType = 35
				GantsSlotTypeID = 93
				#
				BootsSlotID = 36093
				BootsSlotType = 36
				BootsSlotTypeID = 93
				#
				WeaponSlotID = 63224
				WeaponSlotType = 63
				WeaponSlotTypeID = 224
				#
				CapeSlotID = 39167
				CapeSlotType = 39
				CapeSlotTypeID = 167
			if lvl == 70:
				HelmetSlotID = 31134
				HelmetSlotType = 31
				HelemtSlotTypeID = 134
				#
				ChestSlotID = 32138
				ChestSlotType = 32
				ChestSlotTypeID = 32138
				#
				PantsSlotID = 33138
				PantsSlotType = 33
				PantsSlotTypeID = 138
				#
				GantsSlotID = 35138
				GantsSlotType = 35
				GantsSlotTypeID = 138
				#
				BootsSlotID = 36138
				BootsSlotType = 36
				BootsSlotTypeID = 138
				#
				WeaponSlotID = 11130
				WeaponSlotType = 11
				WeaponSlotTypeID = 130
				#
				CapeSlotID = 39118
				CapeSlotType = 39
				CapeSlotTypeID = 118
			if lvl == 80:
				HelmetSlotID = 87031
				HelmetSlotType = 87
				HelemtSlotTypeID = 31
				#
				ChestSlotID = 88031
				ChestSlotType = 88
				ChestSlotTypeID = 31
				#
				PantsSlotID = 89031
				PantsSlotType = 89
				PantsSlotTypeID = 31
				#
				GantsSlotID = 91031
				GantsSlotType = 91
				GantsSlotTypeID = 31
				#
				BootsSlotID = 92031
				BootsSlotType = 92
				BootsSlotTypeID = 31
				#
				WeaponSlotID = 11139
				WeaponSlotType = 11
				WeaponSlotTypeID = 139
				#
				CapeSlotID = 39119
				CapeSlotType = 39
				CapeSlotTypeID = 119
	if Family == 2:
		if Job == 4:
			#Pagan
			if lvl== 15:
				HelmetSlotID = 31171
				HelmetSlotType = 31
				HelemtSlotTypeID = 171
				#
				ChestSlotID = 32172
				ChestSlotType = 32
				ChestSlotTypeID = 172
				#
				PantsSlotID = 33172
				PantsSlotType = 33
				PantsSlotTypeID = 172
				#
				GantsSlotID = 35172
				GantsSlotType = 35
				GantsSlotTypeID = 172
				#
				BootsSlotID = 36172
				BootsSlotType = 36
				BootsSlotTypeID = 172
				#
				WeaponSlotID = 10013
				WeaponSlotType = 10
				WeaponSlotTypeID = 13
				#
				CapeSlotID = 39247
				CapeSlotType = 39
				CapeSlotTypeID = 247
			if lvl == 30:
				HelmetSlotID = 31188
				HelmetSlotType = 31
				HelemtSlotTypeID = 188
				#
				ChestSlotID = 32178
				ChestSlotType = 32
				ChestSlotTypeID = 178
				#
				PantsSlotID = 33178
				PantsSlotType = 33
				PantsSlotTypeID = 178
				#
				GantsSlotID = 35178
				GantsSlotType = 35
				GantsSlotTypeID = 178
				#
				BootsSlotID = 36178
				BootsSlotType = 36
				BootsSlotTypeID = 178
				#
				WeaponSlotID = 10034
				WeaponSlotType = 10
				WeaponSlotTypeID = 34
				#
				CapeSlotID = 39250
				CapeSlotType = 39
				CapeSlotTypeID = 250
			if lvl == 60:
				HelmetSlotID = 31188
				HelmetSlotType = 31
				HelemtSlotTypeID = 188
				#
				ChestSlotID = 32178
				ChestSlotType = 32
				ChestSlotTypeID = 178
				#
				PantsSlotID = 33178
				PantsSlotType = 33
				PantsSlotTypeID = 178
				#
				GantsSlotID = 35178
				GantsSlotType = 35
				GantsSlotTypeID = 178
				#
				BootsSlotID = 36178
				BootsSlotType = 36
				BootsSlotTypeID = 178
				#
				WeaponSlotID = 10034
				WeaponSlotType = 10
				WeaponSlotTypeID = 34
				#
				CapeSlotID = 39250
				CapeSlotType = 39
				CapeSlotTypeID = 250
			if lvl == 70:
				HelmetSlotID = 31219
				HelmetSlotType = 31
				HelemtSlotTypeID = 219
				#
				ChestSlotID = 32223
				ChestSlotType = 32
				ChestSlotTypeID = 223
				#
				PantsSlotID = 33223
				PantsSlotType = 33
				PantsSlotTypeID = 223
				#
				GantsSlotID = 35223
				GantsSlotType = 35
				GantsSlotTypeID = 223
				#
				BootsSlotID = 36223
				BootsSlotType = 36
				BootsSlotTypeID = 223
				#
				WeaponSlotID = 12177
				WeaponSlotType = 12
				WeaponSlotTypeID = 177
				#
				CapeSlotID = 39111
				CapeSlotType = 39
				CapeSlotTypeID = 111
			if lvl == 80:
				HelmetSlotID = 87041
				HelmetSlotType = 87
				HelemtSlotTypeID = 41
				#
				ChestSlotID = 88041
				ChestSlotType = 88
				ChestSlotTypeID = 41
				#
				PantsSlotID = 89041
				PantsSlotType = 89
				PantsSlotTypeID = 41
				#
				GantsSlotID = 91041
				GantsSlotType = 91
				GantsSlotTypeID = 41
				#
				BootsSlotID = 92041
				BootsSlotType = 92
				BootsSlotTypeID = 41
				#
				WeaponSlotID = 60176
				WeaponSlotType = 60
				WeaponSlotTypeID = 176
				#
				CapeSlotID = 39125
				CapeSlotType = 39
				CapeSlotTypeID = 125
		if Job == 2:
			#Assassin
			if lvl == 15:
				HelmetSlotID = 31084
				HelmetSlotType = 31
				HelemtSlotTypeID = 84
				#
				ChestSlotID = 32087
				ChestSlotType = 32
				ChestSlotTypeID = 87
				#
				PantsSlotID = 33087
				PantsSlotType = 33
				PantsSlotTypeID = 87
				#
				GantsSlotID = 35087
				GantsSlotType = 35
				GantsSlotTypeID = 87
				#
				BootsSlotID = 36087
				BootsSlotType = 36
				BootsSlotTypeID = 87
				#
				WeaponSlotID = 15013
				WeaponSlotType = 15
				WeaponSlotTypeID = 13
				#
				CapeSlotID = 39163
				CapeSlotType = 39
				CapeSlotTypeID = 163
			if lvl == 30:
				HelmetSlotID = 31101
				HelmetSlotType = 31
				HelemtSlotTypeID = 101
				#
				ChestSlotID = 32097
				ChestSlotType = 32
				ChestSlotTypeID = 97
				#
				PantsSlotID = 33097
				PantsSlotType = 33
				PantsSlotTypeID = 97
				#
				GantsSlotID = 35097
				GantsSlotType = 35
				GantsSlotTypeID = 97
				#
				BootsSlotID = 36097
				BootsSlotType = 36
				BootsSlotTypeID = 97
				#
				WeaponSlotID = 63220
				WeaponSlotType = 63
				WeaponSlotTypeID = 220
				#
				CapeSlotID = 39165
				CapeSlotType = 39
				CapeSlotTypeID = 165
			if lvl == 60:
				HelmetSlotID = 31103
				HelmetSlotType = 31
				HelemtSlotTypeID = 103
				#
				ChestSlotID = 32093
				ChestSlotType = 32
				ChestSlotTypeID = 93
				#
				PantsSlotID = 33093
				PantsSlotType = 33
				PantsSlotTypeID = 93
				#
				GantsSlotID = 35093
				GantsSlotType = 35
				GantsSlotTypeID = 93
				#
				BootsSlotID = 36093
				BootsSlotType = 36
				BootsSlotTypeID = 93
				#
				WeaponSlotID = 63224
				WeaponSlotType = 63
				WeaponSlotTypeID = 224
				#
				CapeSlotID = 39166
				CapeSlotType = 39
				CapeSlotTypeID = 166
			if lvl == 70:
				HelmetSlotID = 31134
				HelmetSlotType = 31
				HelemtSlotTypeID = 134
				#
				ChestSlotID = 32138
				ChestSlotType = 32
				ChestSlotTypeID = 32138
				#
				PantsSlotID = 33138
				PantsSlotType = 33
				PantsSlotTypeID = 138
				#
				GantsSlotID = 35138
				GantsSlotType = 35
				GantsSlotTypeID = 138
				#
				BootsSlotID = 36138
				BootsSlotType = 36
				BootsSlotTypeID = 138
				#
				WeaponSlotID = 91056
				WeaponSlotType = 9
				WeaponSlotTypeID = 156
				#
				CapeSlotID = 39118
				CapeSlotType = 39
				CapeSlotTypeID = 118
			if lvl == 80:
				HelmetSlotID = 87021
				HelmetSlotType = 87
				HelemtSlotTypeID = 21
				#
				ChestSlotID = 88021
				ChestSlotType = 88
				ChestSlotTypeID = 21
				#
				PantsSlotID = 89021
				PantsSlotType = 89
				PantsSlotTypeID = 21
				#
				GantsSlotID = 91021
				GantsSlotType = 91
				GantsSlotTypeID = 21
				#
				BootsSlotID = 92021
				BootsSlotType = 92
				BootsSlotTypeID = 21
				#
				WeaponSlotID = 10222
				WeaponSlotType = 10
				WeaponSlotTypeID = 222
				#
				CapeSlotID = 39119
				CapeSlotType = 39
				CapeSlotTypeID = 119
		if Job == 5:
			#Oracle
			if lvl == 15:
				HelmetSlotID = 31171
				HelmetSlotType = 31
				HelemtSlotTypeID = 171
				#
				ChestSlotID = 32172
				ChestSlotType = 32
				ChestSlotTypeID = 172
				#
				PantsSlotID = 33172
				PantsSlotType = 33
				PantsSlotTypeID = 172
				#
				GantsSlotID = 35172
				GantsSlotType = 35
				GantsSlotTypeID = 172
				#
				BootsSlotID = 36172
				BootsSlotType = 36
				BootsSlotTypeID = 172
				#
				WeaponSlotID = 10013
				WeaponSlotType = 10
				WeaponSlotTypeID = 13
				#
				CapeSlotID = 39248
				CapeSlotType = 39
				CapeSlotTypeID = 248
			if lvl == 30:
				HelmetSlotID = 31188
				HelmetSlotType = 31
				HelemtSlotTypeID = 188
				#
				ChestSlotID = 32178
				ChestSlotType = 32
				ChestSlotTypeID = 178
				#
				PantsSlotID = 33178
				PantsSlotType = 33
				PantsSlotTypeID = 178
				#
				GantsSlotID = 35178
				GantsSlotType = 35
				GantsSlotTypeID = 178
				#
				BootsSlotID = 36178
				BootsSlotType = 36
				BootsSlotTypeID = 178
				#
				WeaponSlotID = 10034
				WeaponSlotType = 10
				WeaponSlotTypeID = 34
				#
				CapeSlotID = 39250
				CapeSlotType = 39
				CapeSlotTypeID = 250
			if lvl == 60:
				HelmetSlotID = 31188
				HelmetSlotType = 31
				HelemtSlotTypeID = 188
				#
				ChestSlotID = 32178
				ChestSlotType = 32
				ChestSlotTypeID = 178
				#
				PantsSlotID = 33178
				PantsSlotType = 33
				PantsSlotTypeID = 178
				#
				GantsSlotID = 35178
				GantsSlotType = 35
				GantsSlotTypeID = 178
				#
				BootsSlotID = 36178
				BootsSlotType = 36
				BootsSlotTypeID = 178
				#
				WeaponSlotID = 10034
				WeaponSlotType = 10
				WeaponSlotTypeID = 34
				#
				CapeSlotID = 39250
				CapeSlotType = 39
				CapeSlotTypeID = 250
			if lvl == 70:
				HelmetSlotID = 31219
				HelmetSlotType = 31
				HelemtSlotTypeID = 219
				#
				ChestSlotID = 32223
				ChestSlotType = 32
				ChestSlotTypeID = 223
				#
				PantsSlotID = 33223
				PantsSlotType = 33
				PantsSlotTypeID = 223
				#
				GantsSlotID = 35223
				GantsSlotType = 35
				GantsSlotTypeID = 223
				#
				BootsSlotID = 36223
				BootsSlotType = 36
				BootsSlotTypeID = 223
				#
				WeaponSlotID = 12177
				WeaponSlotType = 12
				WeaponSlotTypeID = 177
				#
				CapeSlotID = 39111
				CapeSlotType = 39
				CapeSlotTypeID = 111
			if lvl == 80:
				HelmetSlotID = 87051
				HelmetSlotType = 87
				HelemtSlotTypeID = 51
				#
				ChestSlotID = 88051
				ChestSlotType = 88
				ChestSlotTypeID = 51
				#
				PantsSlotID = 89051
				PantsSlotType = 89
				PantsSlotTypeID = 51
				#
				GantsSlotID = 91051
				GantsSlotType = 91
				GantsSlotTypeID = 51
				#
				BootsSlotID = 91051
				BootsSlotType = 91
				BootsSlotTypeID = 51
				#
				WeaponSlotID = 60176
				WeaponSlotType = 60
				WeaponSlotTypeID = 176
				#
				CapeSlotID = 39126
				CapeSlotType = 39
				CapeSlotTypeID = 126
	SetItem(Charname, HelmetSlotType, HelemtSlotTypeID, HelmetSlotID, 0, 0, 1)
	SetItem(Charname, ChestSlotType, ChestSlotTypeID, ChestSlotID, 0, 1, 1)
	SetItem(Charname, PantsSlotType, PantsSlotTypeID, PantsSlotID, 0, 2, 1)
	SetItem(Charname, GantsSlotType, GantsSlotTypeID, GantsSlotID, 0, 3, 1)
	SetItem(Charname, BootsSlotType, BootsSlotTypeID, BootsSlotID, 0, 4, 1)
	SetItem(Charname, WeaponSlotType, WeaponSlotTypeID, WeaponSlotID, 0, 5, 1)
	SetItem(Charname, CapeSlotType, CapeSlotTypeID,CapeSlotID, 0, 7, 1)
	SetItem(Charname,23,58,23058, 0, 8, 1)
	SetItem(Charname,22,70,22070, 0, 9, 1)
	SetItem(Charname,22,70,22070, 0, 10, 1)
	SetItem(Charname,40,70,40070, 0, 11, 1)
	SetItem(Charname,40,70,40070, 0, 12, 1)
	SetItem(Charname,100,132,100132, 1, 2, 255)
	SetItem(Charname,100,170,100170, 1, 3, 2)
	SetItem(Charname,100,53,10053, 1, 4, 255)
	SetItem(Charname,100,165,100165, 1, 5, 255)
	SetItem(Charname,100,199,100199, 1, 6, 255)
	SetItem(Charname,100,91,100091, 1, 7, 99)
	SetItem(Charname,30,1,30001, 1, 8, 255)
	SetItem(Charname,30,2,30002, 1, 9, 255)
	SetItem(Charname,30,8,30008, 1, 10, 255)
	SetItem(Charname,30,9,30009, 1, 11, 255)
	SetItem(Charname,30,15,30015, 1, 12, 255)
	SetItem(Charname,30,16,30016, 1, 13, 255)
	SetItem(Charname,30,22,30022, 1, 14, 255)
	SetItem(Charname,30,23,30023, 1, 15, 255)
	SetItem(Charname,30,29,30029, 1, 16, 255)
	SetItem(Charname,30,30,30030, 1, 17, 255)
	SetItem(Charname,100,47,100047, 1, 18, 2)
	SetItem(Charname,100,48,100048, 1, 19, 2)
	SetItem(Charname,30,36,30036, 1, 20, 255)
	SetItem(Charname,30,37,30037, 1, 21, 255)
	SetItem(Charname,30,43,30043, 1, 22, 255)
	SetItem(Charname,30,44,30044, 1, 23, 255)
	SetItem(Charname,30,50,30050, 2, 1, 255)
	SetItem(Charname,30,51,30051, 2, 2, 255)
	SetItem(Charname,30,57,30057, 2, 3, 255)
	SetItem(Charname,30,58,30058, 2, 4, 255)
	connection.Close()	
	#print "UPDATE END CMD:"
	#print "UPDATE PS_GameData.dbo.Chars SET Map = "+str(MapID)+", PosX = "+str(PosX)+", PosY = "+str(PosY)+", @Posz = "+str(PosZ)+", StatPoint = "+str(StatPoint)+", SkillPoint = "+str(SkillPoint)+", Level = "+str(lvl)+", Str = "+str(Str)+", Rec = "+str(Rec)+", Dex = "+str(Dex)+", Luc = "+str(Luc)+", Wis = "+str(Wis)+", Int = "+str(Int)+", LegacyMode = 0 WHERE CharID = "+str(charid)+""
	return ""
	
def UpdateCharS(charid, sptoadd, usesp):
	#print "UpdateChar()..."
	time.sleep(20)
	#print "Wait end"
	connection = SqlConnection(SSE_GetPyConnString())
	connection.Open()
	command = connection.CreateCommand()
	command.CommandText = """
	UPDATE PS_GameData.dbo.Chars SET SkillPoint = SkillPoint + @PointToAdd, UseSP = @UseSP WHERE CharID = @CharID					
	"""
	command.Parameters.Add(SqlParameter("@CharID", charid))				
	command.Parameters.Add(SqlParameter("@PointToAdd", sptoadd))				
	command.Parameters.Add(SqlParameter("@UseSP", usesp))
	#print "b4"
	reader = command.ExecuteReader()
	connection.Close()
	#print "UPDATE END CMD:"
	#print "UPDATE PS_GameData.dbo.Chars SET Map = "+str(MapID)+", PosX = "+str(PosX)+", PosY = "+str(PosY)+", @Posz = "+str(PosZ)+", StatPoint = "+str(StatPoint)+", SkillPoint = "+str(SkillPoint)+", Level = "+str(lvl)+", Str = "+str(Str)+", Rec = "+str(Rec)+", Dex = "+str(Dex)+", Luc = "+str(Luc)+", Wis = "+str(Wis)+", Int = "+str(Int)+", LegacyMode = 0 WHERE CharID = "+str(charid)+""
	return ""