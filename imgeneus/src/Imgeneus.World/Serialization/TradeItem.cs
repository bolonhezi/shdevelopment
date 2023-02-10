﻿using BinarySerialization;
using Imgeneus.Network.Serialization;
using Imgeneus.World.Game.Inventory;
using System;

namespace Imgeneus.World.Serialization
{
    public class TradeItem : BaseSerializable
    {
        [FieldOrder(0)]
        public byte SlotInTradeWindow { get; }

        [FieldOrder(1)]
        public byte Type { get; }

        [FieldOrder(2)]
        public byte TypeId { get; }

        [FieldOrder(3)]
        public byte Count { get; }

        [FieldOrder(4)]
        public ushort Quality { get; }

        [FieldOrder(5)]
        public byte[] FromDate = new byte[4]; // ?

        [FieldOrder(6)]
        public byte[] UntilDate = new byte[4]; // ?

        [FieldOrder(7)]
        public byte[] UnknownBytes1 { get; }

        [FieldOrder(8)]
        public bool IsItemDyed { get; }

        [FieldOrder(9)]
        public byte[] UnknownBytes2 { get; }

        [FieldOrder(10)]
        public int[] Gems { get; }

        [FieldOrder(11)]
        public CraftName CraftName { get; }

        public TradeItem(byte slotInTradeWindow, byte count, Item item)
        {
            SlotInTradeWindow = slotInTradeWindow;
            Type = item.Type;
            TypeId = item.TypeId;
            Count = count;
            Quality = item.Quality;
            Gems = new int[] {
                item.Gem1 is null ? 0 : item.Gem1.TypeId,
                item.Gem2 is null ? 0 : item.Gem2.TypeId,
                item.Gem3 is null ? 0 : item.Gem3.TypeId,
                item.Gem4 is null ? 0 : item.Gem4.TypeId,
                item.Gem5 is null ? 0 : item.Gem5.TypeId,
                item.Gem6 is null ? 0 : item.Gem6.TypeId,
            };

            CraftName = new CraftName(item.GetCraftName());

            IsItemDyed = true;
            UnknownBytes1 = new byte[22];
            UnknownBytes2 = new byte[26];
        }
    }
}
