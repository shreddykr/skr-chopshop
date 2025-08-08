<h1>🛠️ (QB) SKR CHOPSHOP - Advanced Chopshop Missions for FiveM 🚗💰</h1>

📜 **Overview**

   **SKR CHOPSHOP**  is a FiveM script built for the QBCore framework, allowing players to start missions after finding a ped around the map. NPCs spawn with weapons configurable in the **config** lua and behave in a defensive manor towards the vehicles. In order to complete the mission take out anyone in the way of stealing the car and deliver the car to the same location the mission started.

----------------------------------------------------------------------------------

📱 **Usage**

**Participate in Chopshop Missions**
   
   Players can take on missions to locate and deliver specific vehicles to the chopshop for various rewards configurable to each mission.

   After selecting a mission the vehicle is marked with a gold blip and route on the map, guiding players to vehicle locations.

   Successfully collect and deliver the vehicle to earn a payout.


---------------------------------------------------------------------------------

💡 **Features**

   Chopshop Mission System: Retrieve specific vehicles from designated map locations and deliver them to the chopshop.

   Customizable Spawn Points: Easily update NPC and vehicle spawn locations to suit your server's gameplay style.

   Configurable payouts for each missions. Add as many missions as you would like in a few minutes.

   Anti-Exploit Mechanisms: Prevents players from leaving early to collect pay.

   Seamless payments with QB that go straight to the players bank account after each mission.

   Script automatically timesout if the mission isnt completed within 25 min.

   Sets the fuel between 30-70% to avoid running out of fuel during a mission.

   Script automatically ends if the player dies.

   Automatic version checking after every server start.

   Performance Optimized: Script idles at 0.01ms under load 0.05⚡
   
   📽️[**Preview**](https://www.youtube.com/watch?v=Og2wkxicbL4)
   
<img width="2008" height="712" alt="Screenshot 2025-08-07 185250" src="https://github.com/user-attachments/assets/09946c14-cc33-4b9a-b442-eb65d199f787" />
<img width="1528" height="671" alt="Screenshot 2025-08-07 185317" src="https://github.com/user-attachments/assets/97c501b4-f452-48e0-b39e-63c35bb3cac7" />

   
   
----------------------------------------------------------------------------------


🔧 [**Configuration**](https://github.com/shreddykr/skr-chopshop/blob/main/config.lua)

   Define the NPC model, locations, aggression, weapon model and accuracy.
   
   Adjust missions, and blip settings.

   Configure a comprehensive list of vehicle models and plate information available for missions.

   Configure each missions payout.


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

   optional [**sd_police**](https://github.com/Samuels-Development/sd-aipolice)

---------------------------------------------------------------------------------

🚀 **Installation Instructions**

   1. Download the [latest version](https://github.com/shreddykr/skr-chopshop/releases/tag/1.0.4)

   2.      ensure skr-chopshop(after all requirements)

   3.  Configure the config file

   4.  Done!

   5.  Consider rerouting qb notifications to ox_lib or read below for best UI.

   [Support](https://discord.com/invite/HfuctRgc4X)


--------------------------------------------------------------------------------

🔧 **Recommended Server Updates**
      For the best experience possible you will notice the notifications system being used is in fact qb notifications found in qb-smallresources under functions. To make this look better you can update that function to work with **ox_lib** since most servers
      use or have it. Personally you see me using okoknotify but rerouted in ox_lib so that if ox_lib calls for a notification it is instead okoknotify. I also have qb notifications routed to ox lib so that its easy to configure and update instead of 
      changing too much.

------------------------------------------------------------------------------------------

❓ **Why You Should Use This**

   Immersive Roleplay: Enhance the gameplay experience with realistic gun fights and robberys.

   Seamless Integration: Works flawlessly with QBCore and popular tools like ox_target.

   Engaging Gameplay: Mission variety keeps players entertained and motivated.

   Server Optimization: Automatically removes vehicles after transactions or deliveries, maintaining a clean and clutter-free game world.

----------------------------------------------------------------------------------------------------------------------------------

📂 **Recent Updates (v1.0.5 → v1.0.6)**

   - Removed ability to sell random cars
   - Added Advanced Missions with ability to add more in the config
   - 5 Handcrafted Missions
   - Optimized client and server script
   - Updated overlay text
   - Added support for sd_police for full immersion
   - Added ability to set configure NPCs for missions
   - Added version checking in server lua
   - QB Menu to select different missions

   -Combined client script into one

   -Fixed script sending too many notifications now its streamlined.

   -Fixed multiple exploits

