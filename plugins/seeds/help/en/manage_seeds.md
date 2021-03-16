---
toc: ~admin~ Managing the Game
summary: Managing Seeds.
---
# Managing Seeds

> **Permission Required:** These commands require the Admin role.

## Viewing Seeds

Admin can view the seeds of other characters.

`seeds <char name>` - View someone's seed list. For subsequent pages, use `seeds2 <char name>`, etc.
`seeds/view <char name>=<seed id number>` - View a specific seed. You can get the id number by viewing their `seeds` list.

## Sending, Updating, and Deleting Seeds Individually

If you have the appropriate permissions, you can send, update, and delete seeds individually.

`seeds/send <character name>=<seed title>/<seed text>` -  Send a seed to someone.
`seeds/update <character name>=<seed id number>/<seed desc>` - Update a seed. You can get the id number by viewing their `seeds` list.
`seeds/rm <character name>=<seed id number>` - Remove a seed. You can get the id number by viewing their `seeds` list.

There is an edge case where a player may not be able to clear a seed notification, if you delete the seed before they can read it.
In this instance, have the player go to the website and clear the notification from there.

## Sending Seeds to a Category

You can also send seeds to a group of people who share a category. The seed will be sent to all characters with that specific category set.

`seeds/setcat <name>=<seed category name>` - Set a category on someone (e.g. `seeds/setcat Ariel=princesses`)
`seeds/sendcat <seed category name>=<seed title>/<seed text>` - Send a seed to the category.