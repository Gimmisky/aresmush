---
toc: 4 - Writing the Story
summary: Generating a Random Arena.
aliases:
- arena
---
# Random Arena

The arena/random command will generate a random sceneset idea in the style of an enemy encounter (a la the Danger Room), using a number of parameters.

Syntax: `arena/random <area level>=<enemy level>/<condition level>`

'Area level' will take a number between 1 and 5, with 1 indicating a location of lowest difficulty, on up to 5 indicating the highest difficulty.
'Enemy level' will take one of Omega, Alpha, Beta, Gamma, or Delta, with Omega indicating an enemy of the greatest threat, and Delta the least.
'Condition level' will take one of mild, moderate, or extreme, and select an environmental condition appropriately.

Example: `arena/random 4=Alpha/moderate`