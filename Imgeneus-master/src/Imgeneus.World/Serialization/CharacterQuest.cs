﻿using BinarySerialization;
using Imgeneus.Network.Serialization;
using Imgeneus.World.Game.Quests;

namespace Imgeneus.World.Serialization
{
    public class CharacterQuest : BaseSerializable
    {
        [FieldOrder(0)]
        public short QuestId;

        [FieldOrder(1)]
        public ushort RemainingTime;

        [FieldOrder(2)]
        public byte Count1;

        [FieldOrder(3)]
        public byte Count2;

        [FieldOrder(4)]
        public byte Count3;

        public CharacterQuest(Quest quest)
        {
            QuestId = quest.Id;
            RemainingTime = quest.RemainingTime;
            Count1 = quest.CountMob1;
            Count2 = quest.CountMob2;
            Count3 = quest.Count3;
        }
    }
}