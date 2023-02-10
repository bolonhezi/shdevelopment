﻿using BinarySerialization;
using Imgeneus.World.Game.Inventory;
using Imgeneus.World.Serialization;

namespace Imgeneus.Network.Serialization
{
    public class InventoryItem : BaseSerializable
    {
        [FieldOrder(0)]
        public byte Bag { get; }

        [FieldOrder(1)]
        public byte Slot { get; }

        [FieldOrder(2)]
        public byte Type { get; }

        [FieldOrder(3)]
        public byte TypeId { get; }

        [FieldOrder(4)]
        public ushort Quality { get; }

        [FieldOrder(5)]
        public int[] Gems { get; }

        [FieldOrder(6)]
        public byte Count { get; }

        [FieldOrder(7)]
        public CraftName CraftName { get; }

        [FieldOrder(8)]
        public byte[] UnknownBytes { get; } = new byte[23];

        [FieldOrder(9)]
        public bool IsItemDyed { get; }

        [FieldOrder(10)]
        public byte[] UnknownBytes2 { get; } = new byte[26];

        public InventoryItem(Item item)
        {
            Bag = item.Bag;
            Slot = item.Slot;
            Type = item.Type;
            TypeId = item.TypeId;
            Quality = item.Quality;
            Gems = new int[] {
                item.Gem1 is null ? 0 : item.Gem1.TypeId,
                item.Gem2 is null ? 0 : item.Gem2.TypeId,
                item.Gem3 is null ? 0 : item.Gem3.TypeId,
                item.Gem4 is null ? 0 : item.Gem4.TypeId,
                item.Gem5 is null ? 0 : item.Gem5.TypeId,
                item.Gem6 is null ? 0 : item.Gem6.TypeId,
            };
            Count = item.Count;

            CraftName = new CraftName(item.GetCraftName());

            // Unknown bytes. Not sure what is it, but if all set to 1 AND CraftName IsDisabled to "true" from and until date is shown.
            for (var i = 0; i < UnknownBytes.Length; i++)
            {
                UnknownBytes[i] = 1;
            }

            IsItemDyed = item.DyeColor.IsEnabled;

            // Unknown bytes. Not sure what is it, but if all set to 1 from and until date is shown.
            for (var i = 0; i < UnknownBytes2.Length; i++)
            {
                UnknownBytes2[i] = 1;
            }

        }
    }
}
