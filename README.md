<h1>🛠️ (QB) skr-chopshop - Advanced Vehicle Selling and Missions for FiveM 🚗💰</h1>

📜 **Overview**

   skr-chopshop is a FiveM script built for the QBCore framework, allowing players to sell stolen vehicles to a chopshop NPC. Players can approach an NPC and sell their stolen vehicle for a random cash payout. The vehicle is then deleted, and the player is rewarded with cash directly. The payout ranges    from $3,000 to $10,000, with rare higher payouts configurable in the config file.

----------------------------------------------------------------------------------

📱 **Usage**

**1. Sell Stolen Vehicles**
   
   Approach the chopshop NPC with a stolen vehicle nearby.

   Interact with the NPC using the **ox_target** or **qb-target** interaction system.

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

   Script automatically timesout if the mission isnt completed within 30 min.

   Sets random mission vehicle fuel between 30-100% full

   Performance Optimized: Script idles at 0.01ms under load 0.05⚡

   📽️[**Preview**](https://streamable.com/gkdoo5)

----------------------------------------------------------------------------------


🔧 [**Configuration**](https://github.com/shreddykr/skr-chopshop/blob/main/config.lua)

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


   [**oxmysql:** ](https://github.com/overextended/oxmysql)


--------------------------------------------------------------------------------

   [**ox_target:** ](https://github.com/overextended/ox_target)

      
   or
      
   [**qb-target:**](https://github.com/qbcore-framework/qb-target)

---------------------------------------------------------------------------------

   [**legacyfuel:**](https://github.com/InZidiuZ/LegacyFuel)

   or 

   [**cdn-fuel:**](https://github.com/CodineDev/cdn-fuel)

   or 

   [**lc_fuel:**](https://github.com/LeonardoSoares98/lc_fuel)
      

---------------------------------------------------------------------------------

🚀 **Installation Instructions**

   1. Download the [latest version](https://github.com/shreddykr/skr-chopshop/releases/tag/1.0.4)

   2.      ensure skr-chopshop(after all requirements)

   3.  Configure the config file

   4.  Done!

   5.  Consider rerouting qb notifications to ox_lib or read below for best UI.


--------------------------------------------------------------------------------

🔧 **Recommended Server Updates**
      For the best experience possible you will notice the notifications system being used is in fact qb notifications found in qb-smallresources under functions. To make this look better you can update that function to work with **ox_lib** since most servers
      use or have it. Personally you see me using okoknotify but rerouted in ox_lib so that if ox_lib calls for a notification it is instead okoknotify. I also have qb notifications routed to ox lib so that its easy to configure and update instead of 
      changing too much.

❓ **Why You Should Use This**

   Immersive Roleplay: Enhance the gameplay experience with realistic vehicle selling and retrieval mechanics.

   Seamless Integration: Works flawlessly with QBCore and popular tools like ox_target and ox_inventory.

   Engaging Gameplay: Missions and randomized payouts keep players entertained and motivated.

   Server Optimization: Automatically removes vehicles after transactions or deliveries, maintaining a clean and clutter-free game world.

----------------------------------------------------------------------------------------------------------------------------------

📂 **Recent Updates (v1.0.3 → v1.0.4)**

   -Added activemissions sequence for players to be able to do this simultaneously

   -Added multiple support for fueling scripts when the vehicle spawns

   -Added support for qb-target

   -Added config for sell prices

   -Interaction distance & Delivery radius config

   -Mission Timeout/Wait period for next mission/wait to sell time config

   -Fixed vehicle spawn heading

   -Cannot sell vehicles while currently in a mission can only end mission

   -Added delivery system to track progress of the mission

   -Mission overlap prevention

   -Mission start and end logic based on player

   -Vehicle Verification

   -Added debugging/monitoring

   -Combined client script into one

   -Fixed script sending too many notifications now its streamlined.

   -Fixed multiple exploits

