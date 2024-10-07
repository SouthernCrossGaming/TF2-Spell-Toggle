# [TF2] Spell Toggle (Linux Only)
Toggles the usage / spawning of spells and spellbook effects

`sm_spells_enabled <0/1> Default: 1` Setting this to value to `1` or higher enables spells. `0` Disables them.

This disables spawning of the `tf_spell_pickup` entity (which is spawned on map start / between rounds). And disables `CTFSpellBook::RollNewSpell` in all instances.

Note: Linux only, someone can find the offset for Windows or maybe someday I'll setup the tools to do so myself.
