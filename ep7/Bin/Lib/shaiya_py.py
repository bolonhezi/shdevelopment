import sys
import os
import shutil
import pyodbc
import random
import ConfigParser
import xmldataset



conn = pyodbc.connect('DRIVER={SQL Server};SERVER=127.0.0.1;DATABASE=ps_gamedata;UID=EP3DJ12*@DI4*D2;PWD=HT302*D824@*+@DFK342')

shaiya_data_folder="C:\ShaiyaServer\PSM_Client\Bin\Data";

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



# country,level,map,x,y,z
battlefield_data = [
 [0, 15, 18, 409.865, 20.388, 136.551],
 [1, 15, 18, 865.411, 2.900, 646.338],
 [0, 30, 30, 307.948, 3.084, 314.254],
 [1, 30, 30, 820.371, 32.451, 753.439],
 [0, 80, 0, 222.842, 26.460, 1835.708],
 [1, 80, 0, 1878.060, 14.693, 379.272],
 [0, 60, 45, 923.470, 9.350, 864.520],
 [1, 60, 45, 859.460, 3.700, 308.090],
 [0, 79, 70, 1481.230, 33.160, 163.250],
 [1, 79, 70, 155.230, 39.173, 175.270],
 [0, 80, 81, 346.782, 16.910, 47.790],
 [1, 80, 81, 405.181, 16.928, 50.423]

];


def battlefield_moveable(country, level, map):
    ret = "0,0,0,0,0";  # moveable,map,x,y,z
    for row in battlefield_data:
        if country == int(row[0]) and level <= int(row[1]) and map == int(row[2]):
            ret = "1,%d,%f,%f,%f" % (row[2], row[3], row[4], row[5]);
            break;
    return ret;


def set_expriedTime(charid, bag, slot, time):
    pass

def get_expiredTime(charid, bag, slot):
    sql = "select expiredTime from ps_gamedata.dbo.charitems where charid=%d,bag=%d,slot=%d" % (charid, bag, slot);
    return excute(conn,sql);


def set_auto_stats(charid, auto_str, auto_dex, auto_rec, auto_luc, auto_wis, auto_int):
    sql = "update ps_gamedata.dbo.chars set auto_str=%d,auto_dex=%d,auto_rec=%d,auto_luc=%d,auto_wis=%d,auto_int=%d" % (auto_str, auto_dex, auto_rec, auto_luc, auto_wis, auto_int)
    excute(conn,sql, True);
    return True;


def get_auto_stats(charid):
    sql = "select auto_str,auto_dex,auto_rec,auto_luc,auto_wis,auto_int from ps_gamedata.dbo.chars where charid=%d" %(charid);
    return excute(conn,sql);


def AvailiableCharName(charname):
    ret = 1;
    sql = "select top 1 charid from ps_gamedata.dbo.chars where charname='%s'" % charname;
    result = excute(conn,sql);
    if len(result):
        ret = 0
    return ret;

def GetPetAndCostumeId(charname):
    pet_type = 1;
    pet_id = 1;
    costume_type = 1;
    costume_id = 1;
    wing_type = 1;
    wing_id = 1;
    charid=1;

    #get charid
    sql="select charid from ps_gamedata.dbo.chars where charname='%s' and del=0"%(charname);
    result = excute(conn,sql);
    if len(result):
        charid= int(result);

    if charid:
        # pet
        sql = "select type,typeid from ps_gamedata.dbo.charitems where charid=%d and bag=0 and slot=14 and del=0"  % charid
        result = excute_query(conn,sql);
        if len(result):
            row=result[0];
            pet_type = row[0];
            pet_id = row[1];

        # costume
        sql = "select type,typeid from ps_gamedata.dbo.charitems where charid=%d and bag=0 and slot=15 and del=0" % charid
        result = excute_query(conn,sql);
        if len(result):
            row = result[0];
            costume_type = row[0];
            costume_id = row[1];
        # wing
        sql = "select type,typeid from ps_gamedata.dbo.charitems where charid=%d and bag=0 and slot=16 and del=0" % charid
        result = excute_query(conn,sql);
        if len(result):
            row = result[0];
            wing_type = row[0];
            wing_id = row[1];

    return "%d,%d,%d,%d,%d,%d" % (pet_type, pet_id, costume_type, costume_id, wing_type, wing_id);



def get_random_dye():
    data="";
    for i in range(0,5):
        rand_1 = random.randint(0, 99)<<24;
        rand_2 = random.randint(0, 50)<<16;
        rand_3 = random.randint(0, 255)<<8;
        rand_4 = random.randint(0, 255);
        data=data+"%ld,"%(rand_1+rand_2+rand_3+rand_4)
    return data[:-1];


def usepoint(useruid, used_point):
    sql = "update ps_userdata.dbo.users_master set point=point+%d where useruid=%d" % (used_point, useruid);
    excute(conn,sql, True)


def getpoint(useruid):
    point = 0;
    sql = "select top 1 point from ps_userdata.dbo.users_master where useruid=%d" % (useruid);
    result = excute(conn,sql);
    if len(result):
        point = long(result)
    return point



def get_dyecolor(itemuid):
    sql="select dye1,dye2,dye3 from item_addition where itemuid=%ld"%(itemuid);
    return excute(conn,sql);



def get_dyecolor_byCharid(charid,slot):
    sql ="select itemuid from charitems where charid=%d and bag=0 and slot=%d"%(charid,slot)
    ret=excute(conn,sql);
    if not len(ret):
        return  ret;

    itemuid=long(ret)
    return get_dyecolor(itemuid)


def get_dyecolor_byName(charname,slot):
    sql ="select top 1 itemuid from charitems where   bag=0 and slot=%d and charid in (select charid from chars where charname='%s')"%(slot,charname)
    ret=excute(conn,sql);
    if not len(ret):
        return "";

    itemuid=long(ret)
    return get_dyecolor(itemuid)



def save_dyecolor(itemuid,color1,color2,color3):
    #check if existd
    if len(get_dyecolor(itemuid)):
        sql="update item_addition set dye1=%d,dye2=%d,dye3=%d where itemuid=%ld"%(color1,color2,color3,itemuid)
        return excute(conn,sql,True);
    else:
        sql="insert into item_addition values(%ld,%d,%d,%d,getdate())"%(itemuid,color1,color2,color3)
        return excute(conn,sql,True);







