# L4D2_Common_Cvar_Lock
**Alliedmodders:** ...

Custom campaigns can run convar changes and director scripts from their maps. Some of these include changing the maximum amount of common infected on a map, or the horde sizes. 

This plugin locks those variables to their default values, and prevents campaigns from **INCREASING** those values past their defaults. This plugins still allows campaigns to lower/zero out those values, if they were designed to.


#### Plugin commands:
- `sm_set_common_limit` Bypass and set a new `z_common_limit`.

#### List of protected console variables:
- `z_common_limit` (default: 30)
- `z_mob_spawn_min_size` (default: 10)
- `z_mob_spawn_max_size` (default: 30)
- `z_mega_mob_size` (default: 50)

#### Todo:
- [x] Add leniencies.
- [ ] Cleanup code.
- [ ] Create admin convars.

# Credits
This plugin was inspired by an old `z_common_limit` lock by Tabun. However, it only seemed to handle director scripts. This plugin utilizes that, and also locks changes made via convars. Additional help from the Alliedmodder's Discord.