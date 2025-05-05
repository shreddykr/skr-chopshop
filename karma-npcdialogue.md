-- The script comes ready with the event to handle this all you need to do is open the config file and
-- replace niko bellics line with this one then you are done.

{
    name = "Tariq Vellon",
    text = "Hey gearhead! I've got a lead on some quality rides. I'm your go-to guy for the chopping scene, and there's a job that's perfect for a pro like you. High-quality wheels, no fuss, and a solid payday at the finish line. I've got the details covered - just go along with it. Keep it quiet, bypass those alarms, and let's score big without making too much noise.",
    domain = "Chop Shop",
    ped = "ig_djgeneric_01",
    scenario = "WORLD_HUMAN_SMOKING_POT",
    police = true,
    coords = vector4(-206.07, -1327.45, 29.9, 1.76),
    options = {
        {
            label = "I want to work",
            requiredrep = 0,
            type = "add",
            event = "",
            data = {
                text = "Ready for a day of hard work?",
                options = {
                    {
                        label = "Set Waypoint",
                        requiredrep = 0,
                        event = "skr-chopshop:client:AddChopBlip",
                        type = "client",
                        args = {
                            coords = vector3(476.4, -1315.28, 28.225),
                            label = "ChopShop"
                        }
                    },
                    {
                        label = "Leave conversation",
                        event = "",
                        type = "none",
                        args = {} 
                    },
                    
                }
            },
            args = {} 
            
        },
        {
            label = "Open Shop", 
            requiredrep = 0, --required rep to even open the shop
            type = "shop", 
            items = {
                {
                    name = "lockpick",
                    description = "Tools",
                    requiredrep = 0,
                    price = 5000
                },
                {
                    name = "advancedlockpick",
                    description = "Tools",
                    requiredrep = 0,
                    price = 20000
                },
            },
            event = "",
            args = {}
        },
        {
            label = "Leave conversation",
            requiredrep = 0,
            type = "none",
            args = {} 
        },
        
    }
},