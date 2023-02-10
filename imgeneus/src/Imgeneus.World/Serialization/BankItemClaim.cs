using BinarySerialization;
using Imgeneus.Network.Serialization;
using Imgeneus.World.Game.Inventory;

namespace Imgeneus.World.Serialization
{
    public class BankItemClaim : BaseSerializable
    {
        [FieldOrder(0)]
        public byte BankSlot { get; }

        [FieldOrder(1)]
        public byte Bag { get; }

        [FieldOrder(2)]
        public byte Slot { get; }

        [FieldOrder(3)]
        public byte Count { get; }

        public BankItemClaim(byte bankSlot, Item item)
        {
            BankSlot = bankSlot;
            Bag = item.Bag;
            Slot = item.Slot;
            Count = item.Count;
        }
    }
}
