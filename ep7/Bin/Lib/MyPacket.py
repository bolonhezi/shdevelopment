import sys
import ConfigParser
import configobj

g_section = [
    "send_ignored",
    "recv_ignored",
    "send_collect",
    "recv_collect"
];

g_list = {};
g_fcollect = open("c:\\collect.log", 'a+')
g_configPath="c:\\packetconfig.ini"
#################################################
def packet_ignore(packet, direction):
    ret = False
    data = g_list[direction + "_ignored"]
    packet = packet[:5];
    for value in data:
        if value.lower() == packet.lower():  # example:"12 34" 5 size
            ret = True;
            break;
    return ret;


def collect(packet, direction):
    global g_fcollect;
    data = g_list[direction + "_collect"]
    for value in data:
        if value == packet[:5]:
            g_fcollect.write(direction + '>>' + packet + '\r\n');


########################################
def packet_arrived(packet):
    global g_fcollect;
    is_ignored = False;

    direction = packet[:4].lower();
    packet = packet[6:];

    # ignore
    is_ignored = packet_ignore(packet, direction)
    if is_ignored:
        return is_ignored;

    # others
    collect(packet, direction)

    return is_ignored;


def AddExInclude(packet):
    direction = packet[:4].lower();
    packet = packet[6:11];
    section = direction + "_ignored";
    data = g_list[section]

    #check if exists
    i = 1;
    for value in data:
        if value.lower() == packet.lower():  # example:"1f 34" 5 size
            return
        i = i + 1;

    # add to list
    g_list[section].append(packet);
    #write to file
    conf = configobj.ConfigObj(g_configPath)
    sec = conf[section]
    sec[str(i)] = packet
    conf.write()


def read_config():
    global g_fcollect;
    config = ConfigParser.ConfigParser();
    config.readfp(open(g_configPath));
    for section in g_section:
        data = [];
        for i in range(1, 100):
            try:
                value = config.get(section, str(i))
                data.append(value);
            except Exception, e:
                break;
        g_list[section] = data;


read_config();

