# Copy from chest
Adds **server command** `copy-from-chest <x> <y> <z> <player> [once]`.

- **Version:** 1.0.0
- **License:** LGPL 2.1 or later

Report bugs or request help at zrnmbrs@gmail.com

# If you dont know what <> and [] mean in the command read this
https://wiki.minetest.net/Server_commands#General_syntax

# What the command does
Copies items from chest at <x> <y> <z> to the <player>.
This command requires server priviliges.

If `[once]` is provided:
**Does not give item when it is already in inventory of player**.
Player would recieve message that mentions item that wasn't given.

In the case **when there is no space for all items it would try to fit as many items as possible**.
Player would recieve message that mentions item that wasn't given.

**The chest must be loaded in game**.
Default warning when you try to use chest that is not loaded in game.

**Relative numbers for coordinates of chest (x y z) are not supported**.

# Installation
1. Unzip the archive
2. place it in minetest/mods/

(  GNU/Linux: If you use a system-wide installation place
	it in ~/.minetest/mods/.  )

(  If you only want this to be used in a single world, place
	the folder in worldmods/ in your worlddirectory.  )

For further information or help see:
https://wiki.minetest.net/Installing_Mods

# Reason for creating
Minetest already has give command that works in most cases but there are special cases, one of which is book.

You can give book, and written book, but how would you give a book with text already inside? Or a book with enchantement (from mineclone), or enchanted armor (from mineclone).

On one server there was a cool idea to use in game books to deliver information to players like server rules or news. The problem is that they had to be given automatically using command block, but refilled manually, and there was no way to control how many books a person takes.

This mod solves refil problem, the problem of controlling amount is much more complex and is solved only partially using `once` flag.

