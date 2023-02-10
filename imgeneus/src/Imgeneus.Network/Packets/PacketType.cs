﻿namespace Imgeneus.Network.Packets
{
    public enum PacketType : ushort
    {
        // Character
        CHARACTER_LIST = 0x0101, // 257
        CREATE_CHARACTER = 0x0102, // 258
        DELETE_CHARACTER = 0x0103, // 259
        SELECT_CHARACTER = 0x0104, // 260
        CHARACTER_DETAILS = 0x0105,
        CHARACTER_ITEMS = 0x0106,
        CHECK_CHARACTER_AVAILABLE_NAME = 0x0119,
        CHARACTER_ADDITIONAL_STATS = 0x0526,
        CHARACTER_ATTACK_MOVEMENT_SPEED = 0x051C, // 1308
        CHARACTER_SHAPE_UPDATE = 0x051D, // 1309
        CHARACTER_ATTRIBUTE_SET = 0xF701, // 63233
        CHARACTER_MAX_HP_MP_SP = 0x051F, // 1311

        // Common
        HEARTBEAT = 0x0003,
        LOGOUT = 0x0107, // 263
        CHARACTER_SKILLS = 0x0108,
        ACCOUNT_FACTION = 0x0109, // 265
        CHARACTER_ACTIVE_BUFFS = 0x010A,
        CHARACTER_SKILL_BAR = 0x010B,
        QUIT_GAME = 0x010D,
        RENAME_CHARACTER = 0x010E,
        RESTORE_CHARACTER = 0x010F,

        // Login Server
        LOGIN_HANDSHAKE = 0xA101, // 41217
        LOGIN_REQUEST = 0xA102,
        OAUTH_LOGIN_REQUEST = 0xA110,
        SERVER_LIST = 0xA201,
        SELECT_SERVER = 0xA202,

        // Game
        GAME_HANDSHAKE = 0xA301,
        PING = 0xA303,
        CASH_POINT = 0x2605, // 9733
        CHANGE_ENCRYPTION = 0xB106, // I'm not really sure, that exactly this packet starts another encryption, but for now let's assume so.
        CHARACTER_SHAPE = 0x0303, // 771
        CHARACTER_MOTION = 0x0506,
        CHARACTER_CURRENT_HITPOINTS = 0x0521, // 1313
        CHARACTER_KILLINFO = 0x0522, // 1314
        CHARACTER_SHAPE_UPDATE_MOB = 0x0524, // 1316
        CHARACTER_ABSORPTION_DAMAGE = 0x0525, // 1317

        RUN_MODE = 0x0210, // 528

        USE_VEHICLE = 0x0216, // 534
        USE_VEHICLE_READY = 0x0217, // 535
        USE_VEHICLE_2 = 0x021C, // 540
        VEHICLE_REQUEST = 0x021D, // 541
        VEHICLE_RESPONSE = 0x021E, // 542
        INVENTORY_SORT = 0x021F, // 543

        // Map
        MAP_ADD_ITEM = 0x0401, // 1025
        MAP_REMOVE_ITEM = 0x0402, // 1026
        WORLD_DAY = 0x0404, // 1028
        CHARACTER_DEAD = 0x0405,
        MAP_WEATHER = 0x0451, // 1105

        // Attack
        AUTO_ATTACK_STOP = 0x0212, // 530
        SAVEPOS_RESULT = 0x0222, // 546

        CHANGE_APPEARANCE = 0x0226, // 550

        // Mobs
        MOB_ENTER = 0x0601, // 1537
        MOB_LEAVE = 0x0602, // 1538
        MOB_MOVE = 0x0603, // 1539
        MOB_ATTACK = 0x0605, // 1541
        MOB_DEATH = 0x0606, // 1542
        MOB_SKILL_KEEP = 0x0607, // 1543
        MOB_SET_SPEED = 0x0609, // 1545
        MOB_RECOVER = 0x0610, // 1552
        MOB_SKILL_USE = 0x060B, // 1547
        MOB_RANGE_SKILL_USE = 0x060D, // 1549

        // Char stats & skills
        UPDATE_STATS = 0x0208, // 520
        LEARN_NEW_SKILL = 0x0209, // 521
        SET_MONEY = 0x0213, // 531
        STATS_RESET = 0x0214, // 532
        AUTO_STATS_LIST = 0x0120, // 288
        AUTO_STATS_SET = 0x0121, // 289

        // Target
        TARGET_CHARACTER_HP_UPDATE = 0x0301, // 769
        TARGET_CHARACTER_MAX_HP = 0x0302, // 770
        TARGET_MOB_GET_STATE = 0x0304, // 772
        TARGET_MOB_HP_UPDATE = 0x0305, // 773
        TARGET_GET_CHARACTER_BUFFS = 0x0308, // 776
        TARGET_GET_MOB_BUFFS = 0x0309, // 777
        TARGET_CLEAR = 0x030A, // 778
        TARGET_BUFFS = 0x030B, // 779
        TARGET_BUFF_ADD = 0x030C, // 780
        TARGET_BUFF_REMOVE = 0x030D, // 781

        // PvP
        CHARACTER_MOVE = 0x0501, // 1281
        CHARACTER_CHARACTER_AUTO_ATTACK = 0x0502, // 1282
        CHARACTER_MOB_AUTO_ATTACK = 0x0503, // 1283
        CHARACTER_DEATH = 0x0504, // 1284
        CHARACTER_RECOVER = 0x0505, // 1285
        USE_ITEM = 0x050A, // 1290
        CHARACTER_MAX_HITPOINTS = 0x050B, // 1291
        USED_SP_MP = 0x050C, // 1292
        BUFF_ADD = 0x050D, // 1293
        BUFF_REMOVE = 0x050E, // 1294
        CHARACTER_SKILL_KEEP = 0x050F, // 1295
        CHARACTER_SKILL_CASTING = 0x0510, // 1296
        USE_CHARACTER_TARGET_SKILL = 0x0511, // 1297
        USE_CHARACTER_RANGE_SKILL = 0x0513, // 1299
        CHARACTER_SKILL_MIRROR = 0x0515, // 1301
        MOB_SKILL_CASTING = 0x0516, // 1302
        USE_MOB_TARGET_SKILL = 0x0517, // 1303
        USE_MOB_RANGE_SKILL = 0x0519, // 1305
        MOB_SKILL_MIRROR = 0x051B, // 1307
        TRANSFORMATION_MODE = 0x0534, // 1332
        DEAD_REBIRTH = 0x0551,// 1361
        REBIRTH_TO_NEAREST_TOWN = 0x0553, // 1363
        TOWN_TELEPORT = 0x0556, // 1366
        USE_ITEM_2 = 0x0557, // 1367
        CHARACTER_SCOUTING_INFO = 0x0558, // 1368
        CHARACTER_LEAVE_DEAD = 0x0406, // 1030

        // GM commands
        GM_COMMAND_GET_ITEM = 0xF702,
        GM_CREATE_MOB = 0xF704, // 63236
        GM_CLEAR_INVENTORY = 0xF802, // 63490
        GM_CLEAR_EQUIPMENT = 0xF803, // 63490
        GM_CLEAR_BUFFS = 0xF80E, // 63502, 
        GM_ATTACK_ON = 0xFA05, //64005
        GM_ATTACK_OFF = 0xFA06, //64006
        GM_TELEPORT_MAP_COORDINATES = 0xFA0A, // 64010
        GM_MUTE_PLAYER = 0xFA0D, // 64013
        GM_UNMUTE_PLAYER = 0xFA0E, // 64014
        GM_STOP_ON = 0xFA0F, // 64015
        GM_STOP_OFF = 0xFA10, // 64016
        GM_TELEPORT_MAP = 0xFA11, // 64017
        GM_CMD_ERROR = 0xF501, // -2815
        GM_CREATE_NPC = 0xF70C, // 63244, -2292
        GM_REMOVE_NPC = 0xF70D, // 63245, -2291FA
        GM_CHAR_ON = 0xFA01, // 64001
        GM_CHAR_OFF = 0xFA02, // 64002
        GM_FIND_PLAYER = 0xFA08, // 64008, -1528
        GM_TELEPORT_TO_PLAYER = 0xFA09, // 64009
        GM_SUMMON_PLAYER = 0xF904, //63748
        GM_TELEPORT_PLAYER = 0xF905, // 63749
        GM_CURE_PLAYER = 0xF801, // 63489
        GM_WARNING_PLAYER = 0xFA07, // 64007
        GM_SHAIYA_US_SUMMON_PLAYER = 0xFA24,
        GM_SHAIYA_US_CREATE_MOB = 0xFA26,
        GM_SHAIYA_US_CLEARE_MOB_IN_TARGET = 0xFA28, // 64040
        GM_SHAIYA_US_CREATE_NPC = 0xFA32,
        GM_SHAIYA_US_REMOVE_NPC = 0xFA33,
        GM_SHAIYA_US_NOTICE_WORLD = 0xFA35,
        GM_SHAIYA_US_TELEPORT_PLAYER = 0xFA37,
        GM_SHAIYA_US_CURE_PLAYER = 0xFA38,
        GM_SHAIYA_US_ATTRIBUTE_SET = 0xFA39,

        // Map
        CHARACTER_ENTERED_MAP = 0x0201, // 513
        CHARACTER_LEFT_MAP = 0x0202,  // 514
        CHARACTER_ENTERED_PORTAL = 0x020A, // 522
        CHARACTER_MAP_TELEPORT = 0x020B, // 523
        CHARACTER_TELEPORT_VIA_NPC = 0x20C, // 524
        MAP_NPC_ENTER = 0x0E01, // 3585
        MAP_NPC_LEAVE = 0x0E02, // 3586
        MAP_NPC_MOVE = 0x0E03, // 3587
        MAP_NPC_ATTACK_PLAYER = 0x0E05, // 3589
        MAP_NPC_ATTACK_MOB = 0x0E06, // 3590

        // Obelisk
        OBELISK_LIST = 0x2101, // 8449
        OBELISK_CHANGE = 0x2102, // 8450

        // Inventory
        INVENTORY_MOVE_ITEM = 0x0204, // 516
        ADD_ITEM = 0x0205, // 517
        REMOVE_ITEM = 0x0206, // 518
        SEND_EQUIPMENT = 0x0507, // 1287
        ITEM_EXPIRATION = 0x22E, // 558
        ITEM_EXPIRED = 0x022F, // 559

        // Trade
        TRADE_REQUEST = 0x0A01, // 2561
        TRADE_RESPONSE = 0x0A02, // 2562
        TRADE_START = 0x0A03, // 2563
        TRADE_STOP = 0x0A04, // 2564
        TRADE_FINISH = 0x0A05, // 2565
        TRADE_OWNER_ADD_ITEM = 0x0A06, // 2566
        TRADE_REMOVE_ITEM = 0x0A07, // 2567
        TRADE_ADD_MONEY = 0x0A08, // 2568
        TRADE_RECEIVER_ADD_ITEM = 0x0A09, // 2569
        TRADE_DECIDE = 0xA0A, // 2570

        // Party
        PARTY_LIST = 0x0B01, // 2817
        PARTY_REQUEST = 0x0B02, // 2818
        PARTY_RESPONSE = 0x0B03, // 2819
        PARTY_ENTER = 0x0B04, // 2820
        PARTY_LEAVE = 0x0B05, // 2821
        PARTY_KICK = 0x0B06, // 2822
        PARTY_CHANGE_LEADER = 0x0B07, // 2823
        PARTY_MEMBER_GET_ITEM = 0x0B08, // 2824
        PARTY_SEARCH_INVITE = 0x0B09, // 2825
        PARTY_CHARACTER_SP_MP = 0x0C01, // 3073
        PARTY_SET_MAX = 0x0C02, // 3074
        PARTY_ADDED_BUFF = 0x0C04, // 3076
        PARTY_REMOVED_BUFF = 0x0C05, // 3077
        MAP_PARTY_SET = 0x0520, // 1312
        PARTY_MEMBER_LEVEL = 0x0C09, // 3081
        PARTY_MEMBER_MAX_HP_SP_MP = 0x0C08, // 3080
        PARTY_MEMBER_HP_SP_MP = 0x0C03, // 3075

        // Raid
        RAID_LIST = 0x0B0B, // 2827
        RAID_ENTER = 0x0B0C, // 2828
        RAID_LEAVE = 0x0B0D, // 2829
        RAID_CREATE = 0x0B0E, // 2830
        RAID_CHANGE_LOOT = 0x0B0F, // 2831
        RAID_CHANGE_AUTOINVITE = 0x0B10, // 2832
        RAID_JOIN = 0x0B11, // 2833
        RAID_MOVE_PLAYER = 0x0B12, // 2834
        RAID_CHANGE_SUBLEADER = 0x0B13, // 2835
        RAID_INVITE = 0x0B14, // 2836
        RAID_RESPONSE = 0x0B15, // 2837
        RAID_DISMANTLE = 0x0B16, // 2838
        RAID_CHANGE_LEADER = 0x0B17, // 2839
        RAID_PARTY_ERROR = 0x0B19, // 2841
        RAID_KICK = 0x0B1A, // 2842
        RAID_CHARACTER_SP_MP = 0x0C0A, // 3082
        RAID_SET_MAX = 0x0C0B, // 3083
        RAID_ADDED_BUFF = 0x0C0E, // 3086
        RAID_REMOVED_BUFF = 0x0C10, // 3088
        RAID_MEMBER_GET_ITEM = 0x0C14, // 3092

        // Summon
        ITEM_CASTING = 0x0221, // 545
        ITEM_CASTING_FINISHED = 0x0222, // 546
        PARTY_CALL_REQUEST = 0x0223, // 547
        PARTY_CALL_ANSWER = 0x0224, // 548

        // Chat
        CHAT_NORMAL_ADMIN = 0xF101, // 61697, -3837
        CHAT_WHISPER_ADMIN = 0xF102, // 61698, -3838
        CHAT_WORLD_ADMIN = 0xF103, // 61699, -3837
        CHAT_GUILD_ADMIN = 0xF104, //  61700, -3836
        CHAT_PARTY_ADMIN = 0xF105, // 61701, -3835
        CHAT_SERVER_MANAGER_NT = 0xF106, // 61702, -3834
        CHAT_SEND_TO_FIND_USER = 0xF107, // 61703, -3833
        CHAT_SEND_TO = 0xF108, // 61704, -3832
        CHAT_SEND_TO_END = 0xF109, // 61705, -3831
        CHAT_RAID_ADMIN = 0xF10A, // 61706, -3830

        CHAT_NORMAL = 0x1101, // 4353
        CHAT_WHISPER = 0x1102, // 4354
        CHAT_WORLD = 0x1103, // 4355
        CHAT_GUILD = 0x1104, // 4356
        CHAT_PARTY = 0x1105, // 4357
        CHAT_USER_DOES_NOT_EXIST = 0x1106, // 4358
        CHAT_SHOUT = 0x1107, // 4359
        CHAT_MESSAGE_TO_SERVER = 0x1108, // 4360
        CHAT_MAP = 0x1111, // 4369
        CHAT_RAID = 0x1112, // 4370

        // Notice
        NOTICE_ADMINS = 0xF906, // 63750
        NOTICE_FACTION = 0xF907, // 63751
        NOTICE_PLAYER = 0xF908, // 63752
        NOTICE_MAP = 0xF909, // 63753
        NOTICE_WORLD = 0xF90B, // 63755

        // My shop
        MY_SHOP_BEGIN = 0x2301, // 8961
        MY_SHOP_END = 0x2302, // 8962
        MY_SHOP_START = 0x2303, // 8963
        MY_SHOP_CANCEL = 0x2304, // 8964
        MY_SHOP_ADD_ITEM = 0x2305, // 8965
        MY_SHOP_REMOVE_ITEM = 0x2306, // 8966
        MY_SHOP_SOLD_ITEM = 0x2308, // 8968
        MY_SHOP_VISIT = 0x2309, // 8969
        MY_SHOP_LEAVE = 0x230A, // 8970
        MY_SHOP_ITEM_LIST = 0x230B, // 8971
        MY_SHOP_USE_STOP = 0x230C, // 8972
        MY_SHOP_BUY_ITEM = 0x230D, // 8973
        MY_SHOP_USE_SHOP_ITEM_COUNT = 0x230E, // 8974
        MY_SHOP_INFO = 0x0523, // 1315

        // Duel
        DUEL_REQUEST = 0x2401, // 9217
        DUEL_RESPONSE = 0x2402, // 9218
        DUEL_READY = 0x2403, // 9219
        DUEL_START = 0x2404, // 9220
        DUEL_WIN_LOSE = 0x2405, // 9221
        DUEL_CANCEL = 0x2406, // 9222
        DUEL_TRADE = 0x2407, // 9223
        DUEL_CLOSE_TRADE = 0x2408, // 9224
        DUEL_TRADE_OK = 0x2409, // 9225
        DUEL_TRADE_ADD_ITEM = 0x240A, // 9226
        DUEL_TRADE_REMOVE_ITEM = 0x240B, // 9227
        DUEL_TRADE_ADD_MONEY = 0x240C, // 9228
        DUEL_TRADE_OPPONENT_ADD_ITEM = 0x240D, // 9229

        // NPC Shop
        NPC_BUY_ITEM = 0x0702, // 1794
        NPC_SELL_ITEM = 0x0703, // 1795

        // Quests
        QUEST_LIST = 0x0901, // 2305
        QUEST_START = 0x0902, // 2306
        QUEST_END = 0x0903, // 2307
        QUEST_UPDATE_COUNT = 0x0905, // 2309
        QUEST_FINISHED_LIST = 0x0906, // 2310
        QUEST_END_SELECT = 0x0907, // 2311
        QUEST_QUIT = 0x0908, // 2312

        // Bless
        USER_KILLCOUNT_UPDATE = 0x020E, // 526
        BLESS_UPDATE = 0x020F, // 527
        BLESS_INIT = 0x0211, // 529

        // Reset stones
        RESET_SKILLS = 0x0215, // 533

        // ?
        CHARACTER_HONOR = 0230, // 560

        // Friends
        FRIEND_LIST = 0x2201, // 8705
        FRIEND_REQUEST = 0x2202, // 8706
        FRIEND_RESPONSE = 0x2203, // 8707
        FRIEND_ADD = 0x2204, // 8708
        FRIEND_DELETE = 0x2205, // 8709
        FRIEND_ONLINE = 0x2207, // 8711

        // Party search
        PARTY_SEARCH_REGISTRATION = 0x220C, // 8716
        PARTY_SEARCH_LIST = 0x220D, // 8717

        // Linking
        GEM_ADD = 0x0801, // 2049
        GEM_REMOVE = 0x0802, // 2050
        CLOACK_ADD = 0x0803, // 2051
        CLOACK_REMOVE = 0x0804, // 2052
        ENCHANT_ADD = 0x0805, // 2053
        ITEM_COMPOSE = 0x0806, // 2054
        ITEM_REMAKE = 0x0807, // 2055
        ITEM_CONSIDER = 0x0808, // 2056
        GEM_ADD_POSSIBILITY = 0x0809, // 2057
        GEM_REMOVE_POSSIBILITY = 0x080A, // 2058
        RUNE_SYNTHESIZE = 0x080D, // 2061
        ENCHANT_RATE = 0x0816, // 2070
        ITEM_COMPOSE_ABSOLUTE = 0x0834, // 2100
        ITEM_COMPOSE_ABSOLUTE_SELECT = 0x0835, // 2101

        // Guild & Guild Rank Battle (GRB)
        GUILD_DISMANTLE = 0x0D03, // 3331
        GUILD_JOIN_REQUEST = 0x0D07, // 3335
        GUILD_JOIN_RESULT_USER = 0x0D08, // 3336
        GUILD_LEAVE = 0x0D09, // 3337
        GUILD_KICK = 0x0D0A, // 3338
        GUILD_USER_STATE = 0x0D0C, // 3340
        GUILD_LIST_LOADING_START = 0x0D0D, // 3341
        GUILD_LIST_LOADING_END = 0x0D0E, // 3342
        GUILD_LIST_REMOVE = 0x0D11, // 3345
        GUILD_USER_LIST_ONLINE = 0x0D12, // 3346
        GUILD_USER_LIST_NOT_ONLINE = 0x0D13, // 3347
        GUILD_USER_LIST_ADD = 0x0D14, // 3348
        GUILD_JOIN_LIST = 0x0D16, // 3350
        GUILD_JOIN_LIST_ADD = 0x0D17, // 3351
        GUILD_JOIN_LIST_REMOVE = 0x0D18, // 3352
        GUILD_CREATE = 0x0D21, // 3361
        GUILD_CREATE_AGREE = 0x0D22, // 3362
        GUILD_GET_ETIN = 0x0D23, // 3363
        GUILD_NPC_LIST = 0x0D24, // 3364
        GUILD_NPC_UPGRADE = 0x0D25, // 3365
        GRB_NOTICE = 0x0D26, // 3366
        GRB_POINTS = 0x0D27, // 3367
        GUILD_HOUSE_ACTION_ERR = 0x0D28, // 3368
        GUILD_WAREHOUSE_ITEM_LIST = 0x0D29, // 3369
        GUILD_LIST = 0x0D2F, // 3375
        GUILD_LIST_ADD = 0x0D30, // 3376
        GUILD_WAREHOUSE_ITEM_ADD = 0x0D31, // 3377
        GUILD_WAREHOUSE_ITEM_REMOVE = 0x0D32, // 3378
        GUILD_HOUSE_KEEP_ETIN = 0x0D33, // 3379
        GUILD_HOUSE_BUY = 0x0D34, // 3380
        GUILD_ETIN_RETURN = 0x0D35, // 3381
        GUILD_PVP_WIN = 0x0D36, // 3382
        GUILD_RANK_UPDATE = 0x0D37, // 3383

        // Teleport
        TELEPORT_PRELOADED_TOWN = 0x055A, // 1370
        TELEPORT_PRELOADED_AREA = 0x0250, // 592
        TELEPORT_SAVE_POSITION = 0x0220, // 544
        TELEPORT_SAVE_POSITION_LIST = 0x0225, // 549
        TELEPORT_TO_BATTLEGROUND = 0x0245, // 581

        // Dyeing
        DYE_CONFIRM = 0x055B, // 1371
        DYE_REROLL = 0x055C, // 1372
        DYE_SELECT_ITEM = 0x055D, // 1373

        // Experience and Leveling
        EXPERIENCE_GAIN = 0x0207, // 519
        CHARACTER_LEVEL_UP_MYSELF = 0x0508, // 1288
        CHARACTER_LEVEL_UP_OTHER = 0x051E, // 1310

        // Bank
        BANK_ITEM_LIST = 0xB101, // 45313
        BANK_CLAIM_ITEM = 0xB102, // 45314

        // Warehouse
        WAREHOUSE_ITEM_LIST = 0x0711, // 1809

        // Chaotic Square
        CHAOTIC_SQUARE_LIST = 0x0830,
        CHAOTIC_SQUARE_RECIPE = 0x0831,
        CHAOTIC_SQUARE_CREATE = 0x0832,
        CHAOTIC_SQUARE_CREATE_2 = 0x0833,

        // Market
        MARKET_SEARCH_FIRST = 0x1C01, // 7169
        MARKET_SEARCH_FIRST_ITEM_ID = 0x1C02, // 7170
        MARKET_SEARCH_SECTION = 0x1C03, // 7171
        MARKET_GET_SELL_LIST = 0x1C04, // 7172
        MARKET_GET_TENDER_LIST = 0x1C05, // 7173
        MARKET_GET_END_ITEM_LIST = 0x1C06, // 7174
        MARKET_GET_END_MONEY_LIST = 0x1C07, // 7175
        MARKET_REGISTER_ITEM = 0x1C08, // 7176
        MARKET_UNREGISTER_ITEM = 0x1C09, // 7177
        MARKET_DIRECT_BUY = 0x1C0A, // 7178
        MARKET_TENDER = 0x1C0B, // 7179
        MARKET_GET_ITEM = 0x1C0C, // 7180
        MARKET_GET_MONEY = 0x1C0D, // 7181
        MARKET_GET_CONCERN_LIST = 0x1C14, // 7188
        MARKET_ADD_CONCERT_MARKET = 0x1C15, // 7189
        MARKET_REMOVE_CONCERT_MARKET = 0x1C16, // 7190
        MARKET_CONCERT_REMOVE_ALL = 0x1C17, // 7191

        // Account
        ACCOUNT_POINTS = 0x2601, // 9729

        // Kill status
        KILLSTATUS_RESULT_INFO = 0x0218, // 536
        KILLS_GET_REWARD = 0x0219, // 537
        DEATHS_GET_REWARD = 0x021A, // 538

        // Infinite sanctuary
        INFINITE_SANCTUARY = 0x0234 // 564
    }
}