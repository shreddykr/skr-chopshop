<h1>🛠️ skr-chopshop - Advanced Vehicle Selling and Missions for FiveM (QBCore) 🚗💰</h1>

📜 **Overview**

   skr-chopshop is a FiveM script built for the QBCore framework, allowing players to sell stolen vehicles to a chopshop NPC. Players can approach an NPC and sell their stolen vehicle for a random cash payout. The vehicle is then deleted, and the player is rewarded with cash directly in their inventory. The payout ranges    from $3,000 to $10,000, with rare higher payouts.

----------------------------------------------------------------------------------

📱 **Usage**

**1. Sell Stolen Vehicles**
   
   Approach the chopshop NPC with a stolen vehicle nearby.

   Interact with the NPC using the ox_target interaction system.

   Receive a random cash payout, and the vehicle will be removed from the game world.

**3. Participate in Chopshop Missions**
   
   Players can take on missions to locate and deliver specific vehicles to the chopshop for rewards.

   Missions are marked with blips on the map, guiding players to vehicle spawn locations.

   Successfully deliver the vehicle to earn a payout.


---------------------------------------------------------------------------------

💡 **Features**

   Chopshop Mission System: Retrieve specific vehicles from designated map locations and deliver them to the chopshop.

   Customizable Spawn Points: Easily update NPC and vehicle spawn locations to suit your server's gameplay style.

   Dynamic Cash Rewards: Randomized payouts between $3,000 to $10,000 per vehicle, with chances for high-value rewards.

   Anti-Exploit Mechanisms: Prevents players from exploiting the system by selling vehicles they own or duplicating cash.

   Inventory Integration: Rewards are seamlessly handled via ox_inventory.

   Performance Optimized: Script operates at 0.00ms ⚡

   [Preview](https://streamable.com/gkdoo5)

----------------------------------------------------------------------------------


🔧 **Configuration**

   Define the NPC model, location, and animations 

   Mission Parameters
   
   Adjust mission radius, cooldowns, and blip settings.

   Configure a comprehensive list of vehicle models available for missions.

   Customize spawn points for vehicle retrieval missions.

   Reward Settings

   Modify cash payout ranges in the client file | Being moved to config cfg in 1.0.4


--------------------------------------------------------------------------------

⚙️ **Requirements**

   [**QBCore Framework:** ](https://github.com/qbcore-framework/qb-core)
      The base framework required.

   [**ox_target:** ](https://github.com/overextended/ox_target)
      For NPC interaction via the targeting system.

   [**oxmysql:** ](https://github.com/overextended/oxmysql)
      For checking player owned vehicles.

---------------------------------------------------------------------------------

❓ **Why You Should Use This**

   Immersive Roleplay: Enhance the gameplay experience with realistic vehicle selling and retrieval mechanics.

   Seamless Integration: Works flawlessly with QBCore and popular tools like ox_target and ox_inventory.

   Engaging Gameplay: Missions and randomized payouts keep players entertained and motivated.

   Server Optimization: Automatically removes vehicles after transactions or deliveries, maintaining a clean and clutter-free game world.

----------------------------------------------------------------------------------------------------------------------------------

📂 **Recent Updates (v1.0.1 → v1.0.3)**

   Players can now retrieve and deliver vehicles to the chopshop for cash rewards.

   Expanded vehicle list for missions, including high-performance and classic cars.

   Over 50 detailed vehicle spawn locations added across various regions, including urban, rural, and industrial areas.

   Added a debug toggle in config.lua for easier script troubleshooting.

   Centralized configurations for easy customization.

   Optimized NPC and vehicle spawn logic for enhanced performance and stability.

   Improved anti-exploit mechanisms to ensure secure server operations.



