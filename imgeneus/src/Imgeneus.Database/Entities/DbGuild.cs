﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace Imgeneus.Database.Entities
{
    [Table("Guilds")]
    public class DbGuild : DbEntity
    {
        /// <summary>
        /// Guild name.
        /// </summary>
        public string Name { get; set; }

        /// <summary>
        /// Guild message.
        /// </summary>
        public string Message { get; set; }

        /// <summary>
        /// Character id, that is guild owner.
        /// </summary>
        public uint MasterId { get; set; }

        /// <summary>
        /// Guild owner.
        /// </summary>
        [ForeignKey(nameof(MasterId))]
        public DbCharacter Master { get; set; }

        /// <summary>
        /// Light or dark.
        /// </summary>
        public Fraction Country { get; set; }

        /// <summary>
        /// Guild points.
        /// </summary>
        public int Points { get; set; }

        /// <summary>
        /// Guild rank.
        /// </summary>
        public byte Rank { get; set; }

        /// <summary>
        /// Guild's creation date.
        /// </summary>
        public DateTime CreateDate { get; set; }

        /// <summary>
        /// Guild's deletion date.
        /// </summary>
        public DateTime DeleteDate { get; set; }

        /// <summary>
        /// Guild members.
        /// </summary>
        public ICollection<DbCharacter> Members { get; set; }

        /// <summary>
        /// Shows if the guild has a guild house.
        /// </summary>
        public bool HasHouse { get; set; }

        /// <summary>
        /// Guild etin. Etin is currency, that is used in guild house.
        /// </summary>
        public int Etin { get; set; }

        /// <summary>
        /// Etin, that is needed for guild house to function.
        /// </summary>
        public int KeepEtin { get; set; }

        /// <summary>
        /// Guild npc level settings.
        /// </summary>
        public ICollection<DbGuildNpcLvl> NpcLvls { get; set; }

        /// <summary>
        /// Guild's stored items.
        /// </summary>
        public ICollection<DbGuildWarehouseItem> WarehouseItems { get; set; }

        public DbGuild(string name, string message, uint masterId, Fraction country)
        {
            Name = name;
            Message = message;
            MasterId = masterId;
            Country = country;
            Rank = 31; // Default rank.
            CreateDate = DateTime.UtcNow;
            Members = new HashSet<DbCharacter>();
        }
    }
}
