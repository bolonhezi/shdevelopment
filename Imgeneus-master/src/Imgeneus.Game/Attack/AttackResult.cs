﻿namespace Imgeneus.World.Game.Attack
{
    /// <summary>
    /// Result of any attack/skill use.
    /// </summary>
    public struct AttackResult
    {
        /// <summary>
        /// Can be normal, critical or miss.
        /// </summary>
        public AttackSuccess Success;

        /// <summary>
        /// Damage done if any.
        /// </summary>
        public Damage Damage;

        /// <summary>
        /// How much damage was absorbed.
        /// </summary>
        public ushort Absorb;

        public AttackResult(AttackSuccess success, Damage damage, ushort absorb = 0)
        {
            Success = success;
            Damage = damage;
            Absorb = absorb;
        }
    }

    public enum AttackSuccess : byte
    {
        Normal = 0,
        Critical = 1,
        Miss = 2,
        Failed = 3,
        SuccessBuff = 4,
        InsufficientRange = 5,
        NotEnoughMPSP = 6,
        WrongEquipment = 7,
        PreviousSkillRequired = 8,
        CooldownNotOver = 9,
        CanNotAttack = 10,
        WrongTarget = 11,
        TooFastAttack = 12
    }
}
