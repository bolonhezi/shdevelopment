import sys
import os
import shutil
import pyodbc
import random
import ConfigParser
import xmldataset



conn = pyodbc.connect('DRIVER={SQL Server};SERVER=127.0.0.1;DATABASE=ps_gamedata;UID=Shaiya;PWD=Shaiya123')

shaiya_data_folder="C:\\ShaiyaServer\\SERVER\\PSM_Client\\Bin\\Data\\";


def excute_query(sql, commit=False):
    cur = conn.cursor();
    pyodbc.Cursor.execute(cur, sql);
    if commit:
        pyodbc.Cursor.commit(cur);
        pyodbc.Cursor.close(cur);
        return;
    row = cur.fetchone()

    result = [];
    while row:
        result.append(row);
        row = cur.fetchone();
    pyodbc.Cursor.close(cur);
    return result;


def excute(sql, commit=False):
    result = excute_query(sql, commit);

    #update query
    if commit:
        return ;
    data = "";
    #select query
    if len(result):
        for row in result:
            for column in row[:-1]:
                data = data + str(column)+','
            data = data+str(row[-1])+'\r\n';
    if data[-2:]=='\r\n':
        data=data[:-2];
    return data;




def Mysprintf(*Mystr):
    ret = "";
    for name in Mystr:
        ret = ret + str(name) + ','
    ret = ret + '\n'
    if len(ret):
        ret = ret[:-2];
    return ret;


#############-----------------------------------------------#########################

# country,level,map,x,y,z

battleField_key = [
   ['MAP_NO','int'],
   ['LEVEL_MIN','int'],
   ['LEVEL_MAX','int'],
   ['x','float'],
   ['y','float'],
   ['z','float'],
   ['country','int']
];
battleField_data=[];



MoveTownInfo_key = [
   ['MapID','int'],
   ['x','float'],
   ['y','float'],
   ['z','float'],
   ['country','int']
];
MoveTownInfo_data={};


def common_readConfig(config,section,key):
    if key[1]=='int':
        return config.getint(section,key[0])
    if key[1]=='float':
        return config.getfloat(section,key[0])

def common_readXml(Elements,key):
    if key[1]=='int':
        return int( Elements.getAttribute(key[0]))
    if key[1]=='float':
        return float( Elements.getAttribute(key[0]))


def load_battleField():
    config = ConfigParser.ConfigParser();
    config.readfp(open(shaiya_data_folder+'BattleFieldMoveInfo_Client.ini'));
    count=config.getint("BATTLEFIELD_INFO","BATTLEFIELD_COUNT");
    for i in range(0,count):
        section='BATTLEFIELD_'+str(i+1);
        data={};
        for row in battleField_key:
            data[row[0]]=common_readConfig(config,section,row)

        battleField_data.append(data);
    return

def load_GeneralMoveTowns():
    global  MoveTownInfo_data
    filePath = shaiya_data_folder + 'GeneralMoveTowns_Client.xml'
    f=open(filePath,'r')
    xml=""
    for row in f.readlines():
        xml=xml+row
    f.close();
    profile = """
    CONTENTS
       MOVETOWN_SCROLL
           MoveTownInfo
                ID = dataset:ID
                country=dataset:country
                x=dataset:x
                y=dataset:y
                z=dataset:z
                MapID=dataset:MapID
                """
    MoveTownInfo_data = xmldataset.parse_using_profile(xml,profile)
    return


def battlefield_moveable(country, level, map):
    ret = "0,0,0,0,0";  # moveable,map,x,y,z
    for data in battleField_data:
        if (country == data['country'] or data['country']==2) and level>=data['LEVEL_MIN']and level<=data['LEVEL_MAX'] and map==data['MAP_NO']:
            ret = "1,%d,%f,%f,%f" % (data['MAP_NO'],data['x'],data['y'],data['z']);
            break;
    return ret;

def GeneralMoveTowns_moveable(scrollID,country):
    global MoveTownInfo_data;
    ret = "0,0,0,0,0";  # moveable,map,x,y,z
    if scrollID==0:
        return ret;
    if scrollID<=len(MoveTownInfo_data['ID']):
        i=scrollID-1;
        _country=int(MoveTownInfo_data['country'][i]['country'])
        if _country==country or _country==2:
            ret = "1,%d,%f,%f,%f" % (int(MoveTownInfo_data['MapID'][i]['MapID']),
                                     float(MoveTownInfo_data['x'][i]['x']),
                                     float(MoveTownInfo_data['y'][i]['y']),
                                     float(MoveTownInfo_data['z'][i]['z']))
    return ret




def set_expriedTime(charid, bag, slot, time):
    pass

def get_expiredTime(charid, bag, slot):
    sql = "select expiredTime from ps_gamedata.dbo.charitems where charid=%d,bag=%d,slot=%d" % (charid, bag, slot);
    return excute(sql);


def set_auto_stats(charid, auto_str, auto_dex, auto_rec, auto_luc, auto_wis, auto_int):
    sql = "update ps_gamedata.dbo.chars set auto_str=%d,auto_dex=%d,auto_rec=%d,auto_luc=%d,auto_wis=%d,auto_int=%d" % (auto_str, auto_dex, auto_rec, auto_luc, auto_wis, auto_int)
    excute(sql, True);
    return True;


def get_auto_stats(charid):
    sql = "select auto_str,auto_dex,auto_rec,auto_luc,auto_wis,auto_int from ps_gamedata.dbo.chars where charid=%d" %(charid);
    return excute(sql);


def AvailiableCharName(charname):
    ret = 1;
    sql = "select top 1 charid from ps_gamedata.dbo.chars where charname='%s'" % charname;
    result = excute(sql);
    if len(result):
        ret = 0
    return ret;

def GetPetAndCostumeId(charname):
    pet_type = 0;
    pet_id = 0;
    costume_type = 0;
    costume_id = 0;
    wing_type = 0;
    wing_id = 0;
    charid=0;

    #get charid
    sql="select charid from ps_gamedata.dbo.chars where charname='%s' and del=0"%(charname);
    result = excute(sql);
    if len(result):
        charid= int(result);

    if charid:
        # pet
        sql = "select type,typeid from ps_gamedata.dbo.charitems where charid=%d and bag=0 and slot=14 and del=0"  % charid
        result = excute_query(sql);
        if len(result):
            row=result[0];
            pet_type = row[0];
            pet_id = row[1];

        # costume
        sql = "select type,typeid from ps_gamedata.dbo.charitems where charid=%d and bag=0 and slot=15 and del=0" % charid
        result = excute_query(sql);
        if len(result):
            row = result[0];
            costume_type = row[0];
            costume_id = row[1];
        # wing
        sql = "select type,typeid from ps_gamedata.dbo.charitems where charid=%d and bag=0 and slot=16 and del=0" % charid
        result = excute_query(sql);
        if len(result):
            row = result[0];
            wing_type = row[0];
            wing_id = row[1];

    return "%d,%d,%d,%d,%d,%d" % (pet_type, pet_id, costume_type, costume_id, wing_type, wing_id);



def get_random_dye():
    data="";
    for i in range(0,5):
        rand_1 = random.randint(0, 99)<<24;
        rand_2 = random.randint(0, 255)<<16;
        rand_3 = random.randint(0, 120)<<8;
        rand_4 = random.randint(0, 255);
        data=data+"%ld,"%(rand_1+rand_2+rand_3+rand_4)
    return data[:-1];


def usepoint(useruid, used_point):
    sql = "update ps_userdata.dbo.users_master set point=point+%d where useruid=%d" % (used_point, useruid);
    excute(sql, True)


def getpoint(useruid):
    point = 0;
    sql = "select top 1 point from ps_userdata.dbo.users_master where useruid=%d" % (useruid);
    result = excute(sql);
    if len(result):
        point = int(result)
    return point



def get_dyecolor(itemuid):
    sql="select dye1,dye2,dye3 from item_addition where itemuid=%ld"%(itemuid);
    return excute(sql);



def get_dyecolor_byCharid(charid,slot):
    sql ="select itemuid from charitems where charid=%d and bag=0 and slot=%d"%(charid,slot)
    ret=excute(sql);
    if not len(ret):
        return  ret;

    itemuid=int(ret)
    return get_dyecolor(itemuid)


def get_dyecolor_byName(charname,slot):
    sql = "select charid from chars where charname='%s'"%(charname)
    ret = excute(sql)
    if not len(ret):
        return ret;

    charid=int(ret)
    sql ="select itemuid from charitems where charid=%d and bag=0 and slot=%d"%(charid,slot)
    ret=excute(sql);
    if not len(ret):
        return  ret;

    itemuid=int(ret)
    return get_dyecolor(itemuid)


def save_dyecolor(itemuid,color1,color2,color3):
    #check if existd
    if len(get_dyecolor(itemuid)):
        sql="update item_addition set dye1=%d,dye2=%d,dye3=%d where itemuid=%ld"%(color1,color2,color3,itemuid)
        return excute(sql,True);
    else:
        sql="insert into item_addition values(%ld,%d,%d,%d,getdate())"%(itemuid,color1,color2,color3)
        return excute(sql,True);


def get_namecolor():
    sql = "select top 2 charid,color from ps_gamedata.dbo.chars where color>0"
    return excute(sql);



load_battleField();
load_GeneralMoveTowns();
