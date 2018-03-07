# [OTClient-Mod] health_and_mana_circle

Draw health circle and mana circle in game map.

Alternative method to show status of player health and mana.

# How to add?

Add folder [game_healthcircle] to "mods" or "modules" folder (recommended "mods" folder) in your main OTClient folder.

# How it's look like

![Show1](https://i.imgur.com/sENsGKQ.png)
![Show2](https://i.imgur.com/ABZF1gg.png)
![Show3_1.2](https://dl.getdropbox.com/s/juhuuaaurpzew62/New_game_healthcircle_04-03-2018.png)

# Additional controlling

- Set **ON** exp circle:
```
modules.game_healthcircle.setExpCircle(true)
```

- Set **OFF** exp circle:
```
modules.game_healthcircle.setExpCircle(false)
```

- Set **ON** skill circle:
```
modules.game_healthcircle.setSkillCircle(true)
```

- Set **OFF** skill circle:
```
modules.game_healthcircle.setSkillCircle(false)
```

- Change skill in bottom circle:
```
modules.game_healthcircle.setSkillType(skillType)
```

| `skillType` | magic | fist | club | sword | axe | distance | shielding | fishing |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |

```
For example:
modules.game_healthcircle.setSkillType("sword")
```

# Credits
@GustavoBlaze
@Tekadon58 [graphics](https://github.com/edubart/otclient/issues/923)
