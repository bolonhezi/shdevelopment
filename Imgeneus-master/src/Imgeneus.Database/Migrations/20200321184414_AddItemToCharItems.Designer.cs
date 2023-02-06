﻿// <auto-generated />
using System;
using Imgeneus.Database.Context;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

namespace Imgeneus.Database.Migrations
{
    [DbContext(typeof(DatabaseContext))]
    [Migration("20200321184414_AddItemToCharItems")]
    partial class AddItemToCharItems
    {
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "3.1.0")
                .HasAnnotation("Relational:MaxIdentifierLength", 64);

            modelBuilder.Entity("Imgeneus.Database.Entities.DbCharacter", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<ushort>("Angle")
                        .HasColumnType("smallint unsigned");

                    b.Property<byte>("Class")
                        .HasColumnType("tinyint unsigned");

                    b.Property<DateTime>("CreateTime")
                        .HasColumnType("DATETIME");

                    b.Property<ushort>("Deaths")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("Defeats")
                        .HasColumnType("smallint unsigned");

                    b.Property<DateTime?>("DeleteTime")
                        .HasColumnType("datetime(6)");

                    b.Property<ushort>("Dexterity")
                        .HasColumnType("smallint unsigned");

                    b.Property<uint>("Exp")
                        .HasColumnType("int unsigned");

                    b.Property<byte>("Face")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("Gender")
                        .HasColumnType("tinyint unsigned");

                    b.Property<uint>("Gold")
                        .HasColumnType("int unsigned");

                    b.Property<byte>("Hair")
                        .HasColumnType("tinyint unsigned");

                    b.Property<ushort>("HealthPoints")
                        .HasColumnType("smallint unsigned");

                    b.Property<byte>("Height")
                        .HasColumnType("tinyint unsigned");

                    b.Property<ushort>("Intelligence")
                        .HasColumnType("smallint unsigned");

                    b.Property<bool>("IsDelete")
                        .HasColumnType("tinyint(1)");

                    b.Property<bool>("IsRename")
                        .HasColumnType("tinyint(1)");

                    b.Property<ushort>("Kills")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("Level")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("Luck")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("ManaPoints")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("Map")
                        .HasColumnType("smallint unsigned");

                    b.Property<byte>("Mode")
                        .HasColumnType("tinyint unsigned");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("varchar(16) CHARACTER SET utf8mb4")
                        .HasMaxLength(16);

                    b.Property<float>("PosX")
                        .HasColumnType("float");

                    b.Property<float>("PosY")
                        .HasColumnType("float");

                    b.Property<float>("PosZ")
                        .HasColumnType("float");

                    b.Property<byte>("Race")
                        .HasColumnType("tinyint unsigned");

                    b.Property<ushort>("Rec")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("SkillPoint")
                        .HasColumnType("smallint unsigned");

                    b.Property<byte>("Slot")
                        .HasColumnType("tinyint unsigned");

                    b.Property<ushort>("StaminaPoints")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("StatPoint")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("Strength")
                        .HasColumnType("smallint unsigned");

                    b.Property<int>("UserId")
                        .HasColumnType("int");

                    b.Property<ushort>("Victories")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("Wisdom")
                        .HasColumnType("smallint unsigned");

                    b.HasKey("Id");

                    b.HasIndex("UserId");

                    b.ToTable("Characters");
                });

            modelBuilder.Entity("Imgeneus.Database.Entities.DbCharacterItems", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<byte>("Bag")
                        .HasColumnType("tinyint unsigned");

                    b.Property<int>("CharacterId")
                        .HasColumnType("int");

                    b.Property<byte>("Count")
                        .HasColumnType("tinyint unsigned");

                    b.Property<string>("Craftname")
                        .IsRequired()
                        .HasColumnType("varchar(20) CHARACTER SET utf8mb4")
                        .HasMaxLength(20);

                    b.Property<DateTime>("CreationTime")
                        .HasColumnType("datetime(6)");

                    b.Property<byte[]>("Gems")
                        .IsRequired()
                        .HasColumnType("varbinary(6)")
                        .HasMaxLength(6);

                    b.Property<bool>("IsDeleted")
                        .HasColumnType("tinyint(1)");

                    b.Property<string>("MakeType")
                        .IsRequired()
                        .HasColumnType("varchar(1) CHARACTER SET utf8mb4");

                    b.Property<ushort>("Quality")
                        .HasColumnType("smallint unsigned");

                    b.Property<byte>("Slot")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("Type")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("TypeId")
                        .HasColumnType("tinyint unsigned");

                    b.HasKey("Id");

                    b.HasIndex("CharacterId");

                    b.HasIndex("Type", "TypeId");

                    b.ToTable("CharacterItems");
                });

            modelBuilder.Entity("Imgeneus.Database.Entities.DbCharacterSkill", b =>
                {
                    b.Property<int>("CharacterId")
                        .HasColumnType("int");

                    b.Property<int>("SkillId")
                        .HasColumnType("int");

                    b.HasKey("CharacterId", "SkillId");

                    b.HasIndex("SkillId");

                    b.ToTable("CharacterSkill");
                });

            modelBuilder.Entity("Imgeneus.Database.Entities.DbItem", b =>
                {
                    b.Property<byte>("Type")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("TypeId")
                        .HasColumnName("TypeID")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("AttackTime")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("Attackfighter")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("Attackmage")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("Attrib")
                        .HasColumnType("tinyint unsigned");

                    b.Property<int>("Buy")
                        .HasColumnType("int");

                    b.Property<ushort>("ConstDex")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("ConstHP")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("ConstInt")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("ConstLuc")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("ConstMP")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("ConstRec")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("ConstSP")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("ConstStr")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("ConstWis")
                        .HasColumnType("smallint unsigned");

                    b.Property<byte>("Count")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("Country")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("Defensefighter")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("Defensemage")
                        .HasColumnType("tinyint unsigned");

                    b.Property<ushort>("Drop")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("Effect1")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("Effect2")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("Effect3")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("Effect4")
                        .HasColumnType("smallint unsigned");

                    b.Property<byte>("Exp")
                        .HasColumnType("tinyint unsigned");

                    b.Property<ushort>("Grade")
                        .HasColumnType("smallint unsigned");

                    b.Property<byte>("Grow")
                        .HasColumnType("tinyint unsigned");

                    b.Property<int>("Id")
                        .HasColumnName("ItemID")
                        .HasColumnType("int");

                    b.Property<string>("ItemName")
                        .IsRequired()
                        .HasColumnType("longtext CHARACTER SET utf8mb4");

                    b.Property<byte>("Patrolrogue")
                        .HasColumnType("tinyint unsigned");

                    b.Property<ushort>("Quality")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("Range")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("ReqDex")
                        .HasColumnType("smallint unsigned");

                    b.Property<byte>("ReqIg")
                        .HasColumnType("tinyint unsigned");

                    b.Property<ushort>("ReqInt")
                        .HasColumnType("smallint unsigned");

                    b.Property<byte>("ReqOg")
                        .HasColumnType("tinyint unsigned");

                    b.Property<ushort>("ReqRec")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("ReqStr")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("ReqVg")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("ReqWis")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("Reqlevel")
                        .HasColumnType("smallint unsigned");

                    b.Property<short>("Reqluc")
                        .HasColumnType("smallint");

                    b.Property<int>("Sell")
                        .HasColumnType("int");

                    b.Property<byte>("Server")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("Shootrogue")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("Slot")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("Special")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("Speed")
                        .HasColumnType("tinyint unsigned");

                    b.HasKey("Type", "TypeId");

                    b.ToTable("Items");
                });

            modelBuilder.Entity("Imgeneus.Database.Entities.DbSkill", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<byte>("AbilityType1")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("AbilityType10")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("AbilityType2")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("AbilityType3")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("AbilityType4")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("AbilityType5")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("AbilityType6")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("AbilityType7")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("AbilityType8")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("AbilityType9")
                        .HasColumnType("tinyint unsigned");

                    b.Property<ushort>("AbilityValue1")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("AbilityValue10")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("AbilityValue2")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("AbilityValue3")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("AbilityValue4")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("AbilityValue5")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("AbilityValue6")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("AbilityValue7")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("AbilityValue8")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("AbilityValue9")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("AddDamageHP")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("AddDamageMP")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("AddDamageSP")
                        .HasColumnType("smallint unsigned");

                    b.Property<byte>("ApplyRange")
                        .HasColumnType("tinyint unsigned");

                    b.Property<ushort>("Arrow")
                        .HasColumnType("smallint unsigned");

                    b.Property<byte>("AttackRange")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("AttrType")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("Bag")
                        .HasColumnType("tinyint unsigned");

                    b.Property<ushort>("ChangeLevel")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("ChangeType")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("DamageHP")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("DamageMP")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("DamageSP")
                        .HasColumnType("smallint unsigned");

                    b.Property<byte>("DamageType")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("DefenceType")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("DefenceValue")
                        .HasColumnType("tinyint unsigned");

                    b.Property<ushort>("DisabledSkill")
                        .HasColumnType("smallint unsigned");

                    b.Property<byte>("FixRange")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("Grow")
                        .HasColumnType("tinyint unsigned");

                    b.Property<ushort>("HealHP")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("HealMP")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("HealSP")
                        .HasColumnType("smallint unsigned");

                    b.Property<int>("KeepTime")
                        .HasColumnType("int");

                    b.Property<byte>("LimitHP")
                        .HasColumnType("tinyint unsigned");

                    b.Property<ushort>("MP")
                        .HasColumnType("smallint unsigned");

                    b.Property<byte>("MultiAttack")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("NeedShield")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("NeedWeapon1")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("NeedWeapon10")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("NeedWeapon11")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("NeedWeapon12")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("NeedWeapon13")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("NeedWeapon14")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("NeedWeapon15")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("NeedWeapon2")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("NeedWeapon3")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("NeedWeapon4")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("NeedWeapon5")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("NeedWeapon6")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("NeedWeapon7")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("NeedWeapon8")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("NeedWeapon9")
                        .HasColumnType("tinyint unsigned");

                    b.Property<ushort>("PreviousSkillId")
                        .HasColumnType("smallint unsigned");

                    b.Property<byte>("ReadyTime")
                        .HasColumnType("tinyint unsigned");

                    b.Property<ushort>("ReqLevel")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("ResetTime")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("SP")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("SkillId")
                        .HasColumnType("smallint unsigned");

                    b.Property<byte>("SkillLevel")
                        .HasColumnType("tinyint unsigned");

                    b.Property<string>("SkillName")
                        .HasColumnType("longtext CHARACTER SET utf8mb4");

                    b.Property<byte>("SkillPoint")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("SkillUtilizer")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("StateType")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("SuccessType")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("SuccessValue")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("TargetType")
                        .HasColumnType("tinyint unsigned");

                    b.Property<ushort>("TimeDamageHP")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("TimeDamageMP")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("TimeDamageSP")
                        .HasColumnType("smallint unsigned");

                    b.Property<byte>("TimeDamageType")
                        .HasColumnType("tinyint unsigned");

                    b.Property<ushort>("TimeHealHP")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("TimeHealMP")
                        .HasColumnType("smallint unsigned");

                    b.Property<ushort>("TimeHealSP")
                        .HasColumnType("smallint unsigned");

                    b.Property<byte>("TypeAttack")
                        .HasColumnType("tinyint unsigned");

                    b.Property<ushort>("TypeDetail")
                        .HasColumnType("smallint unsigned");

                    b.Property<byte>("TypeEffect")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("TypeShow")
                        .HasColumnType("tinyint unsigned");

                    b.Property<DateTime>("UpdateDate")
                        .HasColumnType("DATETIME");

                    b.Property<byte>("UsedByArcher")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("UsedByDefender")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("UsedByFighter")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("UsedByMage")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("UsedByPriest")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("UsedByRanger")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("Weapon1")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("Weapon2")
                        .HasColumnType("tinyint unsigned");

                    b.Property<byte>("Weaponvalue")
                        .HasColumnType("tinyint unsigned");

                    b.HasKey("Id");

                    b.HasIndex("SkillId", "SkillLevel");

                    b.ToTable("Skills");
                });

            modelBuilder.Entity("Imgeneus.Database.Entities.DbUser", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<byte>("Authority")
                        .HasColumnType("tinyint unsigned");

                    b.Property<DateTime>("CreateTime")
                        .HasColumnType("DATETIME");

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasColumnType("varchar(30) CHARACTER SET utf8mb4")
                        .HasMaxLength(30);

                    b.Property<byte>("Faction")
                        .HasColumnType("tinyint unsigned");

                    b.Property<bool>("IsDeleted")
                        .HasColumnType("tinyint(1)");

                    b.Property<DateTime>("LastConnectionTime")
                        .HasColumnType("DATETIME");

                    b.Property<byte>("MaxMode")
                        .HasColumnType("tinyint unsigned");

                    b.Property<string>("Password")
                        .IsRequired()
                        .HasColumnType("varchar(16) CHARACTER SET utf8mb4")
                        .HasMaxLength(16);

                    b.Property<int>("Points")
                        .HasColumnType("int");

                    b.Property<byte>("Status")
                        .HasColumnType("tinyint unsigned");

                    b.Property<string>("Username")
                        .IsRequired()
                        .HasColumnType("varchar(19) CHARACTER SET utf8mb4")
                        .HasMaxLength(19);

                    b.HasKey("Id");

                    b.HasIndex("Username", "Email")
                        .IsUnique();

                    b.ToTable("Users");
                });

            modelBuilder.Entity("Imgeneus.Database.Entities.DbCharacter", b =>
                {
                    b.HasOne("Imgeneus.Database.Entities.DbUser", "User")
                        .WithMany("Characters")
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Imgeneus.Database.Entities.DbCharacterItems", b =>
                {
                    b.HasOne("Imgeneus.Database.Entities.DbCharacter", "Character")
                        .WithMany("Items")
                        .HasForeignKey("CharacterId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Imgeneus.Database.Entities.DbItem", "Item")
                        .WithMany()
                        .HasForeignKey("Type", "TypeId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Imgeneus.Database.Entities.DbCharacterSkill", b =>
                {
                    b.HasOne("Imgeneus.Database.Entities.DbCharacter", "Character")
                        .WithMany("Skills")
                        .HasForeignKey("CharacterId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Imgeneus.Database.Entities.DbSkill", "Skill")
                        .WithMany()
                        .HasForeignKey("SkillId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });
#pragma warning restore 612, 618
        }
    }
}
