---
toc: ~admin~ Managing the Game
summary: Managing Random Arenas.
---
# Managing Random Arenas

> **Permission Required:** These commands require the Admin role.

## Adding New Arenas

There are three components to a random arena: the location (ex. Morlock Tunnels), an enemy (ex. Magneto), and an environmental condition (ex. hurricane).

For each component, there is a yml file in the game's configuration, under `Admin -> Setup`.

`randomset_arena.yml` is where you can add new locations.
`randomset_enemies.yml` is where you can add new enemies.
`randomset_conditions.yml` is where you can add new conditions.

You must follow the formatting of the existing examples when adding new entries. Things will break if the formatting is not quite exact.

Coded by Warren (@Altair).