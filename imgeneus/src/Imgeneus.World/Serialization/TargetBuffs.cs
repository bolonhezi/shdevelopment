﻿using BinarySerialization;
using Imgeneus.Network.Serialization;
using Imgeneus.World.Game;
using Imgeneus.World.Game.Buffs;
using Imgeneus.World.Game.Monster;
using System.Collections.Generic;
using System.Linq;

namespace Imgeneus.World.Serialization
{
    public class TargetBuffs : BaseSerializable
    {
        [FieldOrder(0)]
        public byte TargetType;

        [FieldOrder(1)]
        public uint TargetId;

        [FieldOrder(2)]
        public byte BuffsCount;

        [FieldOrder(3)]
        [FieldCount(nameof(BuffsCount))]
        public List<TargetBuff> Buffs { get; } = new List<TargetBuff>();

        public TargetBuffs(IKillable target)
        {
            TargetId = target.Id;

            if (target is Mob)
                TargetType = 2;
            else
                TargetType = 1;

            foreach (var buff in target.BuffsManager.ActiveBuffs.ToList())
            {
                Buffs.Add(new TargetBuff(buff));
            }
        }
    }

    public class TargetBuff : BaseSerializable
    {
        [FieldOrder(0)]
        public ushort SkillId;

        [FieldOrder(1)]
        public byte SkillLevel;

        [FieldOrder(2)]
        public int CountDownInSeconds;

        public TargetBuff(Buff buff)
        {
            SkillId = buff.Skill.SkillId;
            SkillLevel = buff.Skill.SkillLevel;
            CountDownInSeconds = buff.CountDownInSeconds;
        }
    }
}
