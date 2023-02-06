﻿using BinarySerialization;
using Imgeneus.Network.Serialization;
using Imgeneus.World.Game.Buffs;

namespace Imgeneus.World.Serialization
{
    public class PartyMemberBuff : BaseSerializable
    {
        [FieldOrder(0)]
        public ushort SkillId;

        [FieldOrder(1)]
        public byte SkillLevel;

        [FieldOrder(2)]
        public int CountDownInSeconds;

        public PartyMemberBuff(Buff buff)
        {
            SkillId = buff.Skill.SkillId;
            SkillLevel = buff.Skill.SkillLevel;
            CountDownInSeconds = buff.CountDownInSeconds;
        }
    }
}
