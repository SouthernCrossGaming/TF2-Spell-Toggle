#include <sourcemod>
#include <dhooks>

ConVar g_Cvar_Enabled;

Handle g_Spells = INVALID_HANDLE;

public Plugin myinfo = 
{
    name = "[TF2] Spell toggle",
    author = "Southern Cross Gaming",
    description = "Toggles the usage / spawning of spells and spellbook effects",
    version = "1.0",
    url = "https://scg.wtf"
}

public OnPluginStart()
{
    Handle hConf = LoadGameConfigFile("spells");
    
    g_Spells = DHookCreateFromConf(hConf, "CTFSpellBook::RollNewSpell");
    if (g_Spells == INVALID_HANDLE)
    {
        SetFailState("Failed to load CTFSpellBook::RollNewSpell");
    }

    DHookEnableDetour(g_Spells, false, Detour_ValidMap);

    g_Cvar_Enabled = CreateConVar("sm_spells_enabled", "1", "Should halloween spells be allowed to drop?");
}

public void OnEntityCreated(int entity, const char[] classname)
{
    if (g_Cvar_Enabled.IntValue) return;

    if (StrEqual(classname, "tf_spell_pickup"))
    {
        RemoveEntity(entity);
    }
}

public MRESReturn Detour_ValidMap(Address self)
{
    return (g_Cvar_Enabled.IntValue) ? MRES_Ignored : MRES_Supercede;
}