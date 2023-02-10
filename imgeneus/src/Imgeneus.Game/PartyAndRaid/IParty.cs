﻿using Imgeneus.World.Game.Inventory;
using Imgeneus.World.Game.Player;
using System;
using System.Collections.Generic;

namespace Imgeneus.World.Game.PartyAndRaid
{
    /// <summary>
    /// Common interface for party and raid. 
    /// </summary>
    public interface IParty
    {
        /// <summary>
        /// Party id.
        /// </summary>
        public Guid Id { get; }

        /// <summary>
        /// All party members.
        /// </summary>
        public IList<Character> Members { get; }

        /// <summary>
        /// Short list is in raid, when party is made of 5 members.
        /// </summary>
        public IList<Character> GetShortMembersList(Character member);

        /// <summary>
        /// Event, that is fired, as soon as member enters party.
        /// </summary>
        public event Action<IParty> OnMemberEnter;

        /// <summary>
        /// Event, that is fired, as soon as member left party.
        /// </summary>
        public event Action<IParty> OnMemberLeft;

        /// <summary>
        /// Event, that is fired, as soon as party is empty.
        /// </summary>
        public event Action AllMembersLeft;

        /// <summary>
        /// Enter party.
        /// </summary>
        /// <param name="player">Player, that wants to enter party</param>
        /// <returns>true if it's enough place for new member</returns>
        public bool EnterParty(Character player);

        /// <summary>
        /// Leave party.
        /// </summary>
        /// <param name="player">Player, that wants to leave party</param>
        public void LeaveParty(Character player);

        /// <summary>
        /// Forces player remove from the party.
        /// </summary>
        /// <param name="player">Player, that should be removed</param>
        public void KickMember(Character player);

        /// <summary>
        /// Dismantles party. (available only for raid)
        /// </summary>
        public void Dismantle();

        /// <summary>
        /// Party leader.
        /// </summary>
        public Character Leader { get; set; }

        /// <summary>
        /// Party second leader.
        /// </summary>
        public Character SubLeader { get; set; }

        /// <summary>
        /// Event, that is fired, when party leader is changed.
        /// </summary>
        public event Action<Character, Character> OnLeaderChanged;

        /// <summary>
        /// Distributes items between party members.
        /// </summary>
        /// <param name="items">drop items</param>
        /// <param name="dropCreator">player, that killed mob and made this drop</param>
        /// <returns>list of items, that could not be distributed</returns>
        public IList<Item> DistributeDrop(IList<Item> items, Character dropCreator);

        /// <summary>
        /// Notifies other members, that this player got item.
        /// </summary>
        /// <param name="player">player, that got item</param>
        /// <param name="item">new item, that player got</param>
        public void MemberGetItem(Character player, Item item);

        /// <summary>
        /// Request, that is sent to all party members, when 1 member summons them.
        /// </summary>
        public SummonRequest SummonRequest { get; set; }
    }
}
