﻿namespace Imgeneus.World.Game.AI
{
    public enum AIState
    {
        /// <summary>
        /// Mob will walk around.
        /// </summary>
        Idle,

        /// <summary>
        /// Mob will follow the player, until it gets close enough to the player.
        /// </summary>
        Chase,

        /// <summary>
        /// Mob is close to player and ready to attack.
        /// </summary>
        ReadyToAttack,

        /// <summary>
        /// Mob is returning back to its' birth position.
        /// </summary>
        BackToBirthPosition,

        /// <summary>
        /// Mob is dead. Do nothing.
        /// </summary>
        Stopped

    }
}
