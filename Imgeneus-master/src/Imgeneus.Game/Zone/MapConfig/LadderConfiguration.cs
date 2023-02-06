﻿using System.Text.Json.Serialization;

namespace Imgeneus.World.Game.Zone.MapConfig
{
    public class LadderConfiguration
    {
        [JsonPropertyName("x")]
        public float X { get; set; }

        [JsonPropertyName("y")]
        public float Y { get; set; }

        [JsonPropertyName("z")]
        public float Z { get; set; }
    }
}