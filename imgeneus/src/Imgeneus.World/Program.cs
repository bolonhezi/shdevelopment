﻿using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Hosting;
using NLog.Web;
using Microsoft.Extensions.Logging;
using System;
using Sylver.HandlerInvoker;
using Imgeneus.Network.Packets;
using Imgeneus.Network.PacketProcessor;

namespace Imgeneus.World
{
    public static class Program
    {
        public static void Main(string[] args)
        {
            var logger = NLogBuilder.ConfigureNLog("NLog.Config").GetCurrentClassLogger();
            try
            {
                CreateHostBuilder(args)
                    .Build()
                    .AddHandlerParameterTransformer<ImgeneusPacket, IPacketDeserializer>((source, dest) =>
                    {
                        dest?.Deserialize(source);
                        return dest;
                    })
                    .Run();
            }
            catch (Exception ex)
            {
                logger.Error(ex, "Stopped program because of exception");
                throw;
            }
            finally
            {
                // Ensure to flush and stop internal timers/threads before application-exit (Avoid segmentation fault on Linux)
                NLog.LogManager.Shutdown();
            }
        }

        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureWebHostDefaults(webBuilder =>
                {
                    webBuilder.UseStartup<WorldServerStartup>()
                    .ConfigureLogging(builder =>
                    {
                        builder.ClearProviders();
                        builder.AddFilter("Microsoft", LogLevel.Warning);
#if DEBUG
                        builder.SetMinimumLevel(LogLevel.Trace);
#else
                        builder.SetMinimumLevel(LogLevel.Information);
#endif
                    })
                    .UseNLog();
                });
    }
}
