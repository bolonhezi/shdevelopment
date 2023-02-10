﻿using Imgeneus.World.Game.Buffs;
using Imgeneus.World.Game.Health;
using Imgeneus.World.Game.Inventory;
using Imgeneus.World.Game.Player;
using Imgeneus.World.Packets;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;

namespace Imgeneus.World.Game.PartyAndRaid
{
    /// <summary>
    /// Common class for party and raid.
    /// </summary>
    public abstract class BaseParty : IParty
    {
        protected readonly IGamePacketFactory _packetFactory;

        public Guid Id { get; private set; }

        public BaseParty(IGamePacketFactory packetFactory)
        {
            Id = Guid.NewGuid();
            _packetFactory = packetFactory;
        }

        #region Leader

        protected Character _leader;

        /// <summary>
        /// Event, that is fired, when party leader is changed.
        /// </summary>
        public event Action<Character, Character> OnLeaderChanged;

        /// <summary>
        /// Raid leader.
        /// </summary>
        public Character Leader
        {
            get => _leader;
            set
            {
                var oldLeader = _leader;
                _leader = value;
                if (SubLeader == _leader && Members.Count > 1) // Only for raids.
                {
                    SubLeader = oldLeader;
                }
                OnLeaderChanged?.Invoke(oldLeader, _leader);
                foreach (var member in Members)
                    SendNewLeader(member.GameSession.Client, Leader);
            }
        }

        protected Character _subLeader;

        /// <summary>
        /// Second raid leader.
        /// </summary>
        public Character SubLeader
        {
            get
            {
                if (Members.Count == 1) // When raid is created, it has only 1 member.
                    return Leader;
                return _subLeader;
            }
            set
            {
                _subLeader = value;
                foreach (var member in Members)
                    SendNewSubLeader(member.GameSession.Client, SubLeader);
            }
        }

        #endregion

        #region Members

        /// <summary>
        /// Party members.
        /// </summary>
        protected abstract IList<Character> _members { get; set; }

        /// <inheritdoc/>
        public event Action<IParty> OnMemberEnter;

        /// <summary>
        /// Invoke <see cref="OnMemberEnter"/> event.
        /// </summary>
        protected void CallMemberEnter()
        {
            OnMemberEnter?.Invoke(this);
        }

        /// <inheritdoc/>
        public event Action<IParty> OnMemberLeft;

        /// <summary>
        /// Invoke <see cref="OnMemberLeft"/> event.
        /// </summary>
        protected void CallMemberLeft()
        {
            OnMemberLeft?.Invoke(this);
        }

        /// <inheritdoc/>
        public event Action AllMembersLeft;

        /// <summary>
        /// Invoke <see cref="AllMembersLeft"/> event.
        /// </summary>
        protected void CallAllMembersLeft()
        {
            AllMembersLeft?.Invoke();
        }

        public IList<Character> Members
        {
            get
            {
                return new ReadOnlyCollection<Character>(_members);
            }
        }

        public abstract IList<Character> GetShortMembersList(Character member);

        /// <summary>
        /// Subscribes to hp, mp, sp changes.
        /// </summary>
        protected void SubcribeToCharacterChanges(Character character)
        {
            character.BuffsManager.OnBuffAdded += Member_OnAddedBuff;
            character.BuffsManager.OnBuffRemoved += Member_OnRemovedBuff;
            character.HealthManager.HP_Changed += Member_HP_Changed;
            character.HealthManager.MP_Changed += Member_MP_Changed;
            character.HealthManager.SP_Changed += Member_SP_Changed;
            character.HealthManager.OnMaxHPChanged += Member_MaxHP_Changed;
            character.HealthManager.OnMaxMPChanged += Member_MaxMP_Changed;
            character.HealthManager.OnMaxSPChanged += Member_MaxSP_Changed;
            character.LevelProvider.OnLevelUp += Member_OnLevelChange;
        }

        /// <summary>
        /// Unsubscribes from hp, mp, sp changes.
        /// </summary>
        protected void UnsubcribeFromCharacterChanges(Character character)
        {
            character.BuffsManager.OnBuffAdded -= Member_OnAddedBuff;
            character.BuffsManager.OnBuffRemoved -= Member_OnRemovedBuff;
            character.HealthManager.HP_Changed -= Member_HP_Changed;
            character.HealthManager.MP_Changed -= Member_MP_Changed;
            character.HealthManager.SP_Changed -= Member_SP_Changed;
            character.HealthManager.OnMaxHPChanged -= Member_MaxHP_Changed;
            character.HealthManager.OnMaxMPChanged -= Member_MaxMP_Changed;
            character.HealthManager.OnMaxSPChanged -= Member_MaxSP_Changed;
            character.LevelProvider.OnLevelUp -= Member_OnLevelChange;
        }

        #endregion

        #region Member hitpoints changes

        /// <summary>
        /// Notifies party member, that member got new buff.
        /// </summary>
        /// <param name="senderId">buff sender</param>
        /// <param name="buff">buff, that he got</param>
        private void Member_OnAddedBuff(uint senderId, Buff buff)
        {
            foreach (var member in Members)
                SendAddBuff(member.GameSession.Client, senderId, buff.Skill.SkillId, buff.Skill.SkillLevel);
        }

        /// <summary>
        /// Notifies party member, that member lost buff.
        /// </summary>
        /// <param name="senderId">buff sender</param>
        /// <param name="buff">buff, that he lost</param>
        private void Member_OnRemovedBuff(uint senderId, Buff buff)
        {
            foreach (var member in Members)
                SendRemoveBuff(member.GameSession.Client, senderId, buff.Skill.SkillId, buff.Skill.SkillLevel);
        }

        /// <summary>
        /// Notifies party member, that member has new hp value.
        /// </summary>
        private void Member_HP_Changed(uint senderId, HitpointArgs args)
        {
            foreach (var member in Members)
                Send_Single_HP_SP_MP(member.GameSession.Client, senderId, args.NewValue, 0);
        }

        /// <summary>
        /// Notifies party member, that member has new sp value.
        /// </summary>
        private void Member_SP_Changed(uint senderId, HitpointArgs args)
        {
            foreach (var member in Members)
                Send_Single_HP_SP_MP(member.GameSession.Client, senderId, args.NewValue, 1);
        }

        /// <summary>
        /// Notifies party member, that member has new mp value.
        /// </summary>
        private void Member_MP_Changed(uint senderId, HitpointArgs args)
        {
            foreach (var member in Members)
                Send_Single_HP_SP_MP(member.GameSession.Client, senderId, args.NewValue, 2);
        }

        /// <summary>
        /// Notifies party member, that member has new hp, sp and mp values.
        /// </summary>
        private void Member_HP_SP_MP_Changed(Character sender)
        {
            foreach (var member in Members)
                Send_HP_SP_MP(member.GameSession.Client, sender);
        }

        /// <summary>
        /// Notifies party member, that member has new max hp value.
        /// </summary>
        private void Member_MaxHP_Changed(uint senderId, int newMaxHP)
        {
            foreach (var member in Members)
                Send_Single_Max_HP_SP_MP(member.GameSession.Client, senderId, newMaxHP, 0);
        }

        /// <summary>
        /// Notifies party member, that member has new max sp value.
        /// </summary>
        private void Member_MaxSP_Changed(uint senderId, int newMaxSP)
        {
            foreach (var member in Members)
                Send_Single_Max_HP_SP_MP(member.GameSession.Client, senderId, newMaxSP, 1);
        }

        /// <summary>
        /// Notifies party member, that member has new max mp value.
        /// </summary>
        private void Member_MaxMP_Changed(uint senderId, int newMaxMP)
        {
            foreach (var member in Members)
                Send_Single_Max_HP_SP_MP(member.GameSession.Client, senderId, newMaxMP, 2);
        }

        /// <summary>
        /// Notifies party member, that member has new max hp, max sp and max mp values.
        /// </summary>
        private void Member_Max_HP_SP_MP_Changed(Character sender)
        {
            foreach (var member in Members.Where(m => m != sender))
                Send_Max_HP_SP_MP(member.GameSession.Client, sender);
        }

        #endregion

        #region Distribute money

        /// <summary>
        /// Equally distributes money among all party members.
        /// </summary>
        /// <param name="item">money, unique item with type 26</param>
        protected void DistributeMoney(Item item)
        {
            item.Gold /= Members.Count;

            foreach (var member in Members)
            {
                member.InventoryManager.Gold = (uint)(member.InventoryManager.Gold + item.Gold);
                member.SendAddItemToInventory(item);
            }
        }

        #endregion

        #region Level changes

        /// <summary>
        /// Notifies party member that a member's level changed
        /// </summary>
        /// <param name="sender">Character whose level changed</param>
        private void Member_OnLevelChange(uint senderId, ushort level, ushort oldLevel)
        {
            foreach (var member in Members.Where(m => m.Id != senderId))
                SendLevel(member.GameSession.Client, senderId, level);
        }

        #endregion

        #region Summon

        public SummonRequest SummonRequest { get; set; }

        #endregion

        #region Absctracts

        public abstract bool EnterParty(Character player);

        public abstract void KickMember(Character player);

        public abstract void LeaveParty(Character player);

        protected abstract void SendAddBuff(IWorldClient client, uint senderId, ushort skillId, byte skillLevel);

        protected abstract void SendRemoveBuff(IWorldClient client, uint senderId, ushort skillId, byte skillLevel);

        protected abstract void Send_Single_HP_SP_MP(IWorldClient client, uint senderId, int value, byte type);

        protected abstract void Send_Single_Max_HP_SP_MP(IWorldClient client, uint senderId, int value, byte type);

        protected abstract void Send_HP_SP_MP(IWorldClient client, Character sender);

        protected abstract void Send_Max_HP_SP_MP(IWorldClient client, Character sender);

        protected abstract void SendNewLeader(IWorldClient client, Character leader);

        protected abstract void SendNewSubLeader(IWorldClient client, Character leader);

        public abstract void Dismantle();

        public abstract IList<Item> DistributeDrop(IList<Item> items, Character dropCreator);

        public abstract void MemberGetItem(Character player, Item item);

        protected abstract void SendLevel(IWorldClient client, uint senderId, ushort level);

        #endregion
    }
}
