def OnStartup():
	print("Loading core func...")
	return "05Shaiya Europe Console 2.1"

def OnCommand(Cmd, oj, etype, Charname, UserUID, Status, country, charid, arg1, arg2, arg3, arg4, optn, posx, pozy, posz, map, charlevel, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10):
	#AlertServer(Cmd)
	ret = ""
	if Cmd == "instantlvl":	
		ret = "000"
		args = oj.split(" ")
		lvl = args[1]
		if (lvl.isdigit() == True):
			lvl = int(lvl)		
			slvl = [15,30,60, 70, 80]
			if lvl in slvl:	
				#AlertPlayer("You issued instant level "+str(lvl),Charname)				
				#getting LegacyMode var
				connection = SqlConnection(conn)
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
					if Level == 1:
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
								PosZ = "175.27"
						elif lvl == 80:
							MapID = 81
							if Country == 0:
								PosX = "103.636"
								PosY = "4.414" 
								PosZ = "148.179" 
							else:
								PosX = "275.200" 
								PosY = "4.414" 
								PosZ = "148.179"
						KickChar(Charname)	
						#print "CMD:"
						#print "UPDATE PS_GameData.dbo.Chars SET Map = "+str(MapID)+", PosX = "+str(PosX)+", PosY = "+str(PosY)+", @Posz = "+str(PosZ)+", StatPoint = "+str(StatPoint)+", SkillPoint = "+str(SkillPoint)+", Level = "+str(lvl)+", Str = "+str(Str)+", Rec = "+str(Rec)+", Dex = "+str(Dex)+", Luc = "+str(Luc)+", Wis = "+str(Wis)+", Int = "+str(Int)+", LegacyMode = 0 WHERE CharID = "+str(charid)+""						thread.start_new_thread(UpdateChar, (charid, MapID, PosX, PosY, PosZ, lvl, SkillPoint, StatPoint, Str, Dex, Rec, Luc, Wis, Int))
						
						#print "a5"
					else:
						AlertPlayer("You must be level 1 to use !instantlvl please make a new char to use it.",Charname)					
				else:
					AlertPlayer("Your Character is UM, or you already used the !instantlvl in the past.",Charname)
			else:
				AlertPlayer("Unsuported lvl, please choose level 15, 30, 60, 70 or 80",Charname)
		else:
			AlertPlayer("Unsuported arugment, must be level 15 30, 60, 70 or 80",Charname)
	elif Cmd == "uc":
		connection = SqlConnection(conn)
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
		connection = SqlConnection(conn)
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
		connection = SqlConnection(conn)
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
		connectionlvl = SqlConnection(conn)
		connectionlvl.Open()
		command = connectionlvl.CreateCommand()
		command.CommandText = """SELECT * FROM PS_GameData.dbo.Chars WHERE CharID = @CharID"""
		command.Parameters.Add(SqlParameter("@CharID", charid))
		readerlvl = command.ExecuteReader()
		CurrentLvl = 0
		while readerlvl.Read():
			CurrentLvl = readerlvl["Level"]
		connection = SqlConnection(conn)
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
		connection = SqlConnection(conn)
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
		connection = SqlConnection(conn)
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
	connection = SqlConnection(conn)
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
			AlertPlayer("Without quotes, also replace xx bu the level that you want (15 30 60 70 or 80)",Charname)
			AlertPlayer("Once you did it, you'll repop on the wished pvp map with a ready-to-use stuff for free via npc.",Charname)
		else:
			AlertPlayer("You successfully created an Ultimate Mode Character, have fun with it!",Charname)
			AlertPlayer("NOTE: DONT FORGET TO BUY FREE 30D RES RUNE IN ITEM MALL",Charname)
		if IsNew == 1:
			if Country == 0:
				AlertServer("Welcome to "+Charname+" who joined Shaiya Europe for the first time ! (Faction: Alliance of Light)")
			else:
				AlertServer("Welcome to "+Charname+" who joined Shaiya Europe for the first time ! (Faction: Union of fury)")
			connection.Open()
			command = connection.CreateCommand()
			command.CommandText = """UPDATE PS_UserData.dbo.Users_Master SET IsNew = 0 WHERE UserUID = @UserUID"""
			command.Parameters.Add(SqlParameter("@UserUID", UserUID))
			reader = command.ExecuteReader()
			connection.Close()	
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
		connection = SqlConnection(conn)
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
		connection = SqlConnection(conn)
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
			KickChar(Charname)	
			connection = SqlConnection(conn)
			connection.Open()
			command = connection.CreateCommand()
			command.CommandText = """UPDATE PS_GameData.dbo.Chars SET LegacyMode = 0 WHERE CharID = @CharID"""
			command.Parameters.Add(SqlParameter("@CharID", charid))
			reader = command.ExecuteReader()
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
		returnstring = "03"+Charname+" joined the server for the first time!."	
	return "";

def OnInput(Cmd, param):
	retstr = ""
	if Cmd == "uc":
		connection = SqlConnection(conn)
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

def UpdateChar(charid, MapID, PosX, PosY, PosZ, lvl, SkillPoint, StatPoint, Str, Dex, Rec, Luc, Wis, Int):
	#print "UpdateChar()..."
	time.sleep(20)
	#print "Wait end"
	connection = SqlConnection(SSE_GetPyConnString())
	connection.Open()
	command = connection.CreateCommand()
	command.CommandText = """
	UPDATE PS_GameData.dbo.Chars SET Map = @MapID, PosX = @PosX, PosY = @PosY, Posz = @PosZ, StatPoint = @StatPoint, SkillPoint = @SkillPoint, Level = @Level, Str = @Str, Rec = @Rec, Dex = @Dex, Luc = @Luc, Wis = @Wis, Int = @Int, LegacyMode = 0 WHERE CharID = @CharID					
	"""
	command.Parameters.Add(SqlParameter("@CharID", charid))				
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