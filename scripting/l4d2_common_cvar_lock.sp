#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>
#include <left4dhooks>

bool ignoreChangehook;
ConVar z_common_limit;
ConVar z_mob_spawn_max_size;
ConVar z_mob_spawn_min_size;
ConVar z_mega_mob_size;
int default_z_common_limit;
int default_z_mob_spawn_max_size;
int default_z_mob_spawn_min_size;
int default_z_mega_mob_size;

public Plugin myinfo = 
{
	name = "[L4D2] Lock Common Infected CVars",
	author = "Addie, Tabun, Xbye",
	description = "Prevents campaigns of increasing common related cvars via ConVar and director scripts.",
	version = "0.3",
	// url = ""
}

public void OnPluginStart() 
{
    ignoreChangehook = false;

    z_common_limit = FindConVar("z_common_limit");
    z_common_limit.AddChangeHook(OnCommonLimit);

    z_mob_spawn_min_size = FindConVar("z_mob_spawn_min_size");
    z_mob_spawn_min_size.AddChangeHook(OnMinMob);

    z_mob_spawn_max_size = FindConVar("z_mob_spawn_max_size");
    z_mob_spawn_max_size.AddChangeHook(OnMaxMob);

    z_mega_mob_size = FindConVar("z_mega_mob_size");
    z_mega_mob_size.AddChangeHook(OnMegaMob);
    
    default_z_common_limit = 30;
    default_z_mob_spawn_min_size = 10;
    default_z_mob_spawn_max_size = 30;
    default_z_mega_mob_size = 50;

    RegAdminCmd("sm_set_common_limit", Cmd_SetCommonLimit, ADMFLAG_GENERIC);
}
Action Cmd_SetCommonLimit(int client, int args)
{
    ignoreChangehook = true;
    z_common_limit.IntValue = GetCmdArgInt(1);
    ignoreChangehook = false;

    return Plugin_Handled;
}
void OnCommonLimit(ConVar convar, const char[] oldValue, const char[] newValue)
{
    if (ignoreChangehook || StringToInt(newValue) < default_z_common_limit)
        return;                                  // Default: 30
    convar.IntValue = default_z_common_limit;
}

void OnMinMob(ConVar convar, const char[] oldValue, const char[] newValue)
{
    if (ignoreChangehook || StringToInt(newValue) < default_z_mob_spawn_min_size)
        return;                                  // Default: 10
    convar.IntValue = default_z_mob_spawn_min_size;
}

void OnMaxMob(ConVar convar, const char[] oldValue, const char[] newValue)
{
    if (ignoreChangehook || StringToInt(newValue) < default_z_mob_spawn_max_size)
        return;                                  // Default: 30
    convar.IntValue = default_z_mob_spawn_max_size;
}

void OnMegaMob(ConVar convar, const char[] oldValue, const char[] newValue)
{
    if (ignoreChangehook || StringToInt(newValue) < default_z_mega_mob_size)
        return;                                  // Default: 50
    convar.IntValue = default_z_mega_mob_size;
}

// From Tabun's scripts
public Action L4D_OnGetScriptValueInt(const char[] key, int &retVal)
{
    if (strcmp(key, "CommonLimit") == 0) {
        if (retVal >= default_z_common_limit) {
            retVal = default_z_common_limit;
            return Plugin_Handled;
        }
    }
    else if(strcmp(key, "MobMinSize") == 0)
    {
        if (retVal >= default_z_mob_spawn_min_size)
        {
            retVal = default_z_mob_spawn_min_size;
            return Plugin_Handled;
        }
    }
    else if(strcmp(key, "MobMaxSize") == 0)
    {
        if (retVal >= default_z_mob_spawn_max_size)
        {
            retVal = default_z_mob_spawn_max_size;
            return Plugin_Handled;
        }
    }
    else if(strcmp(key, "MegaMobSize") == 0)
    {
        if (retVal >= default_z_mega_mob_size)
        {
            retVal = default_z_mega_mob_size;
            return Plugin_Handled;
        }
    }

    return Plugin_Continue;
}