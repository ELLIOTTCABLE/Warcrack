local OVALE, Ovale = ...
local OvaleScripts = Ovale.OvaleScripts

do
	local name = "ovale_warrior_spells"
	local desc = "[6.1] Ovale: Warrior spells"
	local code = [[
# Warrior spells and functions.

# Learned spells.
Define(bastion_of_defense 84608)
	SpellInfo(bastion_of_defense learn=1 level=60 specialization=protection)
Define(bloodsurge 46915)
	SpellInfo(bloodsurge learn=1 level=50 specialization=fury)
Define(headlong_rush 158836)
	SpellInfo(headlong_rush learn=1 level=15)
Define(meat_cleaver 12950)
	SpellInfo(meat_cleaver learn=1 level=58 specialization=fury)
Define(sword_and_board 46953)
	SpellInfo(sword_and_board learn=1 level=10 specialization=protection)
Define(ultimatum 122509)
	SpellInfo(ultimatum learn=1 level=10 specialization=protection)
Define(unwavering_sentinel 29144)
	SpellInfo(unwavering_sentinel learn=1 level=10 specialization=protection)

Define(anger_management_talent 19)
Define(avatar 107574)
	SpellInfo(avatar cd=90 gcd=0)
	SpellInfo(avatar buff_cdr=cooldown_reduction_strength_buff specialization=arms)
	SpellInfo(avatar buff_cdr=cooldown_reduction_strength_buff specialization=fury)
Define(avatar_buff 107574)
	SpellInfo(avatar_buff duration=20)
Define(avatar_talent 16)
Define(battle_shout 6673)
	SpellAddBuff(battle_shout battle_shout_buff=1)
Define(battle_shout_buff 6673)
	SpellInfo(battle_shout_buff duration=3600)
Define(battle_stance 2457)
	SpellInfo(battle_stance cd=1.5 to_stance=warrior_battle_stance)
	SpellInfo(battle_stance replace=gladiator_stance unusable=1 if_spell=gladiators_resolve)
	SpellInfo(battle_stance unusable=1 if_stance=warrior_battle_stance)
Define(berserker_rage 18499)
	SpellInfo(berserker_rage cd=30 gcd=0 rage=-10)
	SpellAddBuff(berserker_rage berserker_rage_buff=1)
	SpellAddBuff(berserker_rage enrage_buff=1 specialization=fury)
	SpellAddBuff(berserker_rage enrage_buff=1 specialization=protection)
	SpellAddBuff(berserker_rage raging_blow_buff=1 if_spell=raging_blow)
Define(berserker_rage_buff 18499)
	SpellInfo(berserker_rage_buff duration=6 enrage=1)
Define(bladestorm 46924)
	SpellInfo(bladestorm cd=60 channel=6)
	SpellInfo(bladestorm buff_cdr=cooldown_reduction_strength_buff specialization=arms)
	SpellInfo(bladestorm buff_cdr=cooldown_reduction_strength_buff specialization=fury)
Define(bladestorm_talent 18)
Define(bloodbath 12292)
	SpellInfo(bloodbath cd=60 gcd=0)
	SpellInfo(bloodbath buff_cdr=cooldown_reduction_strength_buff specialization=arms)
	SpellInfo(bloodbath buff_cdr=cooldown_reduction_strength_buff specialization=fury)
	SpellAddBuff(bloodbath bloodbath_buff=1)
Define(bloodbath_buff 12292)
	SpellInfo(bloodbath_buff duration=12)
Define(bloodbath_talent 17)
Define(bloodsurge_buff 46916)
	SpellInfo(bloodsurge_buff duration=15 max_stacks=2)
Define(bloodthirst 23881)
	SpellInfo(bloodthirst cd=4.5 rage=-10)
	SpellInfo(bloodthirst cd=0 if_spell=unquenchable_thirst)
	SpellInfo(bloodthirst cd_haste=melee if_spell=headlong_rush)
	SpellAddTargetDebuff(bloodthirst deep_wounds_debuff=1 if_spell=deep_wounds)
Define(charge 100)
	SpellInfo(charge cd=20 gcd=0 offgcd=1 rage=-20 travel_time=1)
	SpellInfo(charge addcd=-8 if_spell=juggernaut)
	SpellInfo(charge rage=-35 glyph=glyph_of_bull_rush)
	SpellAddTargetDebuff(charge charge_debuff=1)
Define(charge_debuff 100)	# OvaleWarriorCharge
Define(colossus_smash 167105)
	SpellInfo(colossus_smash cd=20 rage=10)
	SpellInfo(colossus_smash rage=-20 itemset=T17 itemcount=4 specialization=arms)
	SpellInfo(colossus_smash to_stance=warrior_battle_stance if_stance=warrior_defensive_stance)
	SpellAddTargetDebuff(colossus_smash colossus_smash_debuff=1)
Define(colossus_smash_debuff 167105)
	SpellInfo(colossus_smash_debuff duration=6)
Define(commanding_shout 469)
	SpellAddBuff(commanding_shout commanding_shout_buff=1)
Define(commanding_shout_buff 469)
	SpellInfo(commanding_shout_buff duration=3600)
Define(deadly_calm_buff 166587)
	SpellInfo(deadly_calm_buff duration=10)
Define(death_sentence_buff 144442)	# tier16_4pc_melee_buff
	SpellInfo(death_sentence_buff duration=12)
Define(deep_wounds 115767)
Define(deep_wounds_debuff 115767)
	SpellInfo(deep_wounds_debuff duration=15 tick=3)
Define(defensive_stance 71)
	SpellInfo(defensive_stance cd=1.5 to_stance=warrior_defensive_stance)
	SpellInfo(defensive_stance unusable=1 if_stance=warrior_defensive_stance)
Define(demoralizing_shout 1160)
	SpellInfo(demoralizing_shout cd=60 gcd=0 offgcd=1)
	SpellInfo(demoralizing_shout buff_cdr=cooldown_reduction_tank_buff)
	SpellAddTargetDebuff(demoralizing_shout demoralizing_shout_debuff=1)
Define(demoralizing_shout_debuff 1160)
	SpellInfo(demoralizing_shout_debuff duration=8)
Define(devastate 20243)
	SpellAddBuff(devastate unyielding_strikes_buff=1 if_spell=unyielding_strikes)
	SpellAddTargetDebuff(devastate deep_wounds_debuff=1 if_spell=deep_wounds)
Define(dragon_roar 118000)
	SpellInfo(dragon_roar cd=60)
	SpellInfo(dragon_roar buff_cdr=cooldown_reduction_strength_buff specialization=arms)
	SpellInfo(dragon_roar buff_cdr=cooldown_reduction_strength_buff specialization=fury)
Define(dragon_roar_talent 12)
Define(enhanced_whirlwind 157473)
Define(enrage_buff 12880)
	SpellInfo(enrage_buff duration=8 enrage=1)
Define(enraged_regeneration 55694)
	SpellInfo(enraged_regeneration cd=60 gcd=0 offgcd=1)
Define(enraged_regeneration_buff 55694)
	SpellInfo(enraged_regeneration_buff duration=5 tick=1)
Define(execute 5308)
	SpellInfo(execute rage=30 target_health_pct=20)
	SpellRequire(execute rage 0=buff,sudden_death_buff if_spell=sudden_death)
	SpellRequire(execute target_health_pct 100=buff,execute_no_target_health_pct_buff)
	SpellAddBuff(execute death_sentence_buff=0 itemset=T16_melee itemcount=4)
	SpellAddBuff(execute sudden_execute_buff=1 if_spell=sudden_death)
SpellList(execute_no_target_health_pct_buff death_sentence_buff sudden_death_buff)
Define(execute_arms 163201)
	SpellInfo(execute_arms rage=10 extra_rage=30 target_health_pct=20)
	SpellRequire(execute_arms rage 0=buff,sudden_death_buff if_spell=sudden_death)
	SpellRequire(execute_arms target_health_pct 100=buff,execute_no_target_health_pct_buff)
	SpellAddBuff(execute_arms death_sentence_buff=0 itemset=T16_melee itemcount=4)
	SpellAddBuff(execute_arms sudden_execute_buff=1 if_spell=sudden_death)
Define(gladiator_stance 156291)
	SpellInfo(gladiator_stance cd=1.5 to_stance=warrior_gladiator_stance)
	SpellInfo(gladiator_stance unusable=1 if_stance=warrior_gladiator_stance)
Define(gladiators_resolve 152276)
Define(gladiators_resolve_talent 21)
Define(glyph_of_bull_rush 94372)
Define(glyph_of_death_from_above 63325)
Define(glyph_of_gag_order 58357)
Define(glyph_of_recklessness 94374)
Define(glyph_of_resonating_power 58356)
Define(glyph_of_shield_wall 63329)
Define(glyph_of_spell_reflection 63328)
Define(heroic_leap 6544)
	SpellInfo(heroic_leap cd=45 gcd=0 offgcd=1 travel_time=1)
	SpellInfo(heroic_leap addcd=-15 glyph=glyph_of_death_from_above)
	SpellInfo(heroic_leap buff_cdr=cooldown_reduction_strength_buff specialization=arms)
	SpellInfo(heroic_leap buff_cdr=cooldown_reduction_strength_buff specialization=fury)
	SpellInfo(heroic_leap buff_cdr=cooldown_reduction_tank_buff specialization=protection)
Define(heroic_strike 78)
	SpellInfo(heroic_strike cd=1.5 gcd=0 offgcd=1 rage=30)
	SpellInfo(heroic_strike buff_rage=unyielding_strikes_buff buff_rage_amount=-5 if_spell=unyielding_strikes)
	SpellRequire(heroic_strike rage 0=buff,ultimatum_buff if_spell=ultimatum)
	SpellAddBuff(heroic_strike ultimatum_buff=0 if_spell=ultimatum)
	SpellAddBuff(heroic_strike unyielding_strikes_buff=0 if_spell=unyielding_strikes)
	SpellAddBuff(heroic_strike shield_charge_buff=0 if_spell=shield_charge)
Define(heroic_throw 57755)
	SpellInfo(heroic_throw cd=30 travel_time=1)
	SpellInfo(heroic_throw cd=0 if_spell=improved_heroic_throw)
	SpellInfo(heroic_throw interrupt=1 glyph=glyph_of_gag_order)
Define(impending_victory 103840)
	SpellInfo(impending_victory rage=10 cd=30)
	SpellRequire(impending_victory cd 0=victorious_buff)
	SpellAddBuff(impending_victory victorious_buff=0)
Define(impending_victory_talent 6)
Define(improved_heroic_throw 157479)
Define(juggernaut 103826)
Define(juggernaut_talent 1)
Define(last_stand 12975)
	SpellInfo(last_stand cd=180 gcd=0 offgcd=1)
	SpellInfo(last_stand addcd=-60 itemset=T14_tank itemcount=2)
	SpellInfo(last_stand buff_cdr=cooldown_reduction_tank_buff)
	SpellAddBuff(last_stand last_stand_buff=1)
Define(last_stand_buff 12975)
	SpellInfo(last_stand_buff duration=15)
Define(meat_cleaver_buff 85739)
	SpellInfo(meat_cleaver_buff duration=10 max_stacks=3)
	SpellInfo(meat_cleaver_buff max_stacks=4 if_spell=enhanced_whirlwind)
Define(mortal_strike 12294)
	SpellInfo(mortal_strike cd=6 rage=20)
	SpellInfo(mortal_strike cd_haste=melee if_spell=headlong_rush)
	SpellRequire(mortal_strike cd 3=buff,deadly_calm_buff itemset=T17 itemcount=4)
	SpellAddTargetDebuff(mortal_strike deep_wounds_debuff=1 if_spell=deep_wounds)
	SpellAddTargetDebuff(mortal_strike mortal_wounds_debuff=1)
Define(mortal_wounds_debuff 115804)
	SpellInfo(mortal_wounds_debuff duration=10)
Define(pummel 6552)
	SpellInfo(pummel cd=15 gcd=0 interrupt=1 offgcd=1)
Define(raging_blow 85288)
	SpellInfo(raging_blow rage=10)
	SpellRequire(raging_blow unusable 1=buff,!raging_blow_buff)
	SpellAddBuff(raging_blow raging_blow_buff=-1)
	SpellAddBuff(raging_blow meat_cleaver_buff=0 if_spell=meat_cleaver)
Define(raging_blow_buff 131116)
	SpellInfo(raging_blow_buff duration=12 max_stacks=2)
Define(rampage_buff 166588)
	SpellInfo(rampage_buff duration=5)
Define(ravager 152277)
	SpellInfo(ravager cd=60)
	SpellInfo(ravager ravager_buff=1)
Define(ravager_buff 152277)
	SpellInfo(ravager_buff duration=10)
Define(ravager_protection_buff 152277)
	SpellInfo(ravager_protection_buff duration=10)
Define(ravager_talent 20)
Define(recklessness 1719)
	SpellInfo(recklessness cd=180 gcd=0)
	SpellInfo(recklessness addcd=-90 itemset=T14_melee itemcount=4)
	SpellInfo(recklessness buff_cdr=cooldown_reduction_strength_buff specialization=arms)
	SpellInfo(recklessness buff_cdr=cooldown_reduction_strength_buff specialization=fury)
	SpellInfo(recklessness to_stance=warrior_battle_stance if_stance=warrior_defensive_stance)
	SpellAddBuff(recklessness recklessness_buff=1)
	SpellAddBuff(recklessness rampage_buff=1 itemset=T17 itemcount=4 specialization=fury)
Define(recklessness_buff 1719)
	SpellInfo(recklessness_buff duration=10)
	SpellInfo(recklessness_buff addduration=5 glyph=glyph_of_recklessness)
	SpellInfo(recklessness_buff addduration=5 itemset=T15_melee itemcount=4)
Define(rend 772)
	SpellInfo(rend rage=5)
Define(rend_debuff 772)
	SpellInfo(rend_debuff duration=18 tick=3)
Define(revenge 6572)
	SpellInfo(revenge cd=9)
	SpellInfo(revenge rage=-20 if_stance=warrior_defensive_stance)
	SpellInfo(revenge unusable=1 if_stance=warrior_battle_stance)
	SpellAddBuff(revenge shield_charge_buff=0 if_spell=shield_charge)
Define(shield_barrier_tank 112048)
	SpellInfo(shield_barrier_tank cd=1.5 gcd=0 rage=20 extra_rage=40)
	SpellAddBuff(shield_barrier_tank shield_barrier_tank_buff=1)
Define(shield_barrier_tank_buff 174926)
	SpellInfo(shield_barrier_tank_buff duration=6)
Define(shield_barrier_melee 174926)
	SpellInfo(shield_barrier_melee cd=1.5 gcd=0 rage=20 extra_rage=40 stance=warrior_defensive_stance)
	SpellAddBuff(shield_barrier_melee shield_barrier_melee_buff=1)
Define(shield_barrier_melee_buff 174926)
	SpellInfo(shield_barrier_melee_buff duration=6)
Define(shield_block 2565)
	SpellInfo(shield_block cd=1.5 gcd=0 rage=60)
	SpellInfo(shield_block rage=55 itemset=T14_tank itemcount=4)
	SpellInfo(shield_block replace=shield_charge unusable=1 if_stance=warrior_gladiator_stance)
Define(shield_block_buff 132404)
	SpellInfo(shield_block_buff duration=6)
Define(shield_charge 156321)
	SpellInfo(shield_charge cd=1.5 gcd=0 rage=20)
	SpellInfo(shield_charge unusable=1 if_stance=!warrior_gladiator_stance)
	SpellAddBuff(shield_charge shield_charge_buff=1)
Define(shield_charge_buff 169667)
	SpellInfo(shield_charge_buff duration=7)
Define(shield_slam 23922)
	SpellInfo(shield_slam cd=6 rage=-20)
	SpellInfo(shield_slam buff_rage=sword_and_board_buff buff_rage_amount=-5 if_spell=sword_and_board)
	SpellInfo(shield_slam cd_haste=melee if_spell=headlong_rush)
	SpellAddBuff(shield_slam shield_charge_buff=0 if_spell=shield_charge)
	SpellAddBuff(shield_slam sword_and_board_buff=0 if_spell=sword_and_board)
Define(shield_wall 871)
	SpellInfo(shield_wall cd=180 gcd=0 offgcd=1)
	SpellInfo(shield_wall addcd=120 glyph=glyph_of_shield_wall)
	SpellInfo(shield_wall addcd=-60 if_spell=bastion_of_defense)
	SpellAddBuff(shield_wall shield_wall_buff=1)
Define(shield_wall_buff 871)
	SpellInfo(shield_wall duration=8)
	SpellInfo(shield_wall buff_cdr=cooldown_reduction_tank_buff specialization=protection)
Define(shockwave 46968)
	SpellInfo(shockwave cd=40)
	SpellInfo(shockwave buff_cdr=cooldown_reduction_strength_buff specialization=arms)
	SpellInfo(shockwave buff_cdr=cooldown_reduction_strength_buff specialization=fury)
Define(shockwave_talent 11)
Define(siegebreaker 176289)
	SpellInfo(siegebreaker cd=45)
Define(slam 1464)
	SpellInfo(slam rage=10)
Define(slam_talent 9)
Define(spell_reflection 23920)
	SpellInfo(spell_reflection cd=25)
	SpellInfo(spell_reflection addcd=-5 glyph=glyph_of_spell_reflection)
Define(storm_bolt 107570)
	SpellInfo(storm_bolt cd=30)
	SpellInfo(storm_bolt buff_cdr=cooldown_reduction_strength_buff specialization=arms)
	SpellInfo(storm_bolt buff_cdr=cooldown_reduction_strength_buff specialization=fury)
Define(storm_bolt_talent 18)
Define(sudden_death 29725)
Define(sudden_death_buff 52437)
	SpellInfo(sudden_death_buff duration=10)
Define(sweeping_strikes 12328)
	SpellInfo(sweeping_strikes cd=10 gcd=0 rage=10)
	SpellInfo(sweeping_strikes to_stance=warrior_battle_stance if_stance=warrior_defensive_stance)
Define(sword_and_board_buff 50227)
	SpellInfo(sword_and_board_buff duration=10)
Define(taste_for_blood_talent 7)
Define(thunder_clap 6343)
	SpellInfo(thunder_clap cd=6 rage=10)
	SpellInfo(thunder_clap addcd=3 glyph=glyph_of_resonating_power)
	SpellInfo(thunder_clap cd_haste=melee if_spell=headlong_rush)
	SpellInfo(thunder_clap rage=0 if_spell=unwavering_sentinel if_stance=warrior_defensive_stance)
	SpellAddTargetDebuff(thunder_clap deep_wounds_debuff=1 if_spell=deep_wounds)
Define(ultimatum_buff 122510)
	SpellInfo(ultimatum_buff duration=10)
Define(unquenchable_thirst 169683)
Define(unquenchable_thirst_talent 9)
Define(unyielding_strikes 169685)
Define(unyielding_strikes_buff 169686)
	SpellInfo(unyielding_strikes_buff duration=5 max_stacks=6 stacking=1)
Define(unyielding_strikes_talent 9)
Define(victorious_buff 32216)
	SpellInfo(victorious_buff duration=20)
Define(victory_rush 34428)
	SpellRequire(victory_rush unusable 1=buff,!victorious_buff)
	SpellAddBuff(victory_rush victorious_buff=0)
Define(whirlwind 1680)
	SpellInfo(whirlwind rage=20)
	SpellAddBuff(whirlwind meat_cleaver_buff=1 if_spell=!enhanced_whirlwind if_spell=meat_cleaver)
	SpellAddBuff(whirlwind meat_cleaver_buff=2 if_spell=enhanced_whirlwind if_spell=meat_cleaver)
Define(wild_strike 100130)
	SpellInfo(wild_strike rage=45)
	SpellRequire(wild_strike rage 0=buff,bloodsurge_buff if_spell=bloodsurge)
	SpellAddBuff(wild_strike bloodsurge_buff=-1 if_spell=bloodsurge)

# Non-default tags for OvaleSimulationCraft.
	SpellInfo(bloodbath tag=cd)
	SpellInfo(heroic_throw tag=main)
	SpellInfo(impending_victory tag=main)
	SpellInfo(sweeping_strikes tag=main)
]]

	OvaleScripts:RegisterScript("WARRIOR", nil, name, desc, code, "include")
end
