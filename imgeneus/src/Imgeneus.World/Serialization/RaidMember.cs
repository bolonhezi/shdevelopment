﻿using BinarySerialization;
using Imgeneus.Database.Entities;
using Imgeneus.Network.Serialization;
using Imgeneus.World.Game.Player;
using System.Collections.Generic;
using System.Linq;

namespace Imgeneus.World.Serialization
{
    public class RaidMember : BaseSerializable
    {
        [FieldOrder(0)]
        public ushort IndexPositionInRaid;

        [FieldOrder(1)]
        public uint CharacterId;

        [FieldOrder(2), FieldLength(21)]
        public string Name;

        [FieldOrder(3)]
        public ushort Level;

        [FieldOrder(4)]
        public CharacterProfession Class;

        [FieldOrder(5)]
        public int MaxHP;

        [FieldOrder(6)]
        public int HP;

        [FieldOrder(7)]
        public int MaxSP;

        [FieldOrder(8)]
        public int SP;

        [FieldOrder(9)]
        public int MaxMP;

        [FieldOrder(10)]
        public int MP;

        [FieldOrder(11)]
        public ushort Map;

        [FieldOrder(12)]
        public float X;

        [FieldOrder(13)]
        public float Y;

        [FieldOrder(14)]
        public float Z;

        [FieldOrder(15)]
        public byte BuffsCount;

        [FieldOrder(16)]
        [FieldCount(nameof(BuffsCount))]
        public List<PartyMemberBuff> Buffs { get; } = new List<PartyMemberBuff>();

        public RaidMember(Character character, ushort position)
        {
            IndexPositionInRaid = position;
            CharacterId = character.Id;
            Level = character.LevelProvider.Level;
            Class = character.AdditionalInfoManager.Class;
            MaxHP = character.HealthManager.MaxHP;
            HP = character.HealthManager.CurrentHP;
            MaxSP = character.HealthManager.MaxSP;
            SP = character.HealthManager.CurrentSP;
            MaxMP = character.HealthManager.MaxMP;
            MP = character.HealthManager.CurrentMP;
            Map = character.MapProvider.Map.Id;
            X = character.PosX;
            Y = character.PosY;
            Z = character.PosZ;
            Name = character.AdditionalInfoManager.Name;

            foreach (var buff in character.BuffsManager.ActiveBuffs.ToList())
            {
                Buffs.Add(new PartyMemberBuff(buff));
            }
        }
    }
}