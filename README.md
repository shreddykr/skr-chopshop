<h1>🛠️ skr-chopshop - Vehicle Selling Script for FiveM (QBCore) 🚗💰</h1>

📜 **Overview**

skr-chopshop is a FiveM script built for the QBCore framework, allowing players to sell stolen vehicles to a chopshop NPC. Players can approach an NPC and sell their stolen vehicle for a random cash payout. The vehicle is then deleted, and the player is rewarded with cash directly in their inventory. The payout ranges from $3,000 to $10,000, with rare higher payouts.

----------------------------------------------------------------------------------

📱 **Usage**

Approach the chopshop NPC with a stolen vehicle nearby.

Interact with the NPC using the ox_target interaction.

A random cash payout will be given, and the vehicle will be removed from the world.

---------------------------------------------------------------------------------

💡 **Features**

Vehicle Selling: Walk up to an NPC and sell stolen vehicles.

Random Cash Reward: Earn between $3,000 to $10,000 for each vehicle, with a low chance of a high payout.

Vehicle Deletion: Vehicles are deleted after the transaction.

Cash Reward: Rewards are given in cash via ox_inventory.

Prevents players from selling vehicles that other players or themselves own (anti-dupe / money exploit)

0.00ms ⚡

[Preview](https://streamable.com/q4dtfs)

----------------------------------------------------------------------------------


🔧 **Configuration**

You can adjust the NPC location through the script's config file.

To change the amounts the players get per vehicle go into the client and adjust the values at the bottom.


--------------------------------------------------------------------------------

⚙️ **Requirements**

[**QBCore Framework:** ](https://github.com/qbcore-framework/qb-core)
The base framework required.

[**ox_target:** ](https://github.com/overextended/ox_target)
For NPC interaction via the targeting system.

[**ox_inventory:** ](https://github.com/overextended/ox_inventory)
For inventory and item management.

[**oxmysql:** ](https://github.com/overextended/oxmysql)
For checking player owned vehicles.

---------------------------------------------------------------------------------

❓ **Why You Should Use This**

Enhances Roleplay: Adds a realistic way for players to dispose of stolen vehicles and earn money, enriching the roleplay experience.

Easy Integration: Works seamlessly with the QBCore framework and popular resources like ox_target and ox_inventory.

Dynamic Payouts: The random payout system keeps the experience exciting and unpredictable for players.

Vehicle Management: Automatically deletes stolen vehicles, keeping your server clean and preventing abandoned cars from cluttering the map.
