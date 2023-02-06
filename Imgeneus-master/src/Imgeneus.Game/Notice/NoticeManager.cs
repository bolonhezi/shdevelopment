﻿using System.Linq;
using System.Text;
using Imgeneus.Network.PacketProcessor;
using Imgeneus.Network.Packets;
using Imgeneus.World.Game.Country;
using Imgeneus.World.Game.Player;
using Microsoft.Extensions.Logging;

namespace Imgeneus.World.Game.Notice
{
    public class NoticeManager : INoticeManager
    {
        private readonly ILogger<INoticeManager> _logger;
        private readonly IGameWorld _gameWorld;

        public NoticeManager(ILogger<INoticeManager> logger, IGameWorld gameWorld)
        {
            _logger = logger;
            _gameWorld = gameWorld;
        }

        /// <inheritdoc/>
        // TODO: Implement notice timer with time interval
        public void SendWorldNotice(string message, short timeInterval = 0)
        {
            var worldPlayers = _gameWorld.Players.Values;

            foreach (var player in worldPlayers)
            {
#if SHAIYA_US || SHAIYA_US_DEBUG || DEBUG
                SendNoticeToPlayer(player, PacketType.GM_SHAIYA_US_NOTICE_WORLD, message);
#else
                SendNoticeToPlayer(player, PacketType.NOTICE_WORLD, message);
#endif
            }
        }

        /// <inheritdoc/>
        // TODO: Implement notice timer with time interval
        public void SendFactionNotice(string message, CountryType faction, short timeInterval = 0)
        {
            var factionPlayers = _gameWorld.Players.Values.Where(p => p.CountryProvider.Country == faction);

            foreach (var player in factionPlayers)
            {
                SendNoticeToPlayer(player, PacketType.NOTICE_FACTION, message);
            }
        }

        /// <inheritdoc/>
        // TODO: Implement notice timer with time interval
        public void SendMapNotice(string message, ushort mapId, short timeInterval = 0)
        {
            var mapPlayers = _gameWorld.Players.Values.Where(p => p.Map.Id == mapId);

            foreach (var player in mapPlayers)
            {
                SendNoticeToPlayer(player, PacketType.NOTICE_MAP, message);
            }
        }

        /// <inheritdoc/>
        // TODO: Implement notice timer with time interval
        public bool TrySendPlayerNotice(string message, string targetPlayer, short timeInterval = 0)
        {
            var target = _gameWorld.Players.Values.FirstOrDefault(p => p.AdditionalInfoManager.Name == targetPlayer);

            if (target == null)
                return false;

            SendNoticeToPlayer(target, PacketType.NOTICE_PLAYER, message);
            return true;
        }

        /// <inheritdoc/>
        public void SendAdminNotice(string message)
        {
            var admins = _gameWorld.Players.Values.Where(p => p.GameSession.IsAdmin);

            foreach (var player in admins)
            {
                SendNoticeToPlayer(player, PacketType.NOTICE_ADMINS, message);
            }
        }

        /// <inheritdoc/>
        // TODO: Find out the correct parameters for /bnotice command and implement it here.
        public void SendAreaNotice(string message, ushort posX, ushort posZ)
        {
            _logger.LogError("Area notice is not implemented yet. Notice failed.");
        }

#region Senders

        /// <summary>
        /// Sends a notice to a player
        /// </summary>
        /// <param name="character">Receiver character</param>
        /// <param name="noticeType">Notice type</param>
        /// <param name="message">Notice's message text</param>
        private void SendNoticeToPlayer(Character character, PacketType noticeType, string message)
        {
            using var packet = new ImgeneusPacket(noticeType);

            packet.WriteByte((byte)message.Length);

#if EP8_V2 || SHAIYA_US || SHAIYA_US_DEBUG || DEBUG
            packet.WriteString(message, message.Length, Encoding.Unicode);
#else
            packet.WriteString(message);
#endif

            character.GameSession.Client.Send(packet);
        }

#endregion
    }
}