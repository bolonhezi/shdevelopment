import sys
import os
import shutil
import pyodbc
import random
import ConfigParser
import xmldataset


conn_str = (
    r"Driver={SQL Server};"
    r"Server=(local);"
    r"Database=ps_gamedata;"
    r"Trusted_Connection=yes;"
    )

def getDbObject():
    try:
        conn=pyodbc.connect('Driver={SQL Server};SERVER=127.0.0.1;DATABASE=ps_gamedata;Trusted_Connection=yes;')
        return conn
    except Exception, e:
        for i in e.args:
            print i;
        print str(e.message)
        return None;




def excute_query(conn,sql, commit=False):
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


def excute(conn,sql, commit=False):
    result = excute_query(conn,sql, commit);

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

