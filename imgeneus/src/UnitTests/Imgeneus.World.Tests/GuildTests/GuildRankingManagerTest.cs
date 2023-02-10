﻿using Imgeneus.Database;
using Imgeneus.Database.Entities;
using Imgeneus.World.Game.Guild;
using Imgeneus.World.Game.Time;
using Imgeneus.World.Game.Zone.MapConfig;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Moq;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Threading.Tasks;
using Xunit;

namespace Imgeneus.World.Tests.GuildTests
{
    public class GuildRankingManagerTest : BaseTest
    {
        [Theory]
        [Description("Start soon timer interval should be calculated. It's 15 min before GRB starts.")]
        [InlineData("0 17 * * Sunday", "0 18 * * Sunday", 2021, 4, 4, 16, 00, 2700000)] // GRB starts 17:00. Now is 16:00. Interval should be 45 min i.e. 45 * 60 * 1000 = 2700000
        [InlineData("0 17 * * Sunday", "0 18 * * Sunday", 2021, 4, 4, 16, 30, 900000)] // GRB starts 17:00. Now is 16:30. Interval should be 15 min i.e. 15 * 60 * 1000 = 900000
        [InlineData("0 17 * * Sunday", "0 18 * * Sunday", 2021, 4, 4, 16, 58, 604020000)] // GRB starts 17:00. Now is 16:58. Interval should be at the next week (16:45) 7d * 24h * 60m * 60s * 1000ms = 604,800,000 - 13min (780,000) = 604,020,000
        public void GetStartSoonInterval_Test(string openTime, string closeTime, int year, int month, int day, int hour, int minute, double expected)
        {
            var now = new DateTime(year, month, day, hour, minute, 0);

            var timeService = new Mock<ITimeService>();
            timeService.Setup(x => x.UtcNow)
                       .Returns(now);

            var mapsLoader = new Mock<IMapsLoader>();
            mapsLoader.Setup(x => x.LoadMapDefinitions())
                      .Returns(new MapDefinitions()
                      {
                          Maps = new List<MapDefinition>()
                            {
                                new MapDefinition()
                                {
                                    Id = 50,
                                    CreateType = CreateType.GRB,
                                    OpenTime = openTime,
                                    CloseTime = closeTime
                                }
                            }
                      });

            var rankingManager = new GuildRankingManager(new Mock<ILogger<IGuildRankingManager>>().Object, mapsLoader.Object, timeService.Object, databaseMock.Object, new GuildHouseConfiguration());

            var interval = rankingManager.GetStartSoonInterval();

            Assert.Equal(expected, interval);
        }

        [Theory]
        [Description("Start timer interval should be calculated. It's when GRB starts.")]
        [InlineData("0 17 * * Sunday", "0 18 * * Sunday", 2021, 4, 4, 16, 00, 3600000)] // GRB starts 17:00. Now is 16:00. Interval should be 1 hour: 1h * 60m * 60s * 1000ms = 3,600,000
        [InlineData("0 17 * * Sunday", "0 18 * * Sunday", 2021, 4, 4, 16, 30, 1800000)] // GRB starts 17:00. Now is 16:30. Interval should be 30 min: 30m * 60s * 1000ms = 1,800,000
        [InlineData("0 17 * * Sunday", "0 18 * * Sunday", 2021, 4, 4, 17, 00, 604800000)] // GRB starts 17:00. Now is 17:00. Interval should be next week: 7d * 24h * 60m * 60s * 1000ms = 604800000 
        [InlineData("0 17 * * Sunday", "0 18 * * Sunday", 2021, 4, 4, 17, 20, 603600000)] // GRB starts 17:00. Now is 17:20. Interval should be next week - 20 min: 7d * 24h * 60m * 60s * 1000ms (604,800,000) - 20m * 60s * 1000ms (1,200,000) = 603,600,000 
        public void GetStartInterval_Test(string openTime, string closeTime, int year, int month, int day, int hour, int minute, double expected)
        {
            var now = new DateTime(year, month, day, hour, minute, 0);

            var timeService = new Mock<ITimeService>();
            timeService.Setup(x => x.UtcNow)
                       .Returns(now);

            var mapsLoader = new Mock<IMapsLoader>();
            mapsLoader.Setup(x => x.LoadMapDefinitions())
                      .Returns(new MapDefinitions()
                      {
                          Maps = new List<MapDefinition>()
                            {
                                new MapDefinition()
                                {
                                    Id = 50,
                                    CreateType = CreateType.GRB,
                                    OpenTime = openTime,
                                    CloseTime = closeTime
                                }
                            }
                      });

            var rankingManager = new GuildRankingManager(new Mock<ILogger<IGuildRankingManager>>().Object, mapsLoader.Object, timeService.Object, databaseMock.Object, new GuildHouseConfiguration());

            var interval = rankingManager.GetStartInterval();

            Assert.Equal(expected, interval);
        }

        [Theory]
        [Description("10 mins left timer interval should be calculated.")]
        [InlineData("0 17 * * Sunday", "0 18 * * Sunday", 2021, 4, 4, 16, 00, 6600000)] // GRB ends 18:00. Now is 16:00. Interval should be 01:50: 1h * 60m * 60s * 1000ms + 50m * 60s * 1000ms = 6,600,000
        [InlineData("0 17 * * Sunday", "0 18 * * Sunday", 2021, 4, 4, 17, 40, 600000)]  // GRB ends 18:00. Now is 17:40. Interval should be 00:10: 10min * 60s * 1000ms = 600,000
        [InlineData("0 17 * * Sunday", "0 18 * * Sunday", 2021, 4, 4, 17, 50, 604800000)]  // GRB ends 18:00. Now is 17:50. Interval should be next week: 7d * 24h * 60m * 60s * 1000ms = 604800000 
        [InlineData("0 17 * * Sunday", "0 18 * * Sunday", 2021, 4, 4, 18, 00, 604200000)]  // GRB ends 18:00. Now is 18:00. Interval should be next week - 10min: 7d * 24h * 60m * 60s * 1000ms(604800000) - 10m * 60s * 1000ms(600000) = 604,200,000 
        public void Get10MinsLeftInterval_Test(string openTime, string closeTime, int year, int month, int day, int hour, int minute, double expected)
        {
            var now = new DateTime(year, month, day, hour, minute, 0);

            var timeService = new Mock<ITimeService>();
            timeService.Setup(x => x.UtcNow)
                       .Returns(now);

            var mapsLoader = new Mock<IMapsLoader>();
            mapsLoader.Setup(x => x.LoadMapDefinitions())
                      .Returns(new MapDefinitions()
                      {
                          Maps = new List<MapDefinition>()
                            {
                                new MapDefinition()
                                {
                                    Id = 50,
                                    CreateType = CreateType.GRB,
                                    OpenTime = openTime,
                                    CloseTime = closeTime
                                }
                            }
                      });

            var rankingManager = new GuildRankingManager(new Mock<ILogger<IGuildRankingManager>>().Object, mapsLoader.Object, timeService.Object, databaseMock.Object, new GuildHouseConfiguration());

            var interval = rankingManager.Get10MinsLeftInterval();

            Assert.Equal(expected, interval);
        }

        [Theory]
        [Description("1 min left timer interval should be calculated.")]
        [InlineData("0 17 * * Sunday", "0 18 * * Sunday", 2021, 4, 4, 16, 00, 7140000)] // GRB ends 18:00. Now is 16:00. Interval should be 01:59: 1h * 60m * 60s * 1000ms + 59m * 60s * 1000ms = 7,140,000
        [InlineData("0 17 * * Sunday", "0 18 * * Sunday", 2021, 4, 4, 17, 40, 1140000)]  // GRB ends 18:00. Now is 17:40. Interval should be 00:19: 19min * 60s * 1000ms = 1140000
        [InlineData("0 17 * * Sunday", "0 18 * * Sunday", 2021, 4, 4, 17, 59, 604800000)]  // GRB ends 18:00. Now is 17:59. Interval should be next week: 7d * 24h * 60m * 60s * 1000ms = 604800000 
        [InlineData("0 17 * * Sunday", "0 18 * * Sunday", 2021, 4, 4, 18, 00, 604740000)]  // GRB ends 18:00. Now is 18:00. Interval should be next week - 1min: 7d * 24h * 60m * 60s * 1000ms(604800000) - 1m * 60s * 1000ms(60000) = 604740000
        public void Get1MinLeftInterval_Test(string openTime, string closeTime, int year, int month, int day, int hour, int minute, double expected)
        {
            var now = new DateTime(year, month, day, hour, minute, 0);

            var timeService = new Mock<ITimeService>();
            timeService.Setup(x => x.UtcNow)
                       .Returns(now);

            var mapsLoader = new Mock<IMapsLoader>();
            mapsLoader.Setup(x => x.LoadMapDefinitions())
                      .Returns(new MapDefinitions()
                      {
                          Maps = new List<MapDefinition>()
                            {
                                new MapDefinition()
                                {
                                    Id = 50,
                                    CreateType = CreateType.GRB,
                                    OpenTime = openTime,
                                    CloseTime = closeTime
                                }
                            }
                      });

            var rankingManager = new GuildRankingManager(new Mock<ILogger<IGuildRankingManager>>().Object, mapsLoader.Object, timeService.Object, databaseMock.Object, new GuildHouseConfiguration());

            var interval = rankingManager.Get1MinLeftInterval();

            Assert.Equal(expected, interval);
        }

        [Theory]
        [Description("30 min after GRB interval should be calculated.")]
        [InlineData("0 17 * * Sunday", "0 18 * * Sunday", 2021, 4, 4, 16, 00, 9000000)] // GRB ends 18:00. Now is 16:00. Interval should be 02:30: 2h * 60m * 60s * 1000ms + 30m * 60s * 1000ms = 9,000,000
        [InlineData("0 17 * * Sunday", "0 18 * * Sunday", 2021, 4, 4, 17, 30, 3600000)]  // GRB ends 18:00. Now is 17:30. Interval should be 1h: 1h * 60m * 60s * 1000ms = 3,600,000
        [InlineData("0 17 * * Sunday", "0 18 * * Sunday", 2021, 4, 4, 18, 00, 1800000)]  // GRB ends 18:00. Now is 18:00. Interval should be 30min: 30m * 60s * 1000ms = 1,800,000
        [InlineData("0 17 * * Sunday", "0 18 * * Sunday", 2021, 4, 4, 18, 29, 60000)]    // GRB ends 18:00. Now is 18:29. Interval should be 1min:  1m * 60s * 1000ms = 60,000
        [InlineData("0 17 * * Sunday", "0 18 * * Sunday", 2021, 4, 4, 18, 30, 604800000)]  // GRB ends 18:00. Now is 18:30. Interval should be next week: 7d * 24h * 60m * 60s * 1000ms = 604800000 
        public void GetCalculateRanksInterval_Test(string openTime, string closeTime, int year, int month, int day, int hour, int minute, double expected)
        {
            var now = new DateTime(year, month, day, hour, minute, 0);

            var timeService = new Mock<ITimeService>();
            timeService.Setup(x => x.UtcNow)
                       .Returns(now);

            var mapsLoader = new Mock<IMapsLoader>();
            mapsLoader.Setup(x => x.LoadMapDefinitions())
                      .Returns(new MapDefinitions()
                      {
                          Maps = new List<MapDefinition>()
                            {
                                new MapDefinition()
                                {
                                    Id = 50,
                                    CreateType = CreateType.GRB,
                                    OpenTime = openTime,
                                    CloseTime = closeTime
                                }
                            }
                      });

            var rankingManager = new GuildRankingManager(new Mock<ILogger<IGuildRankingManager>>().Object, mapsLoader.Object, timeService.Object, databaseMock.Object, new GuildHouseConfiguration());

            var interval = rankingManager.GetCalculateRanksInterval();

            Assert.Equal(expected, interval);
        }

        [Fact]
        [Description("Ranking manager should calculate ranks based on guild points gained during GRB.")]
        public async Task CalculateRanks_Test()
        {
            var mapsLoader = new Mock<IMapsLoader>();
            mapsLoader.Setup(x => x.LoadMapDefinitions()).Returns(new MapDefinitions()
            {
                Maps = new List<MapDefinition>()
            });

            var data = new List<DbGuild>
            {
                new DbGuild("guild1", "", 1, Fraction.Light) { Id = 1 },
                new DbGuild("guild2", "", 2, Fraction.Light) { Id = 2 },
                new DbGuild("guild3", "", 3, Fraction.Light) { Id = 3 },
            }.AsQueryable();

            var mockSet = new Mock<DbSet<DbGuild>>();
            mockSet.As<IAsyncEnumerable<DbGuild>>()
                   .Setup(d => d.GetAsyncEnumerator(default))
                   .Returns(new AsyncEnumerator<DbGuild>(data.GetEnumerator()));

            mockSet.Setup(x => x.FindAsync(It.IsAny<uint>()))
                   .ReturnsAsync(new DbGuild("guild1", "", 1, Fraction.Light));


            mockSet.As<IQueryable<DbGuild>>()
                .Setup(m => m.Provider)
                .Returns(new TestDbAsyncQueryProvider<DbGuild>(data.Provider));

            mockSet.As<IQueryable<DbGuild>>().Setup(m => m.Expression).Returns(data.Expression);
            mockSet.As<IQueryable<DbGuild>>().Setup(m => m.ElementType).Returns(data.ElementType);
            mockSet.As<IQueryable<DbGuild>>().Setup(m => m.GetEnumerator()).Returns(data.GetEnumerator());

            var database = new Mock<IDatabase>();
            database.Setup(c => c.Guilds).Returns(mockSet.Object);
            database.Setup(x => x.SaveChangesAsync(default)).ReturnsAsync(1);

            var rankingManager = new GuildRankingManager(new Mock<ILogger<IGuildRankingManager>>().Object, mapsLoader.Object, new Mock<ITimeService>().Object, database.Object, new GuildHouseConfiguration());

            rankingManager.AddPoints(1, 10);
            rankingManager.AddPoints(1, 10);

            rankingManager.AddPoints(2, 10);
            rankingManager.AddPoints(2, 5);

            rankingManager.AddPoints(3, 20);
            rankingManager.AddPoints(3, 10);

            int guild1_Points = 0;
            byte guild1_Rank = 0;

            int guild2_Points = 0;
            byte guild2_Rank = 0;

            int guild3_Points = 0;
            byte guild3_Rank = 0;

            rankingManager.OnRanksCalculated += (IEnumerable<(uint GuildId, int Points, byte Rank)> results) =>
            {
                foreach (var res in results)
                {
                    if (res.GuildId == 1)
                    {
                        guild1_Points = res.Points;
                        guild1_Rank = res.Rank;
                        continue;
                    }

                    if (res.GuildId == 2)
                    {
                        guild2_Points = res.Points;
                        guild2_Rank = res.Rank;
                        continue;
                    }

                    if (res.GuildId == 3)
                    {
                        guild3_Points = res.Points;
                        guild3_Rank = res.Rank;
                        continue;
                    }
                }
            };

            await rankingManager.CalculateRanks();

            Assert.Equal(20, guild1_Points);
            Assert.Equal(15, guild2_Points);
            Assert.Equal(30, guild3_Points);

            Assert.Equal(2, guild1_Rank);
            Assert.Equal(3, guild2_Rank);
            Assert.Equal(1, guild3_Rank);
        }
    }
}
