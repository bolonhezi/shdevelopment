﻿using Imgeneus.Database.Constants;
using Imgeneus.Game.Skills;
using Imgeneus.World.Game;
using Imgeneus.World.Game.Inventory;
using System.ComponentModel;
using Xunit;

namespace Imgeneus.World.Tests
{
    public class ElementFactorTest : BaseTest
    {
        [Theory]

        // None vs none
        [InlineData(Element.None, Element.None, 1)]

        // Elem1 vs none
        [InlineData(Element.Fire1, Element.None, 1.2)]
        [InlineData(Element.Water1, Element.None, 1.2)]
        [InlineData(Element.Earth1, Element.None, 1.2)]
        [InlineData(Element.Wind1, Element.None, 1.2)]

        // Elem2 vs none
        [InlineData(Element.Fire2, Element.None, 1.3)]
        [InlineData(Element.Water2, Element.None, 1.3)]
        [InlineData(Element.Earth2, Element.None, 1.3)]
        [InlineData(Element.Wind2, Element.None, 1.3)]

        // None vs elem1
        [InlineData(Element.None, Element.Fire1, 0.8)]
        [InlineData(Element.None, Element.Water1, 0.8)]
        [InlineData(Element.None, Element.Earth1, 0.8)]
        [InlineData(Element.None, Element.Wind1, 0.8)]

        // None vs elem2
        [InlineData(Element.None, Element.Fire2, 0.7)]
        [InlineData(Element.None, Element.Water2, 0.7)]
        [InlineData(Element.None, Element.Earth2, 0.7)]
        [InlineData(Element.None, Element.Wind2, 0.7)]

        // Fire1 vs others
        [InlineData(Element.Fire1, Element.Wind1, 1.4)]
        [InlineData(Element.Fire1, Element.Earth1, 1)]
        [InlineData(Element.Fire1, Element.Fire1, 1)]
        [InlineData(Element.Fire1, Element.Water1, 0.5)]
        [InlineData(Element.Fire1, Element.Wind2, 1.3)]
        [InlineData(Element.Fire1, Element.Earth2, 1)]
        [InlineData(Element.Fire1, Element.Fire2, 1)]
        [InlineData(Element.Fire1, Element.Water2, 0.4)]

        // Fire2 vs others
        [InlineData(Element.Fire2, Element.Wind1, 1.6)]
        [InlineData(Element.Fire2, Element.Earth1, 1)]
        [InlineData(Element.Fire2, Element.Fire1, 1)]
        [InlineData(Element.Fire2, Element.Water1, 0.5)]
        [InlineData(Element.Fire2, Element.Wind2, 1.4)]
        [InlineData(Element.Fire2, Element.Earth2, 1)]
        [InlineData(Element.Fire2, Element.Fire2, 1)]
        [InlineData(Element.Fire2, Element.Water2, 0.5)]

        // Water1 vs others
        [InlineData(Element.Water1, Element.Wind1, 1)]
        [InlineData(Element.Water1, Element.Earth1, 0.5)]
        [InlineData(Element.Water1, Element.Fire1, 1.4)]
        [InlineData(Element.Water1, Element.Water1, 1)]
        [InlineData(Element.Water1, Element.Wind2, 1)]
        [InlineData(Element.Water1, Element.Earth2, 0.4)]
        [InlineData(Element.Water1, Element.Fire2, 1.3)]
        [InlineData(Element.Water1, Element.Water2, 1)]

        // Water2 vs others
        [InlineData(Element.Water2, Element.Wind1, 1)]
        [InlineData(Element.Water2, Element.Earth1, 0.5)]
        [InlineData(Element.Water2, Element.Fire1, 1.6)]
        [InlineData(Element.Water2, Element.Water1, 1)]
        [InlineData(Element.Water2, Element.Wind2, 1)]
        [InlineData(Element.Water2, Element.Earth2, 0.5)]
        [InlineData(Element.Water2, Element.Fire2, 1.4)]
        [InlineData(Element.Water2, Element.Water2, 1)]

        // Wind1 vs others
        [InlineData(Element.Wind1, Element.Wind1, 1)]
        [InlineData(Element.Wind1, Element.Earth1, 1.4)]
        [InlineData(Element.Wind1, Element.Fire1, 0.5)]
        [InlineData(Element.Wind1, Element.Water1, 1)]
        [InlineData(Element.Wind1, Element.Wind2, 1)]
        [InlineData(Element.Wind1, Element.Earth2, 1.3)]
        [InlineData(Element.Wind1, Element.Fire2, 0.4)]
        [InlineData(Element.Wind1, Element.Water2, 1)]

        // Wind2 vs others
        [InlineData(Element.Wind2, Element.Wind1, 1)]
        [InlineData(Element.Wind2, Element.Earth1, 1.6)]
        [InlineData(Element.Wind2, Element.Fire1, 0.5)]
        [InlineData(Element.Wind2, Element.Water1, 1)]
        [InlineData(Element.Wind2, Element.Wind2, 1)]
        [InlineData(Element.Wind2, Element.Earth2, 1.4)]
        [InlineData(Element.Wind2, Element.Fire2, 0.5)]
        [InlineData(Element.Wind2, Element.Water2, 1)]

        // Earth1 vs others
        [InlineData(Element.Earth1, Element.Wind1, 0.5)]
        [InlineData(Element.Earth1, Element.Earth1, 1)]
        [InlineData(Element.Earth1, Element.Fire1, 1)]
        [InlineData(Element.Earth1, Element.Water1, 1.4)]
        [InlineData(Element.Earth1, Element.Wind2, 0.4)]
        [InlineData(Element.Earth1, Element.Earth2, 1)]
        [InlineData(Element.Earth1, Element.Fire2, 1)]
        [InlineData(Element.Earth1, Element.Water2, 1.3)]

        // Earth2 vs others
        [InlineData(Element.Earth2, Element.Wind1, 0.5)]
        [InlineData(Element.Earth2, Element.Earth1, 1)]
        [InlineData(Element.Earth2, Element.Fire1, 1)]
        [InlineData(Element.Earth2, Element.Water1, 1.6)]
        [InlineData(Element.Earth2, Element.Wind2, 0.5)]
        [InlineData(Element.Earth2, Element.Earth2, 1)]
        [InlineData(Element.Earth2, Element.Fire2, 1)]
        [InlineData(Element.Earth2, Element.Water2, 1.4)]

        [Description("Check right element factors.")]
        public void ElementTests(Element attackElement, Element defenceElement, double expectedFactor)
        {
            IKiller character = CreateCharacter();
            Assert.Equal(expectedFactor, character.AttackManager.GetElementFactor(attackElement, defenceElement));
        }

        [Fact]
        [Description("When debuff, that removes element is used, character element should be none.")]
        public void RemoveElementTest()
        {
            var character = CreateCharacter();
            Assert.Equal(Element.None, character.ElementProvider.DefenceElement);

            character.InventoryManager.Armor = new Item(definitionsPreloader.Object, enchantConfig.Object, itemCreateConfig.Object, WaterArmor.Type, WaterArmor.TypeId);
            Assert.Equal(Element.Water1, character.ElementProvider.DefenceElement);

            character.BuffsManager.AddBuff(new Skill(AttributeRemove, 0, 0), null);
            Assert.Equal(Element.None, character.ElementProvider.DefenceElement);
        }

        [Fact]
        [Description("Character should be able to change his attack element by using special skill.")]
        public void AttackElementSkillTest()
        {
            var character = CreateCharacter();
            Assert.Equal(Element.None, character.ElementProvider.AttackElement);

            character.InventoryManager.Weapon = new Item(definitionsPreloader.Object, enchantConfig.Object, itemCreateConfig.Object, FireSword.Type, FireSword.TypeId);
            Assert.Equal(Element.Fire1, character.ElementProvider.AttackElement);

            character.BuffsManager.AddBuff(new Skill(EarthWeapon, 0, 0), null);
            Assert.Equal(Element.Earth1, character.ElementProvider.AttackElement);
        }

        [Fact]
        [Description("Character should be able to change his defence element by using special skill")]
        public void ElementalProtectionTest()
        {
            var character = CreateCharacter();
            Assert.Equal(Element.None, character.ElementProvider.DefenceElement);

            character.InventoryManager.Armor = new Item(definitionsPreloader.Object, enchantConfig.Object, itemCreateConfig.Object, WaterArmor.Type, WaterArmor.TypeId);
            Assert.Equal(Element.Water1, character.ElementProvider.DefenceElement);

            character.BuffsManager.AddBuff(new Skill(EarthSkin, 0, 0), null);
            Assert.Equal(Element.Earth1, character.ElementProvider.DefenceElement);
        }

        [Fact]
        [Description("Element skin buff should be cleared if new skill was used")]
        public void ElementalSkinSkillTest()
        {
            var character = CreateCharacter();
            character.BuffsManager.AddBuff(new Skill(EarthSkin, 0, 0), null);
            Assert.Equal(Element.Earth1, character.ElementProvider.DefenceElement);
            Assert.Single(character.BuffsManager.ActiveBuffs);

            character.BuffsManager.AddBuff(new Skill(FireSkin, 0, 0), null);
            Assert.Equal(Element.Fire1, character.ElementProvider.DefenceElement);
            Assert.Single(character.BuffsManager.ActiveBuffs);
        }

        [Fact]
        [Description("Element weapon buff should be cleared if new skill was used")]
        public void ElementalWeaponSkillTest()
        {
            var character = CreateCharacter();
            character.BuffsManager.AddBuff(new Skill(EarthWeapon, 0, 0), null);
            Assert.Equal(Element.Earth1, character.ElementProvider.AttackElement);
            Assert.Single(character.BuffsManager.ActiveBuffs);

            character.BuffsManager.AddBuff(new Skill(FireWeapon, 0, 0), null);
            Assert.Equal(Element.Fire1, character.ElementProvider.AttackElement);
            Assert.Single(character.BuffsManager.ActiveBuffs);
        }
    }
}
