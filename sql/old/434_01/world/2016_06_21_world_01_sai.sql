-- 
-- Add missing Emote & Say lines for NPC entry 20098(Jane), 20100(Jessel) and 20244(Nova)
SET @Jane   := 20098;
SET @Jessel := 20100;
SET @Nova   := 20244;

-- Set random movement around a new set spawndist for Nova
UPDATE `creature` SET `position_x`= 10512.0615,`position_y`= -6499.652,`position_z`= 3.6119,`orientation`= 0.855017,`spawndist`= 8,`MovementType`= 1 WHERE `id`= @Nova;
UPDATE `creature` SET `position_x`= 10512.0615,`position_y`= -6499.652,`position_z`= 3.6119,`orientation`= 0.855017,`spawndist`= 8,`MovementType`= 1 WHERE `id`= 20246;
UPDATE `creature` SET `MovementType`=1, `spawndist`=8 WHERE `id` IN (20098,20247,20246);

DELETE FROM `creature_text` WHERE `entry`= @Jane   AND `groupid`= 1 AND `id`= 0;
DELETE FROM `creature_text` WHERE `entry`= @Jessel AND `groupid`= 2 AND `id`= 0;
DELETE FROM `creature_text` WHERE `entry`= @Nova   AND `groupid` IN (0,1) AND `id` IN (0,1,2,3);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@Jessel,2,0,'%s wakes up, startled.',                                 16,10,100,0,0,0,'Jessel'),
(@Jane,  1,0,'%s resumes playing on the beach.',                       16,10,100,0,0,0,'Jane'),
(@Nova,  1,0,'I think I can see the Sunwell from here!',               12,10,100,1,0,0,'Nova'),
(@Nova,  1,1,'Can you really hear the ocean from one of these shells?',12,10,100,1,0,0,'Nova'),
(@Nova,  1,2,'Oooh! Look, a shiny one!',                               12,10,100,1,0,0,'Nova'),
(@Nova,  1,3,'Jane will love this one!',                               12,10,100,1,0,0,'Nova'),
(@Nova,  0,0,'%s picks up a sea shell.',                               16,10,100,0,0,0,'Nova'),
(@Nova,  0,1,'%s holds a sea shell up to her ear.',                    16,10,100,0,0,0,'Nova'),
(@Nova,  0,2,'%s shakes the dirt loose from the shell.',               16,10,100,0,0,0,'Nova');

-- Add SmartAI script lines for Jane, Jessel and Nova
UPDATE `creature_template` SET `AIName`= 'SmartAI' WHERE `entry`= @Nova;
DELETE FROM `smart_scripts` WHERE `entryorguid`= @Jane   AND `source_type`= 0;
DELETE FROM `smart_scripts` WHERE `entryorguid`= @Jessel AND `source_type`= 0;
DELETE FROM `smart_scripts` WHERE `entryorguid`= @Jessel*100 AND `source_type`= 9;
DELETE FROM `smart_scripts` WHERE `entryorguid`= @Nova   AND `source_type`= 0 AND `id` IN (0,1);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@Nova,  0,0,0,1,0,100,0, 10000, 10000, 25000, 60000,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Nova - Out Of Combat - Say Line'),
(@Nova,  0,1,0,1,0,100,0, 11000, 11000, 25000, 60000,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Nova - Out Of Combat - Say Line'),
(20100, 0, 0, 0, 1, 0, 100, 0, 0, 0, 300000, 300000, 80, 2010000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Jessel - Ooc - Action list"),
(2010000, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 50917, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Jessel - Action list - Cast sleep aura"),
(2010000, 9, 1, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 28, 50917, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Jessel - Action list - rrmove sleep aura"),
(2010000, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Jessel - Action list - Say Line 2"),
(2010000, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 90, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Jessel - Action list - Set bytes 1"),
(2010000, 9, 4, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Jessel - Action list - Say Line 0"),
(2010000, 9, 5, 0, 0, 0, 100, 0, 9000, 9000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, @Jane, 50, 0, 0, 0, 0, 0, "Jessel - Action list - Say Line 0"),
(2010000, 9, 6, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Jessel - Action list - Say Line 1"),
(2010000, 9, 7, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, @Jane, 50, 0, 0, 0, 0, 0, "Jessel - Action list - Say Line 1"),
(2010000, 9, 8, 6, 0, 0, 100, 0, 3000, 3000, 0, 0, 91, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Jessel - Action list - remove bytes 1"),
(2010000, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 50917, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Jessel - Action list - Cast sleep");

-- Splinter Fist Warrior
SET @ENTRY := 212;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,4,0,20,1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Say Text on Aggro'),
(@ENTRY,0,1,0,0,0,100,0,6000,9000,17000,24000,11,78828,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Bladestorm');
-- NPC talk text insert
SET @ENTRY := 212;
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0, 'I\'ll crush you!',12,0,50,0,0,0, 'on Aggro Text'),
(@ENTRY,0,1, 'Me smash! You die!',12,0,50,0,0,0, 'on Aggro Text'),
(@ENTRY,0,2, 'Raaar!!! Me smash $r!',12,0,50,0,0,0, 'on Aggro Text');

-- Defias Night Runner SAI
SET @ENTRY := 215;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,11,0,100,1,0,0,0,0,11,22766,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Stealth on Spawn'),
(@ENTRY,0,1,0,7,0,100,1,0,0,0,0,11,22766,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Stealth on Evade'),
(@ENTRY,0,2,0,67,0,100,0,3900,6900,0,0,11,37685,0,0,0,0,0,2,0,0,0,0,0,0,0,'Casts Backstab'),
(@ENTRY,0,3,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,0,0,0,0,0,0,0,0,"Defias Night Runner - At 15% HP - Flee For Assist");

-- Kurzen Commando SAI
SET @ENTRY := 938;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,11,0,100,1,0,0,0,0,11,30831,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Stealth on Spawn'),
(@ENTRY,0,1,0,7,0,100,1,0,0,0,0,11,30831,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Stealth on Evade'),
(@ENTRY,0,2,0,67,0,100,0,3900,6900,0,0,11,37685,0,0,0,0,0,2,0,0,0,0,0,0,0,'Casts Backstab'),
(@ENTRY,0,3,0,2,0,100,1,0,15,0,0,11,7964,0,0,0,0,0,1,0,0,0,0,0,0,0,"Kurzen Commando - At 15% HP - Cast Smoke Bomb");

-- Dragonmaw Centurion
SET @ENTRY := 1036;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,5000,8000,12000,15000,11,78660,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Devastate'),
(@ENTRY,0,1,0,2,0,100,0,0,40,15000,17000,11,3419,2,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Improved Blocking at 40% HP'),
(@ENTRY,0,2,0,0,0,100,0,3000,9000,10000,20000,11,76622,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Sunder Armor');

-- Riverpaw Shaman
SET @ENTRY := 1065;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,0,0,3400,4700,11,9532,64,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Lightning Bolt'),
(@ENTRY,0,1,2,2,0,100,1,0,15,0,0,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Flee at 15% HP'),
(@ENTRY,0,2,0,61,0,100,1,0,15,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Say Text at 15% HP'),
(@ENTRY,0,3,0,1,0,100,0,500,1000,600000,600000,11,12550,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Lightning Shield on Spawn'),
(@ENTRY,0,4,0,16,0,100,0,12550,1,15000,30000,11,12550,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Lightning Shield on Repeat');
-- NPC talk text insert
SET @ENTRY := 1065;
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0, 'More bones to gnaw on...',12,0,50,0,0,0, 'on Aggro Text'),
(@ENTRY,0,1, 'Grrrr... fresh meat!',12,0,50,0,0,0, 'on Aggro Text'),
(@ENTRY,1,0, '%s attempts to run away in fear!',16,0,100,0,0,0, 'combat Flee');

-- Torn Fin Tidehunter
SET @ENTRY := 2377;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,2,0,100,1,0,15,0,0,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Flee at 15% HP');

-- Lieutenant Benedict SAI
SET @ENTRY := 3192;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,0,1000,1000,300000,300000,11,7164,0,0,0,0,0,1,0,0,0,0,0,0,0,"Lieutenant Benedict - Out Of Combat - Cast Defensive Stance"),
(@ENTRY,0,1,0,13,0,70,0,40000,40000,0,0,11,11972,0,0,0,0,0,2,0,0,0,0,0,0,0,"Lieutenant Benedict - On Target Casting - Cast Shield Bash"),
(@ENTRY,0,2,0,0,0,75,0,2000,7000,11000,25000,11,11972,0,0,0,0,0,2,0,0,0,0,0,0,0,"Lieutenant Benedict - In Combat - Cast Shield Bash"),
(@ENTRY,0,3,0,0,0,100,0,7000,12000,12000,34000,11,3248,0,0,0,0,0,2,0,0,0,0,0,0,0,"Lieutenant Benedict - In Combat - Cast Improved Blocking"),
(@ENTRY,0,4,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,0,0,0,0,0,0,0,0,"Lieutenant Benedict - At 15% HP - Flee For Assist");

-- Elder Mystic Razorsnout
SET @ENTRY := 3270;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,4000,5000,18000,22000,11,75068,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Lava Burst'),
(@ENTRY,0,1,0,0,0,100,0,3000,6000,15000,27000,11,39591,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Searing Totem');

-- Felmusk Felsworn
SET @ENTRY := 3762;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,0,0,3400,4700,11,32707,64,0,0,0,0,2,0,0,0,0,0,0,0,'Cast bolt'),
(@ENTRY,0,1,0,0,0,100,0,7000,8000,22000,26000,11,11962,2,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Immolate'),
(@ENTRY,0,2,0,0,0,100,0,10000,12000,600000,600000,11,6942,2,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Overwhelming Stench'),
(@ENTRY,0,3,0,2,0,100,1,0,30,0,0,11,8599,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Enrage at 30% HP'),
(@ENTRY,0,4,0,2,0,100,1,0,30,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Say Text at 30% HP');
-- NPC talk text insert
SET @ENTRY := 3762;
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0, '%s becomes enraged!',16,0,100,0,0,0, 'combat Enrage');

-- Stonevault Cave Lurker
SET @ENTRY := 4850;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,11,0,100,3,0,0,0,0,11,22766,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Sneak on Spawn'),
(@ENTRY,0,1,0,0,0,100,2,3000,4000,17000,18000,11,3583,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Deadly Poison');

-- Wastewander Rogue SAI
SET @ENTRY := 5615;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,11,0,100,1,0,0,0,0,11,30831,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Stealth on Spawn'),
(@ENTRY,0,1,0,7,0,100,1,0,0,0,0,11,30831,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Stealth on Evade'),
(@ENTRY,0,2,0,67,0,100,0,3900,6900,0,0,11,37685,0,0,0,0,0,2,0,0,0,0,0,0,0,'Casts Backstab');

-- Addled Leper SAI
SET @ENTRY := 6221;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,1,0,100,0,0,0,0,0,21,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Addled Leper - Out Of Combat - Allow Combat Movement"),
(@ENTRY,0,1,0,61,0,100,0,0,0,0,0,20,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Addled Leper - Out Of Combat - Start Auto Attack"),
(@ENTRY,0,2,0,1,0,100,1,1000,1000,0,0,11,7165,1,0,0,0,0,1,0,0,0,0,0,0,0,"Addled Leper - Out Of Combat - Cast Battle Stance"),
(@ENTRY,0,3,4,4,0,100,0,0,0,0,0,11,6660,0,0,0,0,0,2,0,0,0,0,0,0,0,"Addled Leper - On Aggro - Cast Shoot"),
(@ENTRY,0,4,0,61,0,100,0,0,0,0,0,23,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Addled Leper - On Aggro - Increment Phase"),
(@ENTRY,0,5,6,9,0,100,0,5,30,2300,3900,11,6660,0,0,0,0,0,2,0,0,0,0,0,0,0,"Addled Leper - At 5 - 30 Range - Cast Shoot"),
(@ENTRY,0,6,0,61,0,100,0,0,0,0,0,40,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Addled Leper - At 5 - 30 Range - Display ranged weapon"),
(@ENTRY,0,7,8,9,0,100,0,25,80,0,0,21,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Addled Leper - At 25 - 80 Range - Allow Combat Movement"),
(@ENTRY,0,8,0,61,0,100,0,0,0,0,0,20,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Addled Leper - At 25 - 80 Range - Start Auto Attack"),
(@ENTRY,0,9,10,9,0,100,0,0,5,0,0,21,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Addled Leper - At 0 - 5 Range - Allow Combat Movement"),
(@ENTRY,0,10,11,9,0,100,0,0,0,0,0,40,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Addled Leper - At 0 - 5 Range - Display melee weapon"),
(@ENTRY,0,11,0,61,0,100,0,0,0,0,0,20,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Addled Leper - At 0 - 5 Range - Start Auto Attack"),
(@ENTRY,0,12,13,9,0,100,0,5,15,0,0,21,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Addled Leper - At 5 - 15 Range - Allow Combat Movement"),
(@ENTRY,0,13,0,61,0,100,0,0,0,0,0,20,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Addled Leper - At 5 - 15 Range - Start Auto Attack"),
(@ENTRY,0,14,0,9,0,100,0,0,5,17000,23000,11,9080,1,0,0,0,0,2,0,0,0,0,0,0,0,"Addled Leper - At 0 - 5 Range - Cast Hamstring"),
(@ENTRY,0,15,0,0,0,100,0,7000,9000,13000,16000,11,25712,1,0,0,0,0,2,0,0,0,0,0,0,0,"Addled Leper - In Combat - Cast Heroic Strike"),
(@ENTRY,0,16,0,2,0,100,0,0,30,30000,45000,11,22883,1,0,0,0,0,1,0,0,0,0,0,0,0,"Addled Leper - At 30% HP - Cast Heal"),
(@ENTRY,0,17,0,2,0,100,1,0,15,0,0,23,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Addled Leper - At 15% HP - Increment Phase"),
(@ENTRY,0,18,19,2,0,100,0,0,15,0,0,21,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Addled Leper - At 15% HP - Allow Combat Movement"),
(@ENTRY,0,19,20,2,0,100,0,0,0,0,0,25,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"Addled Leper - At 15% HP - Flee For Assist"),
(@ENTRY,0,20,0,7,0,100,0,0,0,0,0,40,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Addled Leper - On Evade - Display melee weapon");

-- Dawnblade Reservist
SET @ENTRY := 25087;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,5000,7700,13500,17850,11,32915,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Raptor Strike');

-- Nightbane Shadow Weaver
SET @ENTRY := 533;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,0,0,3400,4700,11,77721,64,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Shadow Weave'),
(@ENTRY,0,10,0,2,1,100,1,0,45,0,0,11,85072,1,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Woven Shadows at 45% HP');

-- Murloc Minor Tidecaller
SET @ENTRY := 548;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,0,0,3400,4700,11,9672,64,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Frostbolt'),
(@ENTRY,0,1,0,2,0,100,1,0,15,0,0,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Flee at 15% HP');

-- Shadowhide Assassin
SET @ENTRY := 579;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,11,0,100,1,0,0,0,0,11,22766,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Sneak on Spawn'),
(@ENTRY,0,1,0,7,0,100,1,0,0,0,0,11,22766,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Sneak on Evade'),
(@ENTRY,0,2,0,0,0,100,0,5000,7000,15000,16000,11,744,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Poison');

-- Kurzen Medicine Man SAI
SET @ENTRY := 940;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,0,500,1000,600000,600000,11,12550,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Lightning Shield on Spawn'),
(@ENTRY,0,1,0,16,0,100,0,12550,1,15000,30000,11,12550,1,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Lightning Shield on Repeat'),
(@ENTRY,0,2,0,2,0,100,0,0,40,22000,25000,11,3359,2,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Drink Potion at 40% HP');

-- Lord Malathrom SAI
SET @ENTRY := 503;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,0,1000,5900,14200,11,30898,32,0,0,0,0,2,0,0,0,0,0,0,0,"Lord Malathrom - In Combat - Cast Shadow Word: Pain"),
(@ENTRY,0,1,0,0,0,100,0,5000,11000,22000,33000,11,3537,1,0,0,0,0,1,0,0,0,0,0,0,0,"Lord Malathrom - In Combat - Cast Minions of Malathrom");

-- Defias Squallshaper SAI
SET @ENTRY := 1732;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,2,1000,1000,1800000,1800000,11,12544,0,0,0,0,0,1,0,0,0,0,0,0,0,"Defias Squallshaper - Out Of Combat - Cast Frost Armor"),
(@ENTRY,0,1,0,0,0,30,2,1100,13600,23500,33500,11,122,0,0,0,0,0,1,0,0,0,0,0,0,0,"Defias Squallshaper - In Combat - Cast Frost Nova"),
(@ENTRY,0,3,0,2,0,100,3,0,15,0,0,25,1,0,0,0,0,0,0,0,0,0,0,0,0,0,"Defias Squallshaper - At 15% HP - Flee For Assist");

-- Hillsbrad Tailor SAI
SET @ENTRY := 2264;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,67,0,100,0,3900,6900,0,0,11,37685,0,0,0,0,0,2,0,0,0,0,0,0,0,'Casts Backstab'),
(@ENTRY,0,1,0,9,0,100,0,0,5,7000,11000,11,101,1,0,0,0,0,2,0,0,0,0,0,0,0,"Hillsbrad Tailor - At 0 - 5 Range - Cast Trip"),
(@ENTRY,0,2,0,2,0,100,1,0,30,0,0,25,1,0,0,0,0,0,0,0,0,0,0,0,0,0,"Hillsbrad Tailor - At 30% HP - Flee For Assist");

-- Foreman Bonds SAI
SET @ENTRY := 2305;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,11,0,100,1,0,0,0,0,11,8258,1,0,0,0,0,1,0,0,0,0,0,0,0,"Foreman Bonds - On Respawn - Cast Devotion Aura"),
(@ENTRY,0,1,0,9,0,100,0,0,5,60000,60000,11,39077,1,0,0,0,0,2,0,0,0,0,0,0,0,"Foreman Bonds - At 0 - 5 Range - Cast Hammer of Justice"),
(@ENTRY,0,2,3,2,0,100,0,0,30,0,0,12,7360,1,300000,0,0,0,2,0,0,0,0,0,0,0,"Foreman Bonds - At 30% HP - Summon Creature Dun Garok Soldier"),
(@ENTRY,0,3,0,61,0,100,0,0,0,0,0,12,7360,1,300000,0,0,0,2,0,0,0,0,0,0,0,"Foreman Bonds - At 30% HP - Summon Creature Dun Garok Soldier");

-- Ozzie Togglevolt SAI
SET @ENTRY := 1268;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,8,0,100,0,74222,0,0,0,1,2,2000,0,0,0,0,11,39712,10,0,0,0,0,0,"Ozzie Togglevolt - On spell hit - High Tinker Mekkatorque say part1"),
(@ENTRY,0,1,0,52,0,100,0,2,39712,0,0,1,3,4000,0,0,0,0,11,39712,10,0,0,0,0,0,"Ozzie Togglevolt - On text over - High Tinker Mekkatorque say part2"),
(@ENTRY,0,2,0,52,0,100,0,3,39712,0,0,1,4,4000,0,0,0,0,11,39712,10,0,0,0,0,0,"Ozzie Togglevolt - On text over - High Tinker Mekkatorque say part3"),
(@ENTRY,0,3,4,52,0,100,0,4,39712,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ozzie Togglevolt - On text over - Reply"),
(@ENTRY,0,5,0,61,0,100,0,0,0,0,0,45,1,1,0,0,0,0,11,39712,10,0,0,0,0,0,"Milli Featherwhistle - On link - set data 1");

-- Avarus Kharag SAI
SET @ENTRY := 1679;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,6000,8000,11000,15000,11,39077,0,0,0,0,0,2,0,0,0,0,0,0,0,"Avarus Kharag - In Combat - Cast Hammer of Justice"),
(@ENTRY,0,1,0,2,0,100,0,0,30,20000,30000,11,13952,1,0,0,0,0,1,0,0,0,0,0,0,0,"Avarus Kharag - At 30% HP - Cast Holy Light");

-- Taneel Darkwood SAI
SET @ENTRY := 3940;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,6800,8300,37900,46300,11,30898,0,0,0,0,0,2,0,0,0,0,0,0,0,"Taneel Darkwood - In Combat - Cast Shadow Word: Pain"),
(@ENTRY,0,1,0,2,0,100,0,0,90,15000,18000,11,8362,1,0,0,0,0,1,0,0,0,0,0,0,0,"Taneel Darkwood - At 90% HP - Cast Renew"),
(@ENTRY,0,2,0,2,0,100,0,0,20,20000,30000,11,22883,1,0,0,0,0,1,0,0,0,0,0,0,0,"Taneel Darkwood - At 20% HP - Cast Heal");

-- Scarlet Chaplain SAI
SET @ENTRY := 4299;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,4,0,100,3,0,0,0,0,11,48168,0,0,0,0,0,1,0,0,0,0,0,0,0,"Scarlet Chaplain - On Aggro - Cast Inner Fire"),
(@ENTRY,0,1,0,0,0,100,2,12000,16000,40000,46000,11,11974,1,0,0,0,0,1,0,0,0,0,0,0,0,"Scarlet Chaplain - In Combat - Cast Power Word: Shield"),
(@ENTRY,0,2,0,2,0,100,3,0,50,0,0,11,8362,1,0,0,0,0,1,0,0,0,0,0,0,0,"Scarlet Chaplain - At 50% HP - Cast Renew"),
(@ENTRY,0,3,0,2,0,100,3,0,15,0,0,25,1,0,0,0,0,0,0,0,0,0,0,0,0,0,"Scarlet Chaplain - At 15% HP - Flee For Assist");

-- Shadowforge Relic Hunter
SET @ENTRY := 4847;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,2,6000,10000,9000,12000,11,6726,0,0,0,0,0,5,0,0,0,0,0,0,0,'Cast Silence');

-- Stonevault Oracle
SET @ENTRY := 4852;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,2,6000,15000,31000,36000,11,5605,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Healing Ward'),
(@ENTRY,0,1,0,0,0,100,2,3000,5000,19000,27000,11,8264,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Lava Spout Totem');

-- Wastewander Bandit SAI
SET @ENTRY := 5618;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,4000,8000,7000,12000,11,12540,0,0,0,0,0,2,0,0,0,0,0,0,0,"Wastewander Bandit - In Combat - Cast Gouge"),
(@ENTRY,0,1,0,67,0,100,0,3900,6900,0,0,11,37685,0,0,0,0,0,2,0,0,0,0,0,0,0,'Casts Backstab');

-- Dalin Forgewright SAI
SET @ENTRY := 5682;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,2,0,100,0,0,90,15000,18000,11,8362,1,0,0,0,0,1,0,0,0,0,0,0,0,"Taneel Darkwood - At 90% HP - Cast Renew"),
(@ENTRY,0,2,0,2,0,100,0,0,20,20000,30000,11,22883,1,0,0,0,0,1,0,0,0,0,0,0,0,"Taneel Darkwood - At 20% HP - Cast Heal");

-- Commander Springvale
SET @ENTRY := 4278;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,4,0,100,7,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Say Text on Aggro'),
(@ENTRY,0,1,0,0,0,100,6,12000,12000,27000,27000,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Say Text on Battle'),
(@ENTRY,0,2,0,0,0,100,6,2000,4500,12000,20000,11,93685,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Malefic Strike'),
(@ENTRY,0,3,0,0,0,100,6,6000,9000,22000,28000,11,93687,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Desecration'),
(@ENTRY,0,4,0,0,0,100,2,10000,15000,35000,39000,11,93693,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Shield of the Perfidious'),
(@ENTRY,0,5,0,0,0,100,4,10000,15000,35000,39000,11,93736,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Shield of the Perfidious'),
(@ENTRY,0,6,0,0,0,100,2,4000,7000,18000,29000,11,93686,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Unholy Power'),
(@ENTRY,0,7,0,0,0,100,4,4000,7000,18000,29000,11,93735,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Unholy Power'),
(@ENTRY,0,8,0,2,0,100,5,0,30,0,0,11,96272,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Separation Anxiety at 30% HP'),
(@ENTRY,0,9,0,6,0,100,7,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Say Text on Death');
-- NPC talk text insert
SET @ENTRY := 4278;
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0, 'Intruders in the keep!To arms!',14,0,100,0,0,0, 'on Aggro Text'),
(@ENTRY,1,0, 'Repel the intruders!',14,0,100,0,0,0, 'on Battle Text'),
(@ENTRY,2,0, 'Our vigilance is eternal...',14,0,100,0,0,0, 'on Death Text');

-- Uthil Mooncall
SET @ENTRY := 3941;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,4,0,100,1,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Set Phase 1 on Aggro'),
(@ENTRY,0,1,0,4,1,100,1,0,0,0,0,11,7090,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Bear Form on Aggro'),
(@ENTRY,0,2,0,0,1,100,0,2000,4500,12000,15000,11,12161,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Maul');

-- Cenarion Protector
SET @ENTRY := 3797;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,0,500,1000,300000,300000,11,7090,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Bear Form on Spawn'),
(@ENTRY,0,1,0,0,0,100,0,9000,20000,19000,24000,11,15727,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Demoralizing Roar'),
(@ENTRY,0,2,3,2,0,100,0,0,50,14000,21000,28,7090,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Remove Bear Form at 50% HP'),
(@ENTRY,0,3,0,61,0,100,0,0,0,0,0,11,12160,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Rejuvenation at 50% HP'),
(@ENTRY,0,4,0,3,0,100,0,60,100,100,100,11,7090,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Bear Form HP is above 50%');

-- Scarlet Adept
SET @ENTRY := 4296;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,2,0,0,3400,4700,11,20820,64,0,0,0,0,2,0,0,0,0,0,0,0,'Cast bolt'),
(@ENTRY,0,1,2,2,0,100,3,0,15,0,0,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Flee at 15% HP'),
(@ENTRY,0,2,0,61,0,100,3,0,15,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Say Text at 15% HP'),
(@ENTRY,0,3,0,14,0,100,2,1450,40,14000,21000,11,11642,0,0,0,0,0,7,0,0,0,0,0,0,0,'Cast Heal on Friendlies');
-- NPC talk text insert
SET @ENTRY := 4296;
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0, '%s attempts to run away in fear!',16,0,100,0,0,0, 'combat Flee');

-- Scarlet Wizard
SET @ENTRY := 4300;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,2,4000,9000,16000,17000,11,32749,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Fire Shield'),
(@ENTRY,0,1,0,9,0,100,2,0,8,1200,15000,11,34517,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Arcane Explosion on Close');

-- Nethergarde Cleric SAI
SET @ENTRY := 6000;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,4000,6000,6000,9000,11,9734,0,0,0,0,0,2,0,0,0,0,0,0,0,"Nethergarde Cleric - In Combat - Cast Holy Smite"),
(@ENTRY,0,1,0,2,0,100,0,0,50,45000,60000,11,11974,1,0,0,0,0,1,0,0,0,0,0,0,0,"Nethergarde Cleric - At 50% HP - Cast Power Word: Shield"),
(@ENTRY,0,2,0,14,0,100,0,0,40,16000,21000,11,22883,1,0,0,0,0,7,0,0,0,0,0,0,0,"Nethergarde Cleric - On Friendly Unit At 0 - 40% Health - Cast Heal"),
(@ENTRY,0,3,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,0,0,0,0,0,0,0,0,"Nethergarde Cleric - At 15% HP - Flee For Assist");

-- Commander Malor
SET @ENTRY := 11032;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,9,0,100,2,0,5,7000,11000,11,16172,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Head Crack on Close'),
(@ENTRY,0,1,0,9,0,100,2,0,8,9000,14000,11,12734,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Ground Smash on Close'),
(@ENTRY,0,2,0,0,0,100,2,5000,5000,15000,19000,11,15245,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Shadow Bolt Volley');

-- Milli Featherwhistle SAI
SET @ENTRY := 7955;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,8,0,100,0,74222,0,0,0,1,0,2000,0,0,0,0,11,39712,10,0,0,0,0,0,"Milli Featherwhistle - On spell hit - High Tinker Mekkatorque say part1"),
(@ENTRY,0,1,0,52,0,100,0,0,39712,0,0,1,1,4000,0,0,0,0,11,39712,10,0,0,0,0,0,"Milli Featherwhistle - On text over - High Tinker Mekkatorque say part2"),
(@ENTRY,0,2,3,52,0,100,0,1,39712,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Milli Featherwhistle - On text over - Reply"),
(@ENTRY,0,4,0,61,0,100,0,0,0,0,0,45,1,1,0,0,0,0,11,39712,10,0,0,0,0,0,"Milli Featherwhistle - On link - set data 1");

-- Tog Rustsprocket SAI
SET @ENTRY := 6119;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,8,0,100,0,74222,0,0,0,1,5,2000,0,0,0,0,11,39712,10,0,0,0,0,0,"Tog Rustsprocket - On spell hit - High Tinker Mekkatorque say part1"),
(@ENTRY,0,1,0,52,0,100,0,5,39712,0,0,1,6,4000,0,0,0,0,11,39712,10,0,0,0,0,0,"Tog Rustsprocket - On text over - High Tinker Mekkatorque say part2"),
(@ENTRY,0,2,0,52,0,100,0,6,39712,0,0,1,7,4000,0,0,0,0,11,39712,10,0,0,0,0,0,"Tog Rustsprocket - On text over - High Tinker Mekkatorque say part3"),
(@ENTRY,0,3,4,52,0,100,0,7,39712,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Tog Rustsprocket - On text over - Reply"),
(@ENTRY,0,5,0,61,0,100,0,0,0,0,0,45,1,1,0,0,0,0,11,39712,10,0,0,0,0,0,"Tog Rustsprocket - On link - set data 1");

-- Geolord Mottle
SET @ENTRY := 5826;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,5000,6000,16000,18000,11,80117,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Earth Spike'),
(@ENTRY,0,1,0,1,0,100,0,500,1000,600000,600000,11,79927,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Earth Shield on Spawn');

-- Hukku's Succubus SAI
SET @ENTRY := 8657;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,9,0,100,2,0,5,12000,19500,11,21987,0,0,0,0,0,2,0,0,0,0,0,0,0,"Hukku's Succubus - At 0 - 5 Range - Cast Lash of Pain"),
(@ENTRY,0,1,0,0,0,100,2,8000,12000,15000,19000,11,6358,1,0,0,0,0,6,0,0,0,0,0,0,0,"Hukku's Succubus - In Combat - Cast Seduction");

-- Dragonflayer Vrykul
SET @ENTRY := 23652;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,0,0,2300,3900,11,38557,64,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Throw'),
(@ENTRY,0,1,0,9,0,100,0,0,5,8000,9000,11,43410,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Chop on Close');

-- Stonevault Flameweaver
SET @ENTRY := 7321;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,2,9000,21000,12000,32000,11,7739,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Inferno Shell');

-- Jekyll Flandring SAI
SET @ENTRY := 13219;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,80,0,1000,1000,7000,7000,11,25710,1,0,0,0,0,2,0,0,0,0,0,0,0,"Jekyll Flandring - In Combat - Cast Heroic Strike");

-- Risen Battle Mage
SET @ENTRY := 10425;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,2,8000,15000,13000,17000,11,17145,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Blast Wave'),
(@ENTRY,0,1,0,9,0,100,2,0,8,9000,14000,11,33860,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Arcane Explosion on Close'),
(@ENTRY,0,2,0,0,0,100,2,5000,5000,17000,22000,11,15732,0,0,0,0,0,5,0,0,0,0,0,0,0,'Cast Immolate');

-- Hakkari Bloodkeeper SAI
SET @ENTRY := 8438;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,11,0,100,3,0,0,0,0,11,7741,0,0,0,0,0,1,0,0,0,0,0,0,0,"Hakkari Bloodkeeper - On Respawn - Cast Summoned Demon"),
(@ENTRY,0,1,0,9,0,100,2,0,40,5000,8000,11,12471,1,0,0,0,0,1,0,0,0,0,0,0,0,"Hakkari Bloodkeeper - At 0 - 40 Range - Cast Shadow Bolt"),
(@ENTRY,0,2,0,0,0,100,2,13000,17000,14000,20000,11,39212,33,0,0,0,0,5,0,0,0,0,0,0,0,"Hakkari Bloodkeeper - In Combat - Cast Corruption");

-- Gnomeregan Evacuee SAI
SET @ENTRY := 7843;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,1,0,100,0,0,0,0,0,21,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gnomeregan Evacuee - Out Of Combat - Allow Combat Movement"),
(@ENTRY,0,1,0,61,0,100,0,0,0,0,0,20,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gnomeregan Evacuee - Out Of Combat - Start Auto Attack"),
(@ENTRY,0,2,0,1,0,100,1,1000,1000,0,0,11,7165,1,0,0,0,0,1,0,0,0,0,0,0,0,"Gnomeregan Evacuee - Out Of Combat - Cast Battle Stance"),
(@ENTRY,0,3,4,4,0,100,0,0,0,0,0,11,6660,0,0,0,0,0,2,0,0,0,0,0,0,0,"Gnomeregan Evacuee - On Aggro - Cast Shoot"),
(@ENTRY,0,4,0,61,0,100,0,0,0,0,0,23,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gnomeregan Evacuee - On Aggro - Increment Phase"),
(@ENTRY,0,5,6,9,0,100,0,5,30,2300,3900,11,6660,0,0,0,0,0,2,0,0,0,0,0,0,0,"Gnomeregan Evacuee - At 5 - 30 Range - Cast Shoot"),
(@ENTRY,0,6,0,61,0,100,0,0,0,0,0,40,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gnomeregan Evacuee - At 5 - 30 Range - Display ranged weapon"),
(@ENTRY,0,7,8,9,0,100,0,25,80,0,0,21,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gnomeregan Evacuee - At 25 - 80 Range - Allow Combat Movement"),
(@ENTRY,0,8,0,61,0,100,0,0,0,0,0,20,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gnomeregan Evacuee - At 25 - 80 Range - Start Auto Attack"),
(@ENTRY,0,9,10,9,0,100,0,0,5,0,0,21,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gnomeregan Evacuee - At 0 - 5 Range - Allow Combat Movement"),
(@ENTRY,0,10,11,9,0,100,0,0,0,0,0,40,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gnomeregan Evacuee - At 0 - 5 Range - Display melee weapon"),
(@ENTRY,0,11,0,61,0,100,0,0,0,0,0,20,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gnomeregan Evacuee - At 0 - 5 Range - Start Auto Attack"),
(@ENTRY,0,12,13,9,0,100,0,5,15,0,0,21,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gnomeregan Evacuee - At 5 - 15 Range - Allow Combat Movement"),
(@ENTRY,0,13,0,61,0,100,0,0,0,0,0,20,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gnomeregan Evacuee - At 5 - 15 Range - Start Auto Attack"),
(@ENTRY,0,14,0,9,0,100,0,0,5,17000,23000,11,9080,1,0,0,0,0,2,0,0,0,0,0,0,0,"Gnomeregan Evacuee - At 0 - 5 Range - Cast Hamstring"),
(@ENTRY,0,15,0,0,0,100,0,7000,9000,13000,16000,11,25712,1,0,0,0,0,2,0,0,0,0,0,0,0,"Gnomeregan Evacuee - In Combat - Cast Heroic Strike"),
(@ENTRY,0,16,0,2,0,100,0,0,30,30000,45000,11,22883,1,0,0,0,0,1,0,0,0,0,0,0,0,"Gnomeregan Evacuee - At 30% HP - Cast Heal"),
(@ENTRY,0,17,0,2,0,100,1,0,15,0,0,23,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gnomeregan Evacuee - At 15% HP - Increment Phase"),
(@ENTRY,0,18,19,2,0,100,0,0,15,0,0,21,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gnomeregan Evacuee - At 15% HP - Allow Combat Movement"),
(@ENTRY,0,19,0,61,0,100,0,0,0,0,0,25,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"Gnomeregan Evacuee - At 15% HP - Flee For Assist"),
(@ENTRY,0,20,0,7,0,100,0,0,0,0,0,40,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Addled Leper - On Evade - Display melee weapon");

-- Defias Trapper SAI
SET @ENTRY := 504;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,4,0,5,1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Defias Trapper - On Aggro - Say random text"),
(@ENTRY,0,1,0,67,0,100,0,3900,6900,0,0,11,37685,0,0,0,0,0,2,0,0,0,0,0,0,0,'Casts Backstab'),
(@ENTRY,0,2,0,0,0,100,0,6500,14200,20500,31100,11,12024,0,0,0,0,0,2,0,0,0,0,0,0,0,"Defias Trapper - Combat - Cast Net"),
(@ENTRY,0,3,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Defias Trapper - HP@15% - Flee");

-- Murloc Oracle
SET @ENTRY := 517;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,0,0,3400,4700,11,9734,64,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Holy Smite'),
(@ENTRY,0,1,2,2,0,100,1,0,15,0,0,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Flee at 15% HP'),
(@ENTRY,0,2,0,61,0,100,1,0,15,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Say Text at 15% HP'),
(@ENTRY,0,3,0,2,1,100,1,0,30,0,0,11,11835,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Power Word: Shield at 30% HP');
-- NPC talk text insert
SET @ENTRY := 517;
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0, '%s attempts to run away in fear!',16,0,100,0,0,0, 'combat Flee');

-- Canyon Ettin
SET @ENTRY := 43094;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,8000,8000,18000,22000,11,88421,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Log Smash');

-- Fenros
SET @ENTRY := 507;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,4,0,100,1,0,0,0,0,11,7137,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Shadow Charge on Aggro'),
(@ENTRY,0,1,0,0,0,100,0,2000,3000,9000,12000,11,6595,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Exploit Weakness'),
(@ENTRY,0,2,0,0,0,100,0,6000,9000,19000,22000,11,84308,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Furious Howl');

-- Murloc Tidecaller
SET @ENTRY := 545;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,2,0,100,1,0,15,0,0,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Flee at 15% HP');

-- Shadowhide Warrior
SET @ENTRY := 568;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,4,0,100,1,0,0,0,0,11,7164,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Defensive Stance on Aggro'),
(@ENTRY,0,1,0,0,0,100,0,5000,8000,15000,15000,11,11971,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Sunder Armor');

-- Defias Night Blade SAI
SET @ENTRY := 909;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,2000,18500,2000,18500,11,744,32,0,0,0,0,2,0,0,0,0,0,0,0,"Defias Night Blade - In Combat - Cast Poison"),
(@ENTRY,0,1,0,0,0,100,0,3200,15100,11700,44100,11,7992,0,0,0,0,0,2,0,0,0,0,0,0,0,"Defias Night Blade - In Combat - Cast Slowing Poison"),
(@ENTRY,0,2,0,67,0,100,0,3900,6900,0,0,11,37685,0,0,0,0,0,2,0,0,0,0,0,0,0,'Casts Backstab'),
(@ENTRY,0,3,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,0,0,0,0,0,0,0,0,"Defias Night Blade - At 15% HP - Flee For Assist");

-- Skeletal Healer SAI
SET @ENTRY := 787;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,1,0,0,0,0,21,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Skeletal Healer - Out Of Combat - Allow Combat Movement"),
(@ENTRY,0,1,2,4,0,100,0,0,0,0,0,11,9613,0,0,0,0,0,2,0,0,0,0,0,0,0,"Skeletal Healer - On Aggro - Cast Shadow Bolt"),
(@ENTRY,0,2,0,61,0,100,0,0,0,0,0,23,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Skeletal Healer - On Aggro - Increment Phase"),
(@ENTRY,0,3,0,9,0,100,0,0,40,3500,3700,11,9613,0,0,0,0,0,2,0,0,0,0,0,0,0,"Skeletal Healer - At 0 - 40 Range - Cast Shadow Bolt"),
(@ENTRY,0,4,5,3,0,100,0,0,15,0,0,21,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Skeletal Healer - At 15% Mana - Allow Combat Movement"),
(@ENTRY,0,5,0,61,0,100,0,0,0,0,0,23,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Skeletal Healer - At 15% Mana - Increment Phase"),
(@ENTRY,0,6,0,9,0,100,1,35,80,0,0,21,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Skeletal Healer - At 35 - 80 Range - Allow Combat Movement"),
(@ENTRY,0,7,0,9,0,100,1,5,15,0,0,21,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Skeletal Healer - At 5 - 15 Range - Allow Combat Movement"),
(@ENTRY,0,8,0,9,0,100,1,0,5,0,0,21,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Skeletal Healer - At 0 - 5 Range - Allow Combat Movement"),
(@ENTRY,0,9,0,3,0,100,0,30,100,100,100,23,0,1,0,0,0,0,1,0,0,0,0,0,0,0,"Skeletal Healer - At 100% Mana - Increment Phase"),
(@ENTRY,0,10,0,14,0,100,1,0,40,0,0,11,22883,1,0,0,0,0,7,0,0,0,0,0,0,0,"Skeletal Healer - On Friendly Unit At 0 - 40% Health - Cast Heal");

-- Bluegill Muckdweller SAI
SET @ENTRY := 1028;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,90,0,1100,6300,11100,14500,11,12540,0,0,0,0,0,2,0,0,0,0,0,0,0,"Bluegill Muckdweller - In Combat - Cast Gouge"),
(@ENTRY,0,1,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,0,0,0,0,0,0,0,0,"Bluegill Muckdweller - At 15% HP - Flee For Assist");

-- Stromgarde Troll Hunter SAI
SET @ENTRY := 2583;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,0,2000,5000,19000,23000,11,30898,0,0,0,0,0,2,0,0,0,0,0,0,0,"Stromgarde Troll Hunter - Out Of Combat - Cast Shadow Word: Pain"),
(@ENTRY,0,1,0,2,0,100,0,0,50,12000,18000,11,17137,1,0,0,0,0,1,0,0,0,0,0,0,0,"Stromgarde Troll Hunter - At 50% HP - Cast Flash Heal");

-- Kinelory SAI
SET @ENTRY := 2713;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,1000,3000,30000,38000,11,4948,0,0,0,0,0,1,0,0,0,0,0,0,0,"Kinelory - In Combat - Cast Kinelory's Bear Form"),
(@ENTRY,0,1,0,14,0,100,1,0,40,0,0,11,15981,1,0,0,0,0,7,0,0,0,0,0,0,0,"Kinelory - On Friendly Unit At 0 - 40% Health - Cast Rejuvenation");

-- Shadowforge Chanter
SET @ENTRY := 2742;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,5000,8000,17000,21000,11,15970,0,0,0,0,0,4,0,0,0,0,0,0,0,'Cast Sleep');

-- Cresting Exile SAI
SET @ENTRY := 2761;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,1,1000,1000,1800000,1800000,11,12544,0,0,0,0,0,1,0,0,0,0,0,0,0,"Cresting Exile - Out Of Combat - Cast Frost Armor"),
(@ENTRY,0,1,0,0,0,100,0,1400,7300,25600,32300,11,12674,0,0,0,0,0,2,0,0,0,0,0,0,0,"Cresting Exile - In Combat - Cast Frost Nova");

-- Drywhisker Digger
SET @ENTRY := 2574;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,5000,8000,12000,15000,11,82617,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Heave');

-- Witherbark Shadow Hunter
SET @ENTRY := 2557;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,5000,6000,19000,27000,11,6726,0,0,0,0,0,4,0,0,0,0,0,0,0,'Cast Silence');

-- Stonesplinter Shaman
SET @ENTRY := 1197;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,0,0,3400,4700,11,9739,64,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Wrath'),
(@ENTRY,0,1,0,0,0,100,0,9000,12000,22000,22000,11,84857,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Stone Splinter'),
(@ENTRY,0,2,0,1,0,100,0,500,1000,600000,600000,11,79927,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Earth Shield on Spawn'),
(@ENTRY,0,3,0,16,0,100,0,79927,1,15000,30000,11,79927,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Earth Shield on Repeat');

-- Daggerspine Siren
SET @ENTRY := 2371;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,0,0,3400,4700,11,9532,64,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Lightning Bolt'),
(@ENTRY,0,1,0,2,0,100,1,0,15,0,0,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Flee at 15% HP'),
(@ENTRY,0,2,0,0,0,100,0,5000,10000,15000,20000,11,6728,0,0,0,0,0,4,0,0,0,0,0,0,0,'Cast Enveloping Winds');

-- Gnarlpine Shaman
SET @ENTRY := 2009;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,2,0,100,1,0,15,0,0,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Flee at 15% HP'),
(@ENTRY,0,1,0,2,0,100,1,0,15,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Say Text at 15% HP');
-- NPC talk text insert
SET @ENTRY := 2009;
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0, '%s attempts to run away in fear!',16,0,100,0,0,0, 'combat Flee');

-- Hillsbrad Miner 
SET @ENTRY := 2269;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,1000,1000,180000,180000,11,7164,1,0,0,0,0,1,0,0,0,0,0,0,0,"Hillsbrad Miner - In Combat - Cast 'Defensive Stance'"),
(@ENTRY,0,2,0,2,0,100,1,0,30,0,0,25,1,0,0,0,0,0,0,0,0,0,0,0,0,0,"Hillsbrad Miner - Between 0-30% Health - Flee For Assist");

-- Master Digger
SET @ENTRY := 1424;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,2,0,100,1,0,15,0,0,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Flee at 15% HP'),
(@ENTRY,0,1,0,2,0,100,1,0,15,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Say Text at 15% HP'),
(@ENTRY,0,2,0,0,0,100,0,6000,12000,27000,33000,11,80382,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Dirt Toss'),
(@ENTRY,0,3,0,0,0,100,0,4000,7000,18000,27000,11,6016,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Pierce Armor');
-- NPC talk text insert
SET @ENTRY := 1424;
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0, '%s attempts to run away in fear!',16,0,100,0,0,0, 'combat Flee');

-- Bluegill Oracle SAI
SET @ENTRY := 1029;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,2,0,100,1,0,60,0,0,11,6274,0,0,0,0,0,1,0,0,0,0,0,0,0,"Bluegill Oracle - At 60% HP - Cast Healing Ward"),
(@ENTRY,0,1,0,14,0,100,0,0,30,11500,24600,11,11895,1,0,0,0,0,1,0,0,0,0,0,0,0,"Bluegill Oracle - On Friendly Unit At 0 - 30% Health - Cast Healing Wave"),
(@ENTRY,0,2,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,0,0,0,0,0,0,0,0,"Bluegill Oracle - At 15% HP - Flee For Assist");

-- Kurzen Witch Doctor SAI
SET @ENTRY := 942;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,1000,3000,40000,45000,11,39591,0,0,0,0,0,1,0,0,0,0,0,0,0,"Kurzen Witch Doctor - In Combat - Cast Searing Totem"),
(@ENTRY,0,1,0,0,0,100,0,4000,8000,15000,20000,11,370,0,0,0,0,0,2,0,0,0,0,0,0,0,"Kurzen Witch Doctor - In Combat - Cast Purge"),
(@ENTRY,0,2,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,0,0,0,0,0,0,0,0,"Kurzen Witch Doctor - At 15% HP - Flee For Assist");

-- Elder Timberling
SET @ENTRY := 2030;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,0,500,1000,600000,600000,11,324,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Lightning Shield on Spawn'),
(@ENTRY,0,1,0,16,0,100,0,324,1,15000,30000,11,324,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Lightning Shield on Repeat');

-- Blackwind Warp Chaser SAI
SET @ENTRY := 23219;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,25,0,100,1,0,530,0,0,11,32942,2,0,0,0,0,1,0,0,0,0,0,0,0,"Blackwind Warp Chaser - Respawn - Cast Phasing Invisibility"),
(@ENTRY,0,2,0,4,0,100,0,0,0,0,0,28,32942,0,0,0,0,0,1,0,0,0,0,0,0,0,"Blackwind Warp Chaser - Aggro - Remove Phasing Invisibility"),
(@ENTRY,0,3,0,0,0,100,0,3000,6000,4000,7000,11,32739,0,0,0,0,0,5,0,0,0,0,0,0,0,"Blackwind Warp Chaser - Combat - Cast Venomous Bite"),
(@ENTRY,0,4,0,0,0,100,0,12000,15000,20000,40000,11,32920,0,0,0,0,0,2,0,0,0,0,0,0,0,"Blackwind Warp Chaser - Combat - Cast Warp"),
(@ENTRY,0,5,0,4,0,100,0,2000,5000,7000,15000,11,37417,1,0,0,0,0,5,0,0,0,0,0,0,0,"Blackwind Warp Chaser - Aggro - Cast Warp Charge");

-- Chill Nymph SAI
SET @ENTRY := 23678;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,11,0,100,0,0,571,495,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Chill Nymph - Respawn - reset faction"),
(@ENTRY,0,1,0,25,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Chill Nymph - Reset - set phase 1"),
(@ENTRY,0,2,3,2,0,100,1,0,30,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Chill Nymph - On health 30% - Do text emote"),
(@ENTRY,0,3,0,61,0,100,0,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Chill Nymph - On health 30% - set phase 2"),
(@ENTRY,0,4,0,0,0,75,0,2000,3000,2000,2000,11,9739,0,0,0,0,0,2,0,0,0,0,0,0,0,"Chill Nymph - In Combat - Cast Wrath on victim"),
(@ENTRY,0,5,6,8,2,100,0,43340,0,30000,30000,66,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Chill Nymph - On Spell hit 43340 - Face invoker"),
(@ENTRY,0,7,0,61,0,100,0,0,0,0,0,80,@ENTRY*100+00,2,0,0,0,0,1,0,0,0,0,0,0,0,"Chill Nymph - On Spell hit 43340 - Load script"),
(@ENTRY,0,8,0,40,0,100,0,1,23678,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Chill Nymph - On reach waypoint 1 - Despawn");

-- Saltspittle Warrior SAI
SET @ENTRY := 3739;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,1000,3000,180000,180000,11,7164,1,0,0,0,0,1,0,0,0,0,0,0,0,"Saltspittle Warrior - In Combat - Cast Defensive Stance"),
(@ENTRY,0,1,0,9,0,100,0,0,5,12300,18600,11,7386,0,0,0,0,0,2,0,0,0,0,0,0,0,"Saltspittle Warrior - At 0 - 5 Range - Cast Sunder Armor"),
(@ENTRY,0,2,0,13,0,100,0,12000,15000,0,0,11,101817,1,0,0,0,0,7,0,0,0,0,0,0,0,"Saltspittle Warrior - On Target Casting - Cast Shield Bash"),
(@ENTRY,0,3,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,0,0,0,0,0,0,0,0,"Saltspittle Warrior - At 15% HP - Flee For Assist");

-- Foulweald Totemic
SET @ENTRY := 3750;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,2,0,100,1,0,15,0,0,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Flee at 15% HP'),
(@ENTRY,0,1,0,2,0,100,1,0,15,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Say Text at 15% HP'),
(@ENTRY,0,2,0,9,0,100,0,0,8,18000,21000,11,6817,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Corrupted Agility on Close'),
(@ENTRY,0,3,0,0,0,100,0,5000,7000,24000,26000,11,39591,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Searing Totem');
-- NPC talk text insert
SET @ENTRY := 3750;
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0, '%s attempts to run away in fear!',16,0,100,0,0,0, 'combat Flee');

-- Xavian Betrayer
SET @ENTRY := 3754;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,4000,4500,12000,18000,11,77522,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Swoop'),
(@ENTRY,0,1,0,2,0,100,1,0,15,0,0,11,6925,2,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Gift of the Xavian at 15% HP');

-- Hillsbrad Footman SAI
SET @ENTRY := 2268;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,1000,1000,180000,180000,11,7164,1,0,0,0,0,1,0,0,0,0,0,0,0,"Hillsbrad Footman - In Combat - Cast Defensive Stance"),
(@ENTRY,0,1,0,9,0,100,0,0,5,12000,15000,11,101817,0,0,0,0,0,2,0,0,0,0,0,0,0,"Hillsbrad Footman - At 0 - 5 Range - Cast Shield Bash"),
(@ENTRY,0,2,0,2,0,100,1,0,30,0,0,25,1,0,0,0,0,0,0,0,0,0,0,0,0,0,"Hillsbrad Footman - At 30% HP - Flee For Assist");

-- Mudsnout Shaman
SET @ENTRY := 2373;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,0,0,3400,4700,11,20805,64,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Lightning Bolt'),
(@ENTRY,0,1,0,2,0,100,1,0,15,0,0,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Flee at 15% HP');

-- Syndicate Wizard
SET @ENTRY := 2319;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,0,0,3400,4700,11,20815,64,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Fireball'),
(@ENTRY,0,1,0,2,0,100,1,0,15,0,0,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Flee at 15% HP'),
(@ENTRY,0,2,0,0,0,100,0,5000,8000,20000,22000,11,13323,0,0,0,0,0,4,0,0,0,0,0,0,0,'Cast Polymorph');

-- Burning Blade Acolyte
SET @ENTRY := 3380;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,2,0,100,0,0,40,14000,21000,11,689,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Drain Life at 40% HP'),
(@ENTRY,0,1,0,0,0,100,0,3000,4500,34000,38000,11,980,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Bane of Agony'),
(@ENTRY,0,2,0,2,0,100,1,0,15,0,0,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Flee at 15% HP'),
(@ENTRY,0,3,0,2,0,100,1,0,15,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Say Text at 15% HP');
-- NPC talk text insert
SET @ENTRY := 3380;
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0, '%s attempts to run away in fear!',16,0,100,0,0,0, 'combat Flee');

-- Great Father Arctikus
SET @ENTRY := 1260;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,2,0,100,1,0,30,0,0,11,18501,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Enrage at 30% HP'),
(@ENTRY,0,1,0,61,0,100,1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Say Text at 30% HP'),
(@ENTRY,0,2,0,4,0,100,1,0,0,0,0,11,77808,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Battle Shout on Aggro');
-- NPC talk text insert
SET @ENTRY := 1260;
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0, '%s becomes enraged!',16,0,100,0,0,0, 'combat Enrage');

-- Mo'grosh Mystic SAI
SET @ENTRY := 1183;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,1,0,0,0,0,21,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Mo'grosh Mystic - Out Of Combat - Allow Combat Movement"),
(@ENTRY,0,1,0,4,0,15,1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Mo'grosh Mystic - On Aggro - Say Line 0"),
(@ENTRY,0,2,3,4,0,100,0,0,0,0,0,11,9532,0,0,0,0,0,2,0,0,0,0,0,0,0,"Mo'grosh Mystic - On Aggro - Cast Lightning Bolt"),
(@ENTRY,0,3,0,61,0,100,0,0,0,0,0,23,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Mo'grosh Mystic - On Aggro - Increment Phase"),
(@ENTRY,0,4,0,9,0,100,0,0,40,3400,5400,11,9532,0,0,0,0,0,2,0,0,0,0,0,0,0,"Mo'grosh Mystic - At 0 - 40 Range - Cast Lightning Bolt"),
(@ENTRY,0,5,6,3,0,100,0,0,15,0,0,21,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Mo'grosh Mystic - At 15% Mana - Allow Combat Movement"),
(@ENTRY,0,6,0,61,0,100,0,0,0,0,0,23,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Mo'grosh Mystic - At 15% Mana - Increment Phase"),
(@ENTRY,0,7,0,9,0,100,1,35,80,0,0,21,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Mo'grosh Mystic - At 35 - 80 Range - Allow Combat Movement"),
(@ENTRY,0,8,0,9,0,100,1,5,15,0,0,21,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Mo'grosh Mystic - At 5 - 15 Range - Allow Combat Movement"),
(@ENTRY,0,9,0,9,0,100,1,0,5,0,0,21,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Mo'grosh Mystic - At 0 - 5 Range - Allow Combat Movement"),
(@ENTRY,0,10,0,3,0,100,0,30,100,100,100,23,0,1,0,0,0,0,1,0,0,0,0,0,0,0,"Mo'grosh Mystic - At 100% Mana - Increment Phase"),
(@ENTRY,0,11,0,14,0,100,1,0,40,0,0,11,11895,0,0,0,0,0,7,0,0,0,0,0,0,0,"Mo'grosh Mystic - On Friendly Unit At 0 - 40% Health - Cast Healing Wave");

-- Rot Hide Mystic SAI
SET @ENTRY := 1773;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,14,0,85,0,0,80,5000,5000,11,11895,0,0,0,0,0,7,0,0,0,0,0,0,0,"Rot Hide Mystic - On Friendly Unit At 0 - 80% Health - Cast Healing Wave"),
(@ENTRY,0,1,0,0,0,40,1,0,0,2500,2500,11,3237,1,0,0,0,0,5,0,0,0,0,0,0,0,"Rot Hide Mystic - In Combat - Cast Curse of Thule");

-- Torn Fin Oracle
SET @ENTRY := 2376;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,0,0,3400,4700,11,9532,64,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Lightning Bolt'),
(@ENTRY,0,1,0,2,0,100,1,0,15,0,0,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Flee at 15% HP');


-- Boulderfist Shaman
SET @ENTRY := 2570;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,4,0,20,1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Say Text on Aggro'),
(@ENTRY,0,1,0,0,0,100,0,0,0,3400,4700,11,9532,64,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Lightning Bolt'),
(@ENTRY,0,2,0,14,0,100,0,350,40,15000,18000,11,11986,0,0,0,0,0,7,0,0,0,0,0,0,0,'Cast Healing Wave on Friendlies'),
(@ENTRY,0,3,0,2,0,100,0,0,40,22000,25000,11,11986,2,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Healing Wav at 40% HP');
-- NPC talk text insert
SET @ENTRY := 2570;
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0, 'I\'ll crush you!',12,0,50,0,0,0, 'on Aggro Text'),
(@ENTRY,0,1, 'Me smash! You die!',12,0,50,0,0,0, 'on Aggro Text'),
(@ENTRY,0,2, 'Raaar!!! Me smash $r!',12,0,50,0,0,0, 'on Aggro Text');

-- Dun Garok Mountaineer SAI
SET @ENTRY := 2344;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,11,0,100,1,0,0,0,0,11,8258,1,0,0,0,0,1,0,0,0,0,0,0,0,"Dun Garok Mountaineer - On Respawn - Cast Devotion Aura"),
(@ENTRY,0,1,0,9,0,100,0,0,5,9000,15000,11,13953,0,0,0,0,0,2,0,0,0,0,0,0,0,"Dun Garok Mountaineer - At 0 - 5 Range - Cast Holy Strike"),
(@ENTRY,0,2,0,2,0,100,1,0,30,0,0,25,1,0,0,0,0,0,0,0,0,0,0,0,0,0,"Dun Garok Mountaineer - At 30% HP - Flee For Assist");

-- Magosh <Stonesplinter Tribal Shaman>
SET @ENTRY := 1399;
SET @ENTRYTOTEM := 22895;
SET @TOTEMSPELL := 39592;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
UPDATE `creature_template` SET `AIName`='0' WHERE `entry`=@ENTRYTOTEM;
UPDATE `creature_template` SET `spell1`=@TOTEMSPELL WHERE `entry`=@ENTRYTOTEM;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,0,500,1000,600000,600000,11,79927,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Earth Shield on Spawn'),
(@ENTRY,0,1,0,16,0,100,0,79927,1,15000,30000,11,79927,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Earth Shield on Repeat'),
(@ENTRY,0,2,0,0,0,100,0,10000,12000,38000,42000,11,39591,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Searing Totem'),
(@ENTRY,0,3,0,0,0,100,0,8000,8500,12000,20000,11,13281,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Earth Shock'),
(@ENTRY,0,4,0,0,0,100,0,9000,12000,22000,22000,11,84857,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Stone Splinter');


-- Kubb <Master of Meats and Fishes>
SET @ENTRY := 1425;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,5000,5000,15000,15000,11,81252,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Full of Meat');

-- Naga Explorer SAI
SET @ENTRY := 1907;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,4,0,100,1,0,0,0,0,11,7165,0,0,0,0,0,1,0,0,0,0,0,0,0,"Naga Explorer - On Aggro - Cast Battle Stance"),
(@ENTRY,0,1,0,0,0,100,0,6400,12600,18500,28700,11,13443,0,0,0,0,0,2,0,0,0,0,0,0,0,"Naga Explorer - In Combat - Cast Rend");

-- Defias Inmate SAI
SET @ENTRY := 1708;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,3,1000,1000,0,0,11,7165,0,0,0,0,0,1,0,0,0,0,0,0,0,"Defias Inmate - Out Of Combat - Cast Battle Stance"),
(@ENTRY,0,1,0,0,0,100,2,1900,11800,14200,36200,11,13443,0,0,0,0,0,2,0,0,0,0,0,0,0,"Defias Inmate - In Combat - Cast Rend"),
(@ENTRY,0,2,0,2,0,100,3,0,15,0,0,25,1,0,0,0,0,0,0,0,0,0,0,0,0,0,"Defias Inmate - At 15% HP - Flee For Assist");

-- Ravenclaw Regent SAI
SET @ENTRY := 2283;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,85,0,3000,3000,9000,12000,11,30898,0,0,0,0,0,5,0,0,0,0,0,0,0,"Ravenclaw Regent - In Combat - Cast Shadow Word: Pain"),
(@ENTRY,0,1,0,0,0,85,0,6000,6000,12000,18000,11,7645,1,0,0,0,0,6,0,0,0,0,0,0,0,"Ravenclaw Regent - In Combat - Cast Dominate Mind"),
(@ENTRY,0,2,0,9,0,100,0,4,30,1,1,79,15,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ravenclaw Regent - At 4 - 30 Range - Set Ranged Movement"),
(@ENTRY,0,3,0,9,0,100,0,0,4,1,1,79,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ravenclaw Regent - At 0 - 4 Range - Set Ranged Movement"),
(@ENTRY,0,4,0,11,0,100,1,0,0,0,0,79,15,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ravenclaw Regent - On Respawn - Set Ranged Movement");

-- Shadowy Assassin SAI
SET @ENTRY := 2434;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,11,0,100,1,0,0,0,0,11,30831,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Stealth on Spawn'),
(@ENTRY,0,1,0,7,0,100,1,0,0,0,0,11,30831,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Stealth on Evade');

-- Ruul Onestone
SET @ENTRY := 2602;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,4,0,20,1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Say Text on Aggro'),
(@ENTRY,0,1,0,0,0,100,0,0,0,3400,4700,11,20822,64,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Frostbolt'),
(@ENTRY,0,2,0,2,0,100,1,0,25,0,0,11,6742,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Bloodlust at 25% HP');
-- NPC talk text insert
SET @ENTRY := 2602;
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0, 'I\'ll crush you!',12,0,50,0,0,0, 'on Aggro Text'),
(@ENTRY,0,1, 'Me smash! You die!',12,0,50,0,0,0, 'on Aggro Text'),
(@ENTRY,0,2, 'Raaar!!! Me smash $r!',12,0,50,0,0,0, 'on Aggro Text');

-- Drywhisker Surveyor
SET @ENTRY := 2573;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,0,0,3400,4700,11,20822,64,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Frostbolt');

-- Dark Iron Shadowcaster SAI
SET @ENTRY := 2577;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,1,0,0,0,0,21,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Dark Iron Shadowcaster - Out Of Combat - Allow Combat Movement"),
(@ENTRY,0,1,2,4,0,100,0,0,0,0,0,11,20816,0,0,0,0,0,2,0,0,0,0,0,0,0,"Dark Iron Shadowcaster - On Aggro - Cast Shadow Bolt"),
(@ENTRY,0,2,0,61,0,100,0,0,0,0,0,23,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Dark Iron Shadowcaster - On Aggro - Increment Phase"),
(@ENTRY,0,3,0,9,0,100,0,0,40,3500,8600,11,20816,0,0,0,0,0,2,0,0,0,0,0,0,0,"Dark Iron Shadowcaster - At 0 - 40 Range - Cast Shadow Bolt"),
(@ENTRY,0,4,5,3,0,100,0,0,15,0,0,21,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Dark Iron Shadowcaster - At 15% Mana - Allow Combat Movement"),
(@ENTRY,0,5,0,61,0,100,0,0,0,0,0,23,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Dark Iron Shadowcaster - At 15% Mana - Increment Phase"),
(@ENTRY,0,6,0,9,0,100,1,35,80,0,0,21,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Dark Iron Shadowcaster - At 35 - 80 Range - Allow Combat Movement"),
(@ENTRY,0,7,0,9,0,100,1,0,5,0,0,21,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Dark Iron Shadowcaster - At 0 - 5 Range - Allow Combat Movement"),
(@ENTRY,0,8,0,9,0,100,0,5,15,0,0,21,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Dark Iron Shadowcaster - At 5 - 15 Range - Allow Combat Movement"),
(@ENTRY,0,9,0,3,0,100,0,30,100,100,100,23,0,1,0,0,0,0,1,0,0,0,0,0,0,0,"Dark Iron Shadowcaster - At 100% Mana - Increment Phase"),
(@ENTRY,0,10,0,0,0,100,0,5500,12400,18200,30700,11,17883,0,0,0,0,0,2,0,0,0,0,0,0,0,"Dark Iron Shadowcaster - In Combat - Cast Immolate"),
(@ENTRY,0,11,12,2,0,100,1,0,15,0,0,22,3,0,0,0,0,0,1,0,0,0,0,0,0,0,"Dark Iron Shadowcaster - At 15% HP - Set Phase 3"),
(@ENTRY,0,12,13,61,0,100,0,0,15,0,0,21,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Dark Iron Shadowcaster - At 15% HP - Allow Combat Movement"),
(@ENTRY,0,13,0,61,0,100,0,0,0,0,0,25,1,0,0,0,0,0,0,0,0,0,0,0,0,0,"Dark Iron Shadowcaster - At 15% HP - Flee For Assist");

-- Dustbelcher Shaman
SET @ENTRY := 2718;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,4,0,20,1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Say Text on Aggro'),
(@ENTRY,0,1,0,0,0,100,0,0,0,3400,4700,11,9532,64,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Lightning Bolt');
-- NPC talk text insert
SET @ENTRY := 2718;
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0, 'I\'ll crush you!',12,0,50,0,0,0, 'on Aggro Text'),
(@ENTRY,0,1, 'Me smash! You die!',12,0,50,0,0,0, 'on Aggro Text'),
(@ENTRY,0,2, 'Raaar!!! Me smash $r!',12,0,50,0,0,0, 'on Aggro Text');

-- Kor'gresh Coldrage
SET @ENTRY := 2793;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,0,0,3400,4700,11,9672,64,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Frostbolt'),
(@ENTRY,0,1,0,0,0,100,0,8000,8000,25000,26000,11,4320,0,0,0,0,0,4,0,0,0,0,0,0,0,'Cast Trelane\'s Freezing Touch');

-- Voodoo Troll SAI
SET @ENTRY := 3206;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,0,3000,3000,40000,40000,11,324,0,0,0,0,0,1,0,0,0,0,0,0,0,"Voodoo Troll - Out Of Combat - Cast Lightning Shield"),
(@ENTRY,0,1,0,2,0,100,0,0,30,27500,27500,11,11986,0,0,0,0,0,1,0,0,0,0,0,0,0,"Voodoo Troll - At 30% HP - Cast Healing Wave");

-- Shadowforge Commander SAI
SET @ENTRY := 2744;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,4,0,100,1,0,0,0,0,11,8258,0,0,0,0,0,1,0,0,0,0,0,0,0,"Shadowforge Commander - On Aggro - Cast Devotion Aura");

-- Zalazane SAI
SET @ENTRY := 3205;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,2,0,100,0,0,40,27500,27500,11,11986,0,0,0,0,0,1,0,0,0,0,0,0,0,"Zalazane - At 40% HP - Cast Healing Wave"),
(@ENTRY,0,1,0,0,0,80,1,0,0,4000,4000,11,7289,0,0,0,0,0,2,0,0,0,0,0,0,0,"Zalazane - In Combat - Cast Shrink");

-- Saltspittle Oracle SAI
SET @ENTRY := 3742;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,1000,2400,6200,14500,11,2608,0,0,0,0,0,2,0,0,0,0,0,0,0,"Saltspittle Oracle - In Combat - Cast Shock"),
(@ENTRY,0,1,0,2,0,100,0,0,30,54600,54600,11,11986,1,0,0,0,0,1,0,0,0,0,0,0,0,"Saltspittle Oracle - At 30% HP - Cast Healing Wave"),
(@ENTRY,0,2,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,0,0,0,0,0,0,0,0,"Saltspittle Oracle - At 15% HP - Flee For Assist");

-- Bael'dun Appraiser SAI
SET @ENTRY := 2990;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,2,0,100,0,0,50,12000,12000,11,11986,0,0,0,0,0,1,0,0,0,0,0,0,0,"Bael'dun Appraiser - At 50% HP - Cast Lesser Heal");

-- Shadowforge Tunneler
SET @ENTRY := 2739;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,5000,5000,12000,13000,11,76622,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Sunder Armor');

-- Foulweald Shaman SAI
SET @ENTRY := 3748;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,11,0,100,1,0,0,0,0,11,6823,0,0,0,0,0,1,0,0,0,0,0,0,0,"Foulweald Shaman - On Respawn - Cast Corrupted Intellect Passive"),
(@ENTRY,0,1,0,1,0,100,0,1000,1000,300000,300000,11,33570,0,0,0,0,0,1,0,0,0,0,0,0,0,"Foulweald Shaman - Out Of Combat - Cast Strength of Earth Totem"),
(@ENTRY,0,2,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,0,0,0,0,0,0,0,0,"Foulweald Shaman - At 15% HP - Flee For Assist");

-- Bristleback Thornweaver
SET @ENTRY := 3261;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,0,0,3400,4700,11,9739,64,0,0,0,0,2,0,0,0,0,0,0,0,'Cast bolt'),
(@ENTRY,0,1,2,2,0,100,1,0,15,0,0,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Flee at 15% HP'),
(@ENTRY,0,2,0,61,0,100,1,0,15,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Say Text at 15% HP'),
(@ENTRY,0,3,0,9,0,100,0,0,20,9000,12000,11,12747,1,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Entangling Roots');
-- NPC talk text insert
SET @ENTRY := 3261;
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0, '%s attempts to run away in fear!',16,0,100,0,0,0, 'combat Flee');

-- Forsaken Seeker SAI
SET @ENTRY := 3732;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,4000,7000,8000,12000,11,9734,0,0,0,0,0,2,0,0,0,0,0,0,0,"Forsaken Seeker - In Combat - Cast Holy Smite"),
(@ENTRY,0,1,0,14,0,100,1,0,40,0,0,11,11986,1,0,0,0,0,7,0,0,0,0,0,0,0,"Forsaken Seeker - On Friendly Unit At 0 - 40% Health - Cast Heal"),
(@ENTRY,0,2,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,0,0,0,0,0,0,0,0,"Forsaken Seeker - At 15% HP - Flee For Assist");

-- Daggerspine Sorceress
SET @ENTRY := 2596;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,0,0,3400,4700,11,9532,64,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Lightning Bolt'),
(@ENTRY,0,1,0,2,0,100,1,0,15,0,0,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Flee at 15% HP');

-- Lieutenant Valorcall
SET @ENTRY := 2612;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,5000,8000,12000,15000,11,13953,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Holy Strike');

-- Razormane Mystic
SET @ENTRY := 3271;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,0,0,3400,4700,11,9613,64,0,0,0,0,2,0,0,0,0,0,0,0,'Cast bolt'),
(@ENTRY,0,1,2,2,0,100,1,0,15,0,0,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Flee at 15% HP'),
(@ENTRY,0,2,0,61,0,100,1,0,15,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Say Text at 15% HP'),
(@ENTRY,0,3,0,1,0,100,0,500,1000,600000,600000,11,26364,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Lightning Shield on Spawn'),
(@ENTRY,0,4,0,16,0,100,0,26364,1,15000,30000,11,26364,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Lightning Shield on Repeat');
-- NPC talk text insert
SET @ENTRY := 3271;
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0, '%s attempts to run away in fear!',16,0,100,0,0,0, 'combat Flee');

-- Druid of the Fang
SET @ENTRY := 3840;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,0,0,100,2,0,0,3400,4700,11,20805,64,0,0,0,0,2,0,0,0,0,0,0,0,'Cast bolt'),
(@ENTRY,0,2,0,2,0,100,3,0,50,0,0,11,23381,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Healing Touch at 50% HP'),
(@ENTRY,0,3,0,0,0,100,2,10000,10000,13000,20000,11,8040,0,0,0,0,0,5,0,0,0,0,0,0,0,'Cast Druid\'s Slumber'),
(@ENTRY,0,4,0,4,0,100,3,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Say Text on Aggro'),
(@ENTRY,0,5,0,14,0,100,2,800,40,18000,24000,11,23381,0,0,0,0,0,7,0,0,0,0,0,0,0,'Cast Healing Touch on Friendlies'),
(@ENTRY,0,6,7,2,0,100,3,0,30,0,0,11,7965,1,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Cobrahn Serpent Form at 30% HP'),
(@ENTRY,0,7,0,61,0,100,3,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Set Phase 1 at 30% HP'),
(@ENTRY,0,8,0,0,1,100,2,3000,4000,16000,18000,11,744,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Poison'),
(@ENTRY,0,9,0,7,1,100,3,0,0,0,0,22,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Reset on Evade'),
(@ENTRY,0,10,0,1,0,100,3,1000,1000,1000,1000,11,39550,2,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Arcane Aura on Spawn');
-- NPC talk text insert
SET @ENTRY := 3840;
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0, '%s attempts to run away in fear!',16,0,100,0,0,0, 'combat Flee');

-- Akkrilus
SET @ENTRY := 3773;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,5000,9000,21000,28000,11,37628,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Fel Immolate'),
(@ENTRY,0,1,0,0,0,100,0,2000,4000,24000,38000,11,37628,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Fel Fireball');

-- Shadowfang Darksoul SAI
SET @ENTRY := 3855;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,2,1300,9700,3600,7200,11,30898,0,0,0,0,0,2,0,0,0,0,0,0,0,"Shadowfang Darksoul - In Combat - Cast Shadow Word: Pain"),
(@ENTRY,0,1,0,0,0,100,2,2600,12700,3800,22500,11,8140,32,0,0,0,0,5,0,0,0,0,0,0,0,"Shadowfang Darksoul - In Combat - Cast Befuddlement");

-- Xavian Felsworn
SET @ENTRY := 3755;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,0,0,3400,4700,11,35913,64,0,0,0,0,2,0,0,0,0,0,0,0,'Cast bolt'),
(@ENTRY,0,1,0,2,0,100,1,0,15,0,0,11,6925,1,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Gift of the Xavian at 15% HP');

-- Temple A SAI
SET @ENTRY := 25471;
UPDATE `creature_template` SET `AIName`="" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;

-- Arctic Grizzly SAI
SET @ENTRY := 26482;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,23,0,100,1,47628,1,1,1,11,47675,0,0,0,0,0,1,0,0,0,0,0,0,0,"Arctic Grizzly - On Aura - Cast Recently Inoculated"),
(@ENTRY,0,2,0,61,0,100,1,0,0,0,0,41,5000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Arctic Grizzly - Event Linked - Despawn Delay 5 Seconds");

-- Temple B SAI
SET @ENTRY := 25472;
UPDATE `creature_template` SET `AIName`="" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;

-- Decaying Ghoul SAI
SET @ENTRY := 28565;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,38,0,100,0,0,1,0,0,29,1,1,28591,0,0,0,19,28591,15,0,0,0,0,0,"Ghoul - on data 1 set - start follow"),
(@ENTRY,0,2,3,61,0,100,0,0,0,0,0,41,2000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ghoul - on follow completed - despawn");

-- Snowfall Elk SAI
SET @ENTRY := 26615;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,9,0,100,1,0,5,8000,12000,11,15976,0,0,0,0,0,2,0,0,0,0,0,0,0,"Snowfall Elk - Cast Puncture"),
(@ENTRY,0,1,2,23,0,100,1,47628,1,1,1,11,47675,0,0,0,0,0,1,0,0,0,0,0,0,0,"Snowfall Elk - On Aura - Cast Recently Inoculated"),
(@ENTRY,0,3,0,61,0,100,1,0,0,0,0,41,5000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Snowfall Elk - Event Linked - Despawn Delay 5 Seconds");

-- Temple C SAI
SET @ENTRY := 25473;
UPDATE `creature_template` SET `AIName`="" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;

-- Iron Rune-Shaper SAI
SET @ENTRY := 26270;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,61,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Iron Rune-Shaper - On Spellhit Throw Boulder - Forced Despawn");

-- Defeated Argent Footman SAI
SET @ENTRY := 28156;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,8,0,100,0,51276,0,0,0,11,59216,0,0,0,0,0,1,0,0,0,0,0,0,0,"Defeated Argent Footman - On Spellhit Incinerate Corpse - Cast Burning Corpse"),
(@ENTRY,0,2,0,61,0,100,0,0,0,0,0,23,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Defeated Argent Footman - On Spellhit Incinerate Corpse - Increment Phase"),
(@ENTRY,0,3,0,1,0,100,1,10000,10000,10000,10000,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Defeated Argent Footman - Out Of Combat - Forced Despawn");

-- Kalecgos SAI
SET @ENTRY := 38017;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,38,0,100,0,0,1,0,0,80,@ENTRY*100+00,0,0,0,0,0,1,0,0,0,0,0,0,0,"Kalecgos - On Data Set 0 1 - Run Script"),
(@ENTRY,0,1,0,61,0,100,0,0,2,0,0,80,@ENTRY*100+01,0,0,0,0,0,1,0,0,0,0,0,0,0,"Kalecgos - On Data Set 0 1 - Run Script"),
(@ENTRY,0,2,3,40,0,100,0,1,38017,0,0,54,30000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Kalecgos - On Waypoint 1 Reached - Pause Waypoint"),
(@ENTRY,0,3,0,61,0,100,0,0,0,0,0,66,0,0,0,0,0,0,9,27990,0,15,0,0,0,0,"Kalecgos - On Waypoint 1 Reached - Set Orientation Closest Creature 'Krasus'"),
(@ENTRY,0,4,5,40,0,100,0,2,38017,0,0,55,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Kalecgos - On Waypoint 2 Reached - Stop Waypoint"),
(@ENTRY,0,5,0,61,0,100,0,0,0,0,0,66,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Kalecgos - On Waypoint 2 Reached - Set Orientation Home Position");


-- Redridge Mystic
SET @ENTRY := 430;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,0,0,3400,4700,11,9532,64,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Lightning Bolt'),
(@ENTRY,0,1,0,2,0,100,1,0,15,0,0,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Flee at 15% HP');


-- Actionlist SAI
SET @ENTRY := 20401900;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,9,0,0,0,0,100,0,1000,1000,0,0,45,0,1,0,0,0,0,11,42645,10,0,0,0,0,0,"Send data 1 to Princess");

-- Silverwing Warrior SAI
SET @ENTRY := 12897;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,5000,8000,25000,28000,11,11977,0,0,0,0,0,2,0,0,0,0,0,0,0,"Cast Rend");

-- Alexandra Blazen SAI
SET @ENTRY := 8378;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,38,0,100,0,1,1,0,0,2,250,0,0,0,0,0,1,0,0,0,0,0,0,0,"Alexandra Blazen - On Data Set 1 1 - Set Faction 250"),
(@ENTRY,0,1,0,38,0,100,0,2,2,0,0,2,35,0,0,0,0,0,1,0,0,0,0,0,0,0,"Alexandra Blazen - On Data Set 2 2 - Set Faction 35"),
(@ENTRY,0,2,0,4,0,100,0,0,0,0,0,11,48168,2,0,0,0,0,1,0,0,0,0,0,0,0,"Alexandra Blazen - On Aggro - Cast 'Inner Fire'"),
(@ENTRY,0,3,0,2,0,100,0,0,0,20000,20000,11,11640,0,0,0,0,0,1,0,0,0,0,0,0,0,"Alexandra Blazen - Between 0-0% Health - Cast 'Renew'");

SET @ENTRY := -97629;
UPDATE `creature_template` SET `AIName`="" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;

SET @ENTRY := -96818;
UPDATE `creature_template` SET `AIName`="" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;

-- The Defias Traitor SAI
SET @ENTRY := 467;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,19,0,100,0,155,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Defias Traitor - On Accepted Quest 'The Defias Brotherhood' - Say Line 0"),
(@ENTRY,0,1,2,61,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,"The Defias Traitor - Link With Previous - Store Target List"),
(@ENTRY,0,2,3,61,0,100,0,0,0,0,0,83,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Defias Traitor - Link With Previous - Remove npcflag 'Quest Giver"),
(@ENTRY,0,4,0,40,0,100,0,36,467,0,0,59,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Defias Traitor - On WP Reached 36 - Disable run"),
(@ENTRY,0,5,0,40,0,100,0,37,467,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Defias Traitor - On WP Reached 37 - Say Line 1"),
(@ENTRY,0,6,7,40,0,100,0,45,467,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Defias Traitor - On WP Reached 45 - Say Line 2"),
(@ENTRY,0,7,8,61,0,100,0,0,0,0,0,15,155,0,0,0,0,0,12,1,0,0,0,0,0,0,"The Defias Traitor - Link With Previous - Area Explored Or Event Happens"),
(@ENTRY,0,8,0,61,0,100,1,0,0,0,0,41,3000,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Defias Traitor - Link WIth Previous - Despawn"),
(@ENTRY,0,9,0,4,0,100,0,0,0,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Defias Traitor - On Aggro - Say Line 3");


-- The Plains Vision SAI
SET @ENTRY := 2983;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,40,0,100,0,50,2983,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Plains Vision - On Waypoint 50 Reached - Despawn In 1000 ms");

-- Patrick Mills SAI
SET @ENTRY := 8382;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,38,0,100,0,1,1,0,0,2,250,0,0,0,0,0,1,0,0,0,0,0,0,0,"Patrick Mills - On Data Set 1 1 - Set Faction 250"),
(@ENTRY,0,1,0,38,0,100,0,2,2,0,0,2,35,0,0,0,0,0,1,0,0,0,0,0,0,0,"Patrick Mills - On Data Set 2 2 - Set Faction 35"),
(@ENTRY,0,2,0,4,0,100,0,0,0,0,0,11,8258,2,0,0,0,0,1,0,0,0,0,0,0,0,"Patrick Mills - On Aggro - Cast 'Devotion Aura'"),
(@ENTRY,0,3,0,0,0,100,0,2000,2000,4000,4000,11,17143,0,0,0,0,0,2,0,0,0,0,0,0,0,"Patrick Mills - In Combat - Cast 'Holy Strike'");

-- Fei Fei SAI
SET @ENTRY := 20206;
UPDATE `creature_template` SET `AIName`="" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;

-- Molthor SAI
SET @ENTRY := 14875;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,64,0,100,0,0,0,0,0,5,4,0,0,0,0,0,1,0,0,0,0,0,0,0,"Molthor - On Gossip Hello - Play Emote 4 (No Repeat)"),
(@ENTRY,0,2,0,40,0,100,0,11,14875,0,0,80,@ENTRY*100+00,2,0,0,0,0,1,0,0,0,0,0,0,0,"Molthor - On Waypoint 12 Reached - Run Script"),
(@ENTRY,0,3,0,40,0,100,0,11,14875,0,0,54,39000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Molthor - On Waypoint 12 Reached - Pause Waypoint");

-- Razaani Light Orb SAI
SET @ENTRY := 20635;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,8,0,100,0,28337,0,0,0,80,@ENTRY*100+00,2,0,0,0,0,1,0,0,0,0,0,0,0,"Razaani Light Orb - On Spellhit 'Magnetic Pull' - Run Script (No Repeat)"),
(@ENTRY,0,1,0,38,0,100,0,0,1,30000,30000,69,1,0,0,0,0,0,19,22333,20,0,0,0,0,0,"Razaani Light Orb - On Data Set 0 1 - Move To Closest Creature 'Orb Collecting Totem' (No Repeat)"),
(@ENTRY,0,2,3,34,0,100,1,8,1,0,0,11,35426,0,0,0,0,0,1,0,0,0,0,0,0,0,"Razaani Light Orb - On Reached Point 1 - Cast 'Arcane Explosion Visual' (No Repeat)"),
(@ENTRY,0,4,0,61,0,100,0,0,0,0,0,80,2084135,2,0,0,0,0,1,0,0,0,0,0,0,0,"Razaani Light Orb - On Reached Point 1 - Run Script (No Repeat)");

-- Razaani Light Orb - Mini SAI
SET @ENTRY := 20771;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,8,0,100,0,28337,0,0,0,80,@ENTRY*100+00,2,0,0,0,0,1,0,0,0,0,0,0,0,"Razaani Light Orb - Mini - On Spellhit 'Magnetic Pull' - Run Script"),
(@ENTRY,0,1,0,38,0,100,0,1,1,30000,30000,69,1,0,0,0,0,0,19,22333,20,0,0,0,0,0,"Razaani Light Orb - Mini - On Data Set 1 1 - Move To Closest Creature 'Orb Collecting Totem'"),
(@ENTRY,0,2,3,34,0,100,1,8,1,0,0,11,35426,0,0,0,0,0,1,0,0,0,0,0,0,0,"Razaani Light Orb - Mini - On Reached Point 1 - Cast 'Arcane Explosion Visual' (No Repeat)"),
(@ENTRY,0,4,0,61,0,100,0,0,0,0,0,80,2097871,2,0,0,0,0,1,0,0,0,0,0,0,0,"Razaani Light Orb - Mini - On Reached Point 1 - Run Script (No Repeat)");

-- Major Mills SAI
SET @ENTRY := 23905;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,19,1,100,0,11198,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"Major Mills - On Quest 'Take Down Tethyr!' Taken - Say Line 0"),
(@ENTRY,0,1,0,19,1,100,0,11198,0,0,0,80,@ENTRY*100+00,0,0,0,0,0,1,0,0,0,0,0,0,0,"Major Mills - On Quest 'Take Down Tethyr!' Taken - Run Script"),
(@ENTRY,0,1,2,38,0,100,0,0,1,0,0,82,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Tethyr - On data set - Add npcflag"),
(@ENTRY,0,2,3,61,0,100,0,0,0,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,"Tethyr - On data set - talk"),
(@ENTRY,0,3,0,61,0,100,0,0,0,0,0,15,11198,0,0,0,0,0,18,100,0,0,0,0,0,0,"Tethyr - On data sett - Area explored"),
(@ENTRY,0,4,0,38,0,100,0,0,2,0,0,82,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Tethyr - On data set - Add npcflag");

UPDATE `quest_template` SET `SpecialFlags` = 2 WHERE `Id` = 11198;
UPDATE `quest_template` SET `SpecialFlags` = 2 WHERE `Id` = 12274;

-- Arctic Grizzly SAI
SET @ENTRY := 26482;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,23,0,100,1,47628,1,1,1,11,47675,0,0,0,0,0,1,0,0,0,0,0,0,0,"Arctic Grizzly - On Aura - Cast Recently Inoculated"),
(@ENTRY,0,2,0,61,0,100,1,0,0,0,0,41,5000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Arctic Grizzly - Event Linked - Despawn Delay 5 Seconds");

-- Fire Upon the Waters Kill Credit Bunny SAI
SET @ENTRY := 28013;
UPDATE `creature_template` SET `AIName`="" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;

-- Thorim SAI
SET @ENTRY := 29445;
UPDATE `creature_template` SET `AIName`="" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;

-- Frostbite SAI
SET @ENTRY := 29903;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,54,0,100,0,0,0,0,0,11,54993,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Bite - On Just Summoned - Cast Frosthound Periodic"),
(@ENTRY,0,1,0,61,0,100,0,0,0,0,0,80,@ENTRY*100+00,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Bite - On Just Summoned - Run Script"),
(@ENTRY,0,2,0,7,0,100,0,0,0,0,0,11,54993,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Bite - On Evade - Cast Frosthound Periodic"),
(@ENTRY,0,3,0,40,0,100,0,4,29903,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Bite - On Reached WP3 - Say Line 1"),
(@ENTRY,0,4,5,40,0,100,0,23,29903,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Bite - On Reached WP3 - Say Line 2"),
(@ENTRY,0,5,6,61,0,100,0,0,0,0,0,1,3,0,0,0,0,0,23,0,0,0,0,0,0,0,"Frost Bite - On Reached WP3 - Say Line 3"),
(@ENTRY,0,7,0,61,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Bite - On Reached WP3 - Despawn");

-- Lumbering Atrocity
SET @ENTRY := 30920;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,5000,8000,12000,12000,11,40504,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Cleave');

-- Hungering Plaguehound
SET @ENTRY := 30952;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,5000,5000,25000,34000,11,3427,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Infected Wound');


UPDATE `quest_template` SET `SpecialFlags` = 2 WHERE `Id` = 27863;
UPDATE `quest_template` SET `SpecialFlags` = 2 WHERE `Id` = 27866;
UPDATE `quest_template` SET `SpecialFlags` = 2 WHERE `Id` = 27868;

UPDATE `quest_template` SET `SpecialFlags` = 2 WHERE `Id` = 10329;
UPDATE `quest_template` SET `SpecialFlags` = 2 WHERE `Id` = 10330;
UPDATE `quest_template` SET `SpecialFlags` = 2 WHERE `Id` = 10321;
UPDATE `quest_template` SET `SpecialFlags` = 2 WHERE `Id` = 10338;
UPDATE `quest_template` SET `SpecialFlags` = 2 WHERE `Id` = 10322;
UPDATE `quest_template` SET `SpecialFlags` = 2 WHERE `Id` = 10365;
UPDATE `quest_template` SET `SpecialFlags` = 2 WHERE `Id` = 10323;

-- Dark Strand Assassin SAI
SET @ENTRY := 3879;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,0,5000,11000,18000,11,3405,0,0,0,0,0,2,0,0,0,0,0,0,0,"Dark Strand Assassin - IC - Cast Soul Rend"),
(@ENTRY,0,1,0,0,0,100,0,5000,9000,15000,21000,11,32862,64,0,0,0,0,2,0,0,0,0,0,0,0,"Dark Strand Assassin - IC - Cast Drain Soul"),
(@ENTRY,0,2,0,54,0,100,0,0,0,0,0,18,768,0,0,0,0,0,1,0,0,0,0,0,0,0,"Dark Strand Assassin - On Just Summoned - Set Unit Flags - Immune to NPC/NPC"),
(@ENTRY,0,3,0,38,0,100,0,1,1,0,0,19,768,0,0,0,0,0,1,0,0,0,0,0,0,0,"Dark Strand Assassin - On Data Set - Remove Unit Flags - Immune to NPC/NPC");


-- Spitelash Raider SAI
SET @ENTRY := 12204;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,5,0,0,0,100,0,40,1000,6500,9000,11,12545,0,0,0,0,0,2,0,0,0,0,0,0,0,"Spitelash Raider - In Combat - Cast 'Spitelash'"),
(@ENTRY,0,6,0,0,0,100,0,1000,2500,11000,15000,11,12548,0,0,0,0,0,2,0,0,0,0,0,0,0,"Spitelash Raider - In Combat - Cast 'Frost Shock'");

-- Spitelash Witch SAI
SET @ENTRY := 12205;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,5,0,1,0,100,0,1000,1000,60000,60000,11,12550,2,0,0,0,0,1,0,0,0,0,0,0,0,"Spitelash Witch - Out of Combat - Cast 'Lightning Shield'"),
(@ENTRY,0,6,0,0,0,100,0,2000,2000,4000,5000,11,9672,0,0,0,0,0,2,0,0,0,0,0,0,0,"Spitelash Witch - In Combat - Cast 'Frostbolt'");

-- Multi-Spectrum Light Trap Bunny SAI
SET @ENTRY := 21926;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,54,0,100,1,0,0,0,0,50,185011,30000,0,0,0,0,1,0,0,0,0,0,0,0,"Multi-Spectrum Light Trap Bunny - On Just Summoned - Summon Gameobject 'Multi-Spectrum Light Trap' (Phase 1) (No Repeat)"),
(@ENTRY,0,1,0,1,0,100,1,0,0,0,0,9,0,0,0,0,0,0,15,185011,0,0,0,0,0,0,"Multi-Spectrum Light Trap Bunny - Out of Combat - Activate Gameobject (Phase 1) (No Repeat)"),
(@ENTRY,0,2,0,1,0,100,1,3000,3000,3000,3000,11,28337,0,0,0,0,0,19,20635,20,0,0,0,0,0,"Multi-Spectrum Light Trap Bunny - Out of Combat - Cast 'Magnetic Pull' (Phase 1) (No Repeat)"),
(@ENTRY,0,3,0,1,0,100,1,3000,3000,3000,3000,11,28337,0,0,0,0,0,19,20771,20,0,0,0,0,0,"Multi-Spectrum Light Trap Bunny - Out of Combat - Cast 'Magnetic Pull' (Phase 1) (No Repeat)"),
(@ENTRY,0,5,0,61,0,100,1,0,0,0,0,9,0,0,0,0,0,0,15,185011,0,0,0,0,0,0,"Multi-Spectrum Light Trap Bunny - On Data Set 1 1 - Activate Gameobject (No Repeat)");

-- Lithe Stalker SAI
SET @ENTRY := 30894;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,8,0,100,0,58151,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,"Lithe Stalker - On Spellhit (Subdued Lithe Stalker) - Store Targetlist"),
(@ENTRY,0,1,0,61,0,100,0,0,0,0,0,29,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Lithe Stalker - On Spellhit (Subdued Lithe Stalker) - Follow Target"),
(@ENTRY,0,3,0,61,0,100,0,58178,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Lithe Stalker - On Spellhit (CSA Dummy Effect) - Despawn");

-- Orphan Matron Aria SAI
SET @ENTRY := 34365;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,2,4,62,0,100,0,10502,2,0,0,11,65359,0,0,0,0,0,7,0,0,0,0,0,0,0,"Orphan Matron Aria - On gossip select - Create oracle orphan whistle"),
(@ENTRY,0,3,4,62,0,100,0,10502,3,0,0,11,65360,0,0,0,0,0,7,0,0,0,0,0,0,0,"Orphan Matron Aria - On gossip select - Create wolvar orphan whistle"),
(@ENTRY,0,4,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Orphan Matron Aria - On gossip select - Close gossip");

-- Actionlist SAI
SET @ENTRY := 20401900;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,9,0,0,0,0,100,0,1000,1000,0,0,45,0,1,0,0,0,0,11,42645,10,0,0,0,0,0,"Send data 1 to Princess");

-- Actionlist SAI
SET @ENTRY := 4264500;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,9,0,0,0,0,100,0,5000,5000,0,0,1,0,0,0,0,0,0,18,10,0,0,0,0,0,0,"talk to player"),
(@ENTRY,9,1,0,0,0,100,0,0,0,0,0,46,20,0,0,0,0,0,1,0,0,0,0,0,0,0,"Move forward"),
(@ENTRY,9,2,0,0,0,100,0,10000,10000,0,0,37,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Die self");

-- Wounded Hyjal Defender SAI
SET @ENTRY := 52834;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,8,0,100,0,97670,0,0,0,41,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"molten front quests fix");

-- West Plains Drifter SAI
SET @ENTRY := 42391;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,62,0,100,0,87,0,0,0,1,0,2000,0,0,0,0,7,0,0,0,0,0,0,0,"Murder was the case - On Gossip1 - random aggro sentence"),
(@ENTRY,0,1,0,62,0,100,0,87,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Murder was the case - On Gossip1 - close gossip"),
(@ENTRY,0,2,0,52,0,100,0,0,42391,0,0,49,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Murder was the case - On Gossip1 - start attack"),
(@ENTRY,0,3,0,52,0,100,0,0,42391,0,0,81,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Murder was the case - On Gossip1 - npc_flag to 0"),
(@ENTRY,0,4,0,52,0,100,0,0,42391,0,0,2,20,0,0,0,0,0,1,0,0,0,0,0,0,0,"Murder was the case - On Gossip1 - change faction to aggressive"),
(@ENTRY,0,5,0,25,0,100,0,0,0,0,0,2,7,0,0,0,0,0,1,0,0,0,0,0,0,0,"Murder was the case - On Reset - change faction back to neutral"),
(@ENTRY,0,6,0,25,0,100,0,0,0,0,0,81,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Murder was the case - On Reset - change npc_flag back to gossip"),
(@ENTRY,0,7,0,62,0,100,0,87,1,0,0,87,@ENTRY*100+01,@ENTRY*100+02,@ENTRY*100+03,@ENTRY*100+04,0,0,1,0,0,0,0,0,0,0,"Murder was the case - On Gossip 2 - Tell random clue"),
(@ENTRY,0,12,0,62,0,100,0,87,1,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Murder was the case - On Gossip 2 - close gossip"),
(@ENTRY,0,13,0,62,0,100,0,87,1,0,0,81,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Murder was the case - Make the gossiper unavailable"),
(@ENTRY,0,14,0,60,0,100,0,30000,30000,30000,30000,81,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Murder was the case - Reactivate gossiper every 30s");

-- Thug SAI
SET @ENTRY := 42387;
UPDATE `creature_template` SET `AIName`="" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;

SET @ENTRY := -44315;
UPDATE `creature_template` SET `AIName`="" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;

SET @ENTRY := 58964;
UPDATE `creature_template` SET `AIName`="" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
SET @ENTRY := 75548;
UPDATE `creature_template` SET `AIName`="" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
SET @ENTRY := 573340;
UPDATE `creature_template` SET `AIName`="" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;

-- Stormcrest Eagle SAI
SET @ENTRY := 30108;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,40,0,100,0,1,30108,0,0,1,0,0,0,0,0,0,19,30401,10,0,0,0,0,0,"Stormcrest Eagle - On Waypoint 1 Reached - Say Line 0"),
(@ENTRY,0,2,0,40,0,100,0,2,30108,0,0,1,1,0,0,0,0,0,19,30401,10,0,0,0,0,0,"Stormcrest Eagle - On Waypoint 2 Reached - Say Line 1"),
(@ENTRY,0,3,0,40,0,100,0,4,30108,0,0,1,2,0,0,0,0,0,19,30401,10,0,0,0,0,0,"Stormcrest Eagle - On Waypoint 4 Reached - Say Line 2"),
(@ENTRY,0,4,0,40,0,100,0,6,30108,0,0,1,3,0,0,0,0,0,19,30401,10,0,0,0,0,0,"Stormcrest Eagle - On Waypoint 6 Reached - Say Line 3"),
(@ENTRY,0,5,0,40,0,100,0,8,30108,0,0,1,4,0,0,0,0,0,19,30401,10,0,0,0,0,0,"Stormcrest Eagle - On Waypoint 8 Reached - Say Line 4"),
(@ENTRY,0,6,0,40,0,100,0,10,30108,0,0,1,5,0,0,0,0,0,19,30401,10,0,0,0,0,0,"Stormcrest Eagle - On Waypoint 10 Reached - Say Line 5"),
(@ENTRY,0,7,0,40,0,100,0,12,30108,0,0,1,6,0,0,0,0,0,19,30401,10,0,0,0,0,0,"Stormcrest Eagle - On Waypoint 12 Reached - Say Line 6"),
(@ENTRY,0,8,0,40,0,100,0,14,30108,0,0,1,7,0,0,0,0,0,19,30401,10,0,0,0,0,0,"Stormcrest Eagle - On Waypoint 14 Reached - Say Line 7"),
(@ENTRY,0,9,0,40,0,100,0,16,30108,0,0,1,8,0,0,0,0,0,19,30401,10,0,0,0,0,0,"Stormcrest Eagle - On Waypoint 16 Reached - Say Line 8"),
(@ENTRY,0,10,0,40,0,100,0,18,30108,0,0,1,9,0,0,0,0,0,19,30401,10,0,0,0,0,0,"Stormcrest Eagle - On Waypoint 18 Reached - Say Line 9"),
(@ENTRY,0,12,0,40,0,100,0,22,30108,0,0,1,10,0,0,0,0,0,19,30401,10,0,0,0,0,0,"Stormcrest Eagle - On Waypoint 22 Reached - Say Line 10"),
(@ENTRY,0,13,0,40,0,100,0,24,30108,0,0,1,11,0,0,0,0,0,19,30401,10,0,0,0,0,0,"Stormcrest Eagle - On Waypoint 24 Reached - Say Line 11"),
(@ENTRY,0,14,0,40,0,100,0,25,30108,0,0,1,12,0,0,0,0,0,19,30401,10,0,0,0,0,0,"Stormcrest Eagle - On Waypoint 25 Reached - Say Line 12"),
(@ENTRY,0,15,0,40,0,100,0,26,30108,0,0,1,13,0,0,0,0,0,19,30401,10,0,0,0,0,0,"Stormcrest Eagle - On Waypoint 26 Reached - Say Line 13"),
(@ENTRY,0,16,0,40,0,100,0,28,30108,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Stormcrest Eagle - On Waypoint 28 Reached - Despawn Instant");

-- Sigrid Iceborn's Proto-Drake SAI
SET @ENTRY := 30159;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,2,40,0,100,1,9,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Sigrid Iceborn's Proto-Drake - On Waypoint 9 Reached - Despawn Instant (No Repeat)"),
(@ENTRY,0,2,0,61,0,100,1,9,0,0,0,45,1,1,0,0,0,0,11,31242,20,0,0,0,0,0,"Sigrid Iceborn's Proto-Drake - On Waypoint 9 Reached - Set Data 1 1 (No Repeat)");

-- Harrison Jones SAI
SET @ENTRY := 44860;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,62,0,100,0,11929,1,0,0,53,0,26814,0,0,9000,0,0,0,0,0,0,0,0,0,"Harrison Jones - On Gossip Option 1 Selected - Start Waypoint"),
(@ENTRY,0,1,0,19,0,100,0,27141,0,0,0,80,@ENTRY*100+00,0,0,0,0,0,1,0,0,0,0,0,0,0,"Harrison Jones - On PE Quest Accept Start Script"),
(@ENTRY,0,1,2,61,0,100,0,11929,1,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"Harrison Jones - On Gossip Option 1 Selected - Close Gossip"),
(@ENTRY,0,3,4,58,0,100,0,4,0,0,0,33,42793,0,0,0,0,0,7,0,0,0,0,0,0,0,"Harrison Jones - On Waypoint Finished - Quest Credit 'On to Something'"),
(@ENTRY,0,4,0,61,0,100,0,4,0,0,0,41,5000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Harrison Jones - On Waypoint Finished - Despawn In 5000 ms");

-- Actionlist SAI
SET @ENTRY := 4436500;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,9,0,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"talk 0"),
(@ENTRY,9,1,0,1,0,100,0,7000,7000,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"talk 1"),
(@ENTRY,9,2,0,0,0,100,0,25000,25000,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"talk 2"),
(@ENTRY,9,3,0,0,0,100,0,4000,4000,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,"talk 3"),
(@ENTRY,9,4,0,0,0,100,0,16000,16000,0,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0,"talk 4 "),
(@ENTRY,9,5,0,0,0,100,0,8000,8000,8000,8000,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0,"talk 5"),
(@ENTRY,9,6,0,0,0,100,0,6000,6000,0,0,1,6,0,0,0,0,0,1,0,0,0,0,0,0,0,"talk 6"),
(@ENTRY,9,7,0,0,0,100,0,5000,5000,0,0,1,7,0,0,0,0,0,1,0,0,0,0,0,0,0,"talk 7"),
(@ENTRY,9,8,0,0,0,100,0,10000,10000,0,0,1,8,0,0,0,0,0,1,0,0,0,0,0,0,0,"talk 8 1min21"),
(@ENTRY,9,9,0,0,0,100,0,3000,3000,0,0,45,0,1,0,0,0,0,10,59236,44608,0,0,0,0,0,"send data 1 to valkir 1min24"),
(@ENTRY,9,10,0,0,0,100,0,32000,32000,0,0,1,9,0,0,0,0,0,1,0,0,0,0,0,0,0,"talk 9"),
(@ENTRY,9,11,0,0,0,100,0,20000,20000,0,0,1,10,0,0,0,0,0,1,0,0,0,0,0,0,0,"talk 10");

-- Actionlist SAI
SET @ENTRY := 4486000;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,9,0,0,0,0,100,0,0,0,0,0,53,0,44860,0,0,0,0,1,0,0,0,0,0,0,0,"Script - Start WP 1 Harrison Jones"),
(@ENTRY,9,1,0,0,0,100,0,6000,6000,6000,6000,12,46720,5,45000,0,0,0,8,0,0,0,-8948.19,-1528.95,94.4531,4.89651,"Script - Summon Pygmy Ambusher"),
(@ENTRY,9,2,0,0,0,100,0,200,200,200,200,20,0,0,0,0,0,0,11,46720,30,0,0,0,0,0,"Script - Pygmy Attacks"),
(@ENTRY,9,3,0,0,0,100,0,10,10,10,10,9,1,0,0,0,0,0,20,205388,30,0,0,0,0,0,"Script - Activate Brazier"),
(@ENTRY,9,4,0,0,0,100,0,100,100,100,100,1,0,1,0,0,0,0,1,0,0,0,0,0,0,0,"Script - HJ Says 1"),
(@ENTRY,9,5,0,0,0,100,0,2000,2000,2000,2000,53,0,44861,0,0,0,0,1,0,0,0,0,0,0,0,"Script - HJ WP 2"),
(@ENTRY,9,6,0,0,0,100,0,100,100,100,100,1,1,1,0,0,0,0,1,0,0,0,0,0,0,0,"Script - HJ Says 2"),
(@ENTRY,9,7,0,0,0,100,0,1000,1000,1000,1000,53,0,44862,0,0,0,0,17,0,20,0,0,0,0,0,"Script - Player Go Waypoint"),
(@ENTRY,9,9,0,0,0,100,0,10,10,10,10,11,110263,2,0,0,0,0,1,0,0,0,0,0,0,0,"Script - Cast Explosion"),
(@ENTRY,9,10,0,0,0,100,0,200,200,200,200,62,1,0,0,0,0,0,17,0,20,0,-9210.32,-1554.97,65.4522,3.27979,"Script - Teleport Player");

-- Actionlist SAI
SET @ENTRY := 4488201;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,9,0,0,0,0,100,0,0,0,0,0,11,46598,0,0,0,0,0,11,44884,15,0,0,0,0,0,"enter vehicle"),
(@ENTRY,9,1,0,0,0,100,0,7000,7000,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"talk 2"),
(@ENTRY,9,3,0,0,0,100,0,0,0,0,0,97,15,15,0,0,0,0,8,0,0,0,1296.29,1206.47,58.5,0,"jump"),
(@ENTRY,9,4,0,0,0,100,0,1000,1000,0,0,37,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"die self");

-- Actionlist SAI
SET @ENTRY := 4491400;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,9,0,0,0,0,100,0,0,0,0,0,11,83835,0,0,0,0,0,1,0,0,0,0,0,0,0,"cast 83835 on self"),
(@ENTRY,9,2,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"talk 0");

-- Actionlist SAI
SET @ENTRY := 4518000;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,9,0,0,0,0,100,0,200,200,200,200,1,0,200,0,0,0,0,1,0,0,0,0,0,0,0,"Script - HJ Says 1"),
(@ENTRY,9,1,0,0,0,100,0,300,300,300,300,53,1,45180,0,0,0,0,1,0,0,0,0,0,0,0,"Script - HJ WP Start"),
(@ENTRY,9,2,0,0,0,100,0,11000,11000,11000,11000,1,1,1,0,0,0,0,1,0,0,0,0,0,0,0,"Script - HJ Says 2"),
(@ENTRY,9,4,0,0,0,100,0,600,600,600,600,53,1,45181,0,0,0,0,1,0,0,0,0,0,0,0,"Script - HJ WP Start 2"),
(@ENTRY,9,5,0,0,0,100,0,1,1,1,1,11,82929,2,0,0,0,0,1,0,0,0,0,0,0,0,"Script - HJ Jump 1"),
(@ENTRY,9,6,0,0,0,100,0,200,200,200,200,1,2,1,0,0,0,0,1,0,0,0,0,0,0,0,"Script - HJ Says 3"),
(@ENTRY,9,7,0,0,0,100,0,1,1,1,1,11,82929,2,0,0,0,0,1,0,0,0,0,0,0,0,"Script - HJ Jump 2"),
(@ENTRY,9,8,0,0,0,100,0,600,600,600,600,41,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Script - HJ Despawn");

-- Actionlist SAI
SET @ENTRY := 4529601;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,9,0,0,0,0,100,0,1000,1000,1000,1000,1,1,1,0,0,0,0,1,0,0,0,0,0,0,0,"Script - HJ Says 2"),
(@ENTRY,9,1,0,0,0,100,0,3000,3000,3000,3000,53,1,45298,0,0,0,0,1,0,0,0,0,0,0,0,"Script - HJ Start WP 3"),
(@ENTRY,9,2,0,0,0,100,0,16000,16000,16000,16000,53,1,45299,0,0,0,0,1,0,0,0,0,0,0,0,"Script - HJ Start WP 4"),
(@ENTRY,9,3,0,0,0,100,0,200,200,200,200,11,82929,2,0,0,0,0,1,0,0,0,0,0,0,0,"Script - HJ Jump 1"),
(@ENTRY,9,4,0,0,0,100,0,1000,1000,1000,1000,11,82929,2,0,0,0,0,1,0,0,0,0,0,0,0,"Script - HJ Jump 2"),
(@ENTRY,9,5,0,0,0,100,0,2000,2000,2000,2000,11,82929,2,0,0,0,0,1,0,0,0,0,0,0,0,"Script - HJ Jump 3"),
(@ENTRY,9,6,0,0,0,100,0,2000,2000,2000,2000,11,82929,2,0,0,0,0,1,0,0,0,0,0,0,0,"Script - HJ Jump 4"),
(@ENTRY,9,7,0,0,0,100,0,2000,2000,2000,2000,11,82929,2,0,0,0,0,1,0,0,0,0,0,0,0,"Script - HJ Jump 5"),
(@ENTRY,9,8,0,0,0,100,0,2000,2000,2000,2000,11,82929,2,0,0,0,0,1,0,0,0,0,0,0,0,"Script - HJ Jump 6"),
(@ENTRY,9,9,0,0,0,100,0,12000,12000,12000,12000,53,82929,45300,0,0,0,0,1,0,0,0,0,0,0,0,"Script - HJ Start WP 5");

-- Actionlist SAI
SET @ENTRY := 4533082;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,9,0,0,0,0,100,0,0,0,0,0,11,46598,0,0,0,0,0,11,44884,15,0,0,0,0,0,"Deathstalker Rane Yorick - On Script - Cast 'Ride Vehicle Hardcoded'"),
(@ENTRY,9,1,0,0,0,100,0,7000,7000,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Deathstalker Rane Yorick - On Script - Say Line 2"),
(@ENTRY,9,3,0,0,0,100,0,0,0,0,0,97,15,15,0,0,0,0,8,0,0,0,1296.29,1206.47,58.5,0,"Deathstalker Rane Yorick - On Script - Jump To Pos"),
(@ENTRY,9,4,0,0,0,100,0,1000,1000,0,0,37,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Deathstalker Rane Yorick - On Script - Kill Self");

-- Northeastern Pool Credit SAI
SET @ENTRY := 53191;
UPDATE `creature_template` SET `AIName`="" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;

-- Injured Druid of the Talon SAI
SET @ENTRY := 53243;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,64,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"molten front quests fix");

-- Hyjal Wisp SAI
SET @ENTRY := 53083;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,11,0,100,0,0,0,0,0,53,0,530830,0,29143,2000,0,1,0,0,0,0,0,0,0,"molten front quests fix"),
(@ENTRY,0,1,0,40,0,100,0,4,530830,0,0,70,2,0,0,0,0,0,20,208899,20,0,0,0,0,0,"molten front quests fix");

-- Goldwing Hawk SAI
SET @ENTRY := 52594;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,64,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"molten front quests fix");

-- Alpine Songbird SAI
SET @ENTRY := 52595;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,64,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"molten front quests fix");

-- Scarlet Corpse SAI
SET @ENTRY := 49340;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,8,0,100,0,91942,0,0,0,45,0,3,0,0,0,0,19,49337,10,0,0,0,0,0,"on spellhit 91942 set data 3 to darnell"),
(@ENTRY,0,2,0,61,0,100,0,0,0,0,0,11,46598,0,0,0,0,0,19,49337,0,0,0,0,0,0,"Jump on darnell"),
(@ENTRY,0,3,0,38,0,100,0,0,1,0,0,37,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"die self");

-- Skylord Omnuron SAI
SET @ENTRY := 52490;
UPDATE `creature_template` SET `AIName`="" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;

-- Forest Owl SAI
SET @ENTRY := 52596;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,64,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"molten front quests fix");

-- Waters of Farseeing SAI
SET @ENTRY := 207414;
UPDATE `gameobject_template` SET `AIName`="SmartGameObjectAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,1,1,0,61,0,100,0,0,0,0,0,28,94687,0,0,0,0,0,7,0,0,0,0,0,0,0,"Waters of Farseeing - On link - Remove Waters of Farseeing");

-- Central Pool Credit SAI
SET @ENTRY := 53192;
UPDATE `creature_template` SET `AIName`="" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;

-- Waters of Farseeing SAI
SET @ENTRY := 207416;
UPDATE `gameobject_template` SET `AIName`="SmartGameObjectAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,1,1,0,61,0,100,0,0,0,0,0,28,94687,0,0,0,0,0,7,0,0,0,0,0,0,0,"Waters of Farseeing - On link - Remove Waters of Farseeing");

-- Actionlist SAI
SET @ENTRY := 4246500;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,9,0,0,0,0,100,0,0,0,0,0,12,43809,5,980000,0,0,0,8,0,0,0,2339.98,195.193,179.936,2.95537,"Script - Summon Torunscar"),
(@ENTRY,9,1,0,0,0,100,0,1000,1000,1000,1000,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Script - Therazane Says 1"),
(@ENTRY,9,2,0,0,0,100,0,4000,4000,4000,4000,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Script - Therazane Says 2"),
(@ENTRY,9,3,0,0,0,100,0,4000,4000,4000,4000,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Script - Therazane Says 3"),
(@ENTRY,9,4,0,0,0,100,0,4000,4000,4000,4000,1,0,0,0,0,0,0,19,43809,40,0,0,0,0,0,"Script - Torunscar Says 1"),
(@ENTRY,9,5,0,0,0,100,0,4000,4000,4000,4000,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,"Script - Therazane Says 4"),
(@ENTRY,9,6,0,0,0,100,0,4000,4000,4000,4000,1,1,0,0,0,0,0,19,43809,40,0,0,0,0,0,"Script -Torunscar Says 2"),
(@ENTRY,9,7,0,0,0,100,0,4000,4000,4000,4000,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0,"Script - Therazane Says 5"),
(@ENTRY,9,8,0,0,0,100,0,4000,4000,4000,4000,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0,"Script - Therazane Says 6"),
(@ENTRY,9,9,0,0,0,100,0,4000,4000,4000,4000,1,6,0,0,0,0,0,1,0,0,0,0,0,0,0,"Script - Therazane Says 7"),
(@ENTRY,9,10,0,0,0,100,0,4000,4000,4000,4000,1,7,0,0,0,0,0,1,0,0,0,0,0,0,0,"Script - Therazane Says 8"),
(@ENTRY,9,11,0,0,0,100,0,4000,4000,4000,4000,1,2,0,0,0,0,0,19,43809,40,0,0,0,0,0,"Script - Torunscar Says 3"),
(@ENTRY,9,12,0,0,0,100,0,4000,4000,4000,4000,1,8,0,0,0,0,0,1,0,0,0,0,0,0,0,"Script - Therazane Says 9");

-- Theresa SAI
SET @ENTRY := 5697;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,61,0,100,0,0,0,0,0,71,0,0,2717,0,0,0,1,0,0,0,0,0,0,0,"Theresa - On Data Set  - Equip Bottle"),
(@ENTRY,0,2,3,40,0,100,0,54,5697,0,0,54,17000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Theresa - On Reached WP9  - Pause WP"),
(@ENTRY,0,3,4,61,0,100,0,0,0,0,0,1,1,10000,0,0,0,0,1,0,0,0,0,0,0,0,"Theresa - On Reached WP9  - Say Line 1"),
(@ENTRY,0,4,13,61,0,100,0,0,0,0,0,71,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Theresa - On Reached WP9  - Unequip Bottle"),
(@ENTRY,0,5,6,52,0,100,0,1,5697,0,0,1,0,3000,0,0,0,0,19,4607,0,0,0,0,0,0,"Theresa - On Text Over  - Say"),
(@ENTRY,0,6,0,61,0,100,0,0,0,0,0,71,0,0,2717,0,0,0,1,0,0,0,0,0,0,0,"Theresa - On Text Over  - Equip Bottle"),
(@ENTRY,0,7,8,40,0,100,0,109,5697,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,4.27606,"Theresa - On Reached WP18  - Set Orientation"),
(@ENTRY,0,8,9,61,0,100,0,0,0,0,0,1,2,5000,0,0,0,0,1,0,0,0,0,0,0,0,"Theresa - On Reached WP18  - Say Line 1"),
(@ENTRY,0,9,14,61,0,100,0,0,0,0,0,71,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Theresa - On Reached WP18 - Unequip Bottle"),
(@ENTRY,0,10,15,52,0,100,0,2,5697,0,0,1,1,0,0,0,0,0,19,5696,0,0,0,0,0,0,"Theresa - On Text Over  - Say"),
(@ENTRY,0,11,12,52,0,100,0,0,4607,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Theresa - On Text Over  - Say"),
(@ENTRY,0,12,0,61,0,100,0,0,0,0,0,91,8,0,0,0,0,0,1,0,0,0,0,0,0,0,"Theresa - On Text Over - Stand"),
(@ENTRY,0,13,0,61,0,100,0,0,0,0,0,90,8,0,0,0,0,0,1,0,0,0,0,0,0,0,"Theresa - On Reached WP9 - Kneel"),
(@ENTRY,0,14,0,61,0,100,0,0,0,0,0,90,8,0,0,0,0,0,1,0,0,0,0,0,0,0,"Theresa - On Reached WP18 - Kneel"),
(@ENTRY,0,15,0,61,0,100,0,0,0,0,0,91,8,0,0,0,0,0,1,0,0,0,0,0,0,0,"Theresa - On Text Over - Stand");

-- Deldren Ravenelm SAI
SET @ENTRY := 52921;
UPDATE `creature_template` SET `AIName`="" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;

-- Northwestern Pool Credit SAI
SET @ENTRY := 53190;
UPDATE `creature_template` SET `AIName`="" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;


-- Windcaller Voramus SAI
SET @ENTRY := 53217;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,64,0,100,0,0,0,0,0,53,1,533550,0,29206,2000,1,1,0,0,0,0,0,0,0,"molten front quests fix"),
(@ENTRY,0,1,0,64,0,100,0,0,0,0,0,72,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"molten front quests fix"),
(@ENTRY,0,2,0,64,0,100,0,0,0,0,0,81,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"molten front quests fix");

-- Windcaller Nordrala SAI
SET @ENTRY := 53355;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,64,0,100,0,0,0,0,0,53,1,533550,0,29206,2000,1,1,0,0,0,0,0,0,0,"molten front quests fix"),
(@ENTRY,0,1,0,64,0,100,0,0,0,0,0,72,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"molten front quests fix"),
(@ENTRY,0,2,0,64,0,100,0,0,0,0,0,81,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"molten front quests fix");

-- Darnell SAI
SET @ENTRY := 49141;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,54,0,100,0,0,0,0,0,80,@ENTRY*100+00,0,0,0,0,0,1,0,0,0,0,0,0,0,"On summoned call time action 4914100"),
(@ENTRY,0,1,0,38,0,100,1,0,1,0,0,80,@ENTRY*100+01,0,0,0,0,0,1,0,0,0,0,0,0,0,"On data set do event 4914101"),
(@ENTRY,0,3,0,38,0,100,0,0,2,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,"On data set 2 despawn self");

-- Ffexk the Dunestalker SAI
SET @ENTRY := 50897;
UPDATE `creature_template` SET `AIName`="" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;

-- Desiccated Magus
SET @ENTRY := 44315;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,0,0,3400,4700,11,11538,64,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Frostbolt'),
(@ENTRY,0,1,0,9,0,100,0,0,8,15000,25000,11,79847,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Blast Wave on Close');

-- Sergeant Houser SAI
SET @ENTRY := 5662;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,1,0,100,0,7000,15000,15000,22000,54,5000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Sergeant Houser - OOC  - Pause WP"),
(@ENTRY,0,1,0,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Sergeant Houser - OOC  - Say");

-- Zangen Stonehoof SAI
SET @ENTRY := 4721;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,2,40,0,100,0,1,4721,0,0,54,25000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Zangen Stonehoof - On Reached WP1 - Pause WP"),
(@ENTRY,0,2,3,61,0,100,0,0,0,0,0,80,@ENTRY*100+00,2,0,0,0,0,1,0,0,0,0,0,0,0,"Zangen Stonehoof - Linked with Previous Event - Run Script"),
(@ENTRY,0,3,0,61,0,100,0,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Zangen Stonehoof - Linked with Previous Event - Set Phase 2"),
(@ENTRY,0,4,5,40,0,100,0,2,4721,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,4.74729,"Zangen Stonehoof - On Reached WP2 - Set Orientation"),
(@ENTRY,0,5,0,61,0,100,0,0,0,0,0,22,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Zangen Stonehoof - Linked with Previous Event - Set Phase 1"),
(@ENTRY,0,6,0,1,2,100,0,0,0,3125,3125,4,6675,0,0,0,0,0,1,0,0,0,0,0,0,0,"Zangen Stonehoof - OOC (Phase 2) - Play Sound");

-- Caretaker Dilandrus SAI
SET @ENTRY := 16856;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,40,0,100,0,5,16856,0,0,80,@ENTRY*100+01,2,0,0,0,0,1,0,0,0,0,0,0,0,"Caretaker Dilandrus - On Waypoint 5 Reached - Run Script"),
(@ENTRY,0,2,0,40,0,100,0,7,16856,0,0,80,@ENTRY*100+01,2,0,0,0,0,1,0,0,0,0,0,0,0,"Caretaker Dilandrus - On Waypoint 7 Reached - Run Script"),
(@ENTRY,0,3,0,40,0,100,0,11,16856,0,0,80,@ENTRY*100+01,2,0,0,0,0,1,0,0,0,0,0,0,0,"Caretaker Dilandrus - On Waypoint 11 Reached - Run Script"),
(@ENTRY,0,4,0,40,0,100,0,15,16856,0,0,80,@ENTRY*100+01,2,0,0,0,0,1,0,0,0,0,0,0,0,"Caretaker Dilandrus - On Waypoint 15 Reached - Run Script"),
(@ENTRY,0,5,0,40,0,100,0,20,16856,0,0,80,@ENTRY*100+01,2,0,0,0,0,1,0,0,0,0,0,0,0,"Caretaker Dilandrus - On Waypoint 20 Reached - Run Script"),
(@ENTRY,0,6,0,40,0,100,0,24,16856,0,0,80,@ENTRY*100+01,2,0,0,0,0,1,0,0,0,0,0,0,0,"Caretaker Dilandrus - On Waypoint 24 Reached - Run Script"),
(@ENTRY,0,7,0,40,0,100,0,30,16856,0,0,80,@ENTRY*100+01,2,0,0,0,0,1,0,0,0,0,0,0,0,"Caretaker Dilandrus - On Waypoint 30 Reached - Run Script"),
(@ENTRY,0,8,0,40,0,100,0,33,16856,0,0,54,300000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Caretaker Dilandrus - On Waypoint 33 Reached - Pause Waypoint");

-- Protectorate Demolitionist SAI
SET @ENTRY := 20802;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,54,0,100,0,0,0,0,0,1,0,4000,0,0,0,0,1,0,0,0,0,0,0,0,"Protectorate Demolitionist - Just Summoned - Say 0"),
(@ENTRY,0,2,3,40,0,100,0,3,20802,0,0,54,4000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Protectorate Demolitionist - Reached WP 3 - Pause Wp"),
(@ENTRY,0,3,0,61,0,100,0,0,0,0,0,1,1,5000,0,0,0,0,1,0,0,0,0,0,0,0,"Protectorate Demolitionist - Link Event - Say 1"),
(@ENTRY,0,4,5,40,0,100,0,5,20802,0,0,54,4000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Protectorate Demolitionist - Reached WP 5 - Pause Wp"),
(@ENTRY,0,5,0,61,0,100,0,0,0,0,0,1,2,4000,0,0,0,0,1,0,0,0,0,0,0,0,"Protectorate Demolitionist - Link Event - Say 2"),
(@ENTRY,0,6,7,40,0,100,0,7,20802,0,0,54,10000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Protectorate Demolitionist - Reached WP 7 - Pause Wp"),
(@ENTRY,0,7,0,61,0,100,0,0,0,0,0,80,@ENTRY*100+00,0,0,0,0,0,1,0,0,0,0,0,0,0,"Protectorate Demolitionist - Link - Start Script"),
(@ENTRY,0,8,9,40,0,100,0,8,20802,0,0,54,10000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Protectorate Demolitionist - Reached WP 8 - Pause Wp"),
(@ENTRY,0,9,10,61,0,100,0,0,0,0,0,1,5,6000,0,0,0,0,1,0,0,0,0,0,0,0,"Protectorate Demolitionist - Link - Say 5"),
(@ENTRY,0,10,0,61,0,100,0,0,0,0,0,15,10406,0,0,0,0,0,21,15,0,0,0,0,0,0,"Protectorate Demolitionist - Link - Complete Quest"),
(@ENTRY,0,11,12,52,0,100,0,5,20802,0,0,11,35517,0,0,0,0,0,1,0,0,0,0,0,0,0,"Protectorate Demolitionist - Text Over - cast teleportaion visual"),
(@ENTRY,0,12,0,61,0,100,0,0,0,0,0,41,2000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Protectorate Demolitionist - Text Over - despawn"),
(@ENTRY,0,13,0,4,0,100,0,0,0,0,0,1,6,0,0,0,0,0,1,0,0,0,0,0,0,0,"Protectorate Demolitionist - On aggro - talk");


-- Oronok Torn-heart SAI
SET @ENTRY := 21685;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,38,0,100,0,1,1,0,0,81,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Oronok Torn-heart - On Data Set 1 1 - Set NPC Flags Gossip"),
(@ENTRY,0,1,2,62,0,100,0,8350,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,"Oronok Torn-heart - On Gossip Select - Store Targetlist"),
(@ENTRY,0,2,3,61,0,100,0,0,0,0,0,81,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Oronok Torn-heart - On Gossip Select - Set NPC Flags None"),
(@ENTRY,0,3,4,61,0,100,0,0,0,0,0,45,1,1,0,0,0,0,19,21686,0,0,0,0,0,0,"Oronok Torn-heart - On Gossip Select - Set Data"),
(@ENTRY,0,4,5,61,0,100,0,0,0,0,0,45,1,1,0,0,0,0,19,21687,0,0,0,0,0,0,"Oronok Torn-heart - On Gossip Select - Set Data"),
(@ENTRY,0,6,7,40,0,100,0,12,21685,0,0,101,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Oronok Torn-heart - On Reached WP12 - Set Home Position"),
(@ENTRY,0,7,8,61,0,100,0,0,0,0,0,19,768,0,0,0,0,0,1,0,0,0,0,0,0,0,"Oronok Torn-heart - On Reached WP12 - Set Unit Flags"),
(@ENTRY,0,8,9,61,0,100,0,0,0,0,0,2,495,0,0,0,0,0,1,0,0,0,0,0,0,0,"Oronok Torn-heart - On Reached WP12 - Set Faction"),
(@ENTRY,0,9,10,61,0,100,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Oronok Torn-heart - On Reached WP12 - Set Aggresive"),
(@ENTRY,0,10,0,61,0,100,0,0,0,0,0,45,1,1,0,0,0,0,19,21181,0,0,0,0,0,0,"Oronok Torn-heart - On Reached WP12 - Set Data on Cyrukh the Firelord <The Dirge of Karabor>"),
(@ENTRY,0,11,0,0,0,100,0,0,0,8000,11000,11,16006,0,0,0,0,0,2,0,0,0,0,0,0,0,"Oronok Torn-heart - IC - Cast Chain Lightning"),
(@ENTRY,0,12,0,0,0,100,0,0,0,6000,8000,11,12548,0,0,0,0,0,2,0,0,0,0,0,0,0,"Oronok Torn-heart - IC - Cast Frost Shock"),
(@ENTRY,0,13,0,2,0,100,0,0,40,5000,8000,11,12491,0,0,0,0,0,1,0,0,0,0,0,0,0,"Oronok Torn-heart - On Less than 40% HP - Cast Healing Wave"),
(@ENTRY,0,14,0,38,0,100,0,5,5,0,0,11,12491,0,0,0,0,0,19,21687,0,0,0,0,0,0,"Oronok Torn-heart - On Data Set - Cast Healing Wave"),
(@ENTRY,0,15,0,38,0,100,0,6,6,0,0,71,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Oronok Torn-heart - On Data Set 6 6 - Unequip weapon"),
(@ENTRY,0,18,0,40,0,100,0,1,@ENTRY*100+00,0,0,66,0,0,0,0,0,0,19,21024,0,0,0,0,0,0,"Oronok Torn-heart - On Reached WP1 (Path 2) - Set Orientation");

-- Anchorite Yazmina SAI
SET @ENTRY := 23734;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,40,0,5,0,0,0,0,0,87,@ENTRY*100+00,@ENTRY*100+01,@ENTRY*100+02,@ENTRY*100+03,0,0,1,0,0,0,0,0,0,0,"Anchorite Yazmina <First Aid Trainer> - On Reached WP - Run Random Script");

-- Iron Rune Construct SAI
SET @ENTRY := 24825;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,54,0,100,0,0,0,0,0,75,44643,0,0,0,0,0,23,0,0,0,0,0,0,0,"Iron Rune Construct - Just Summoned - Add aura to owner"),
(@ENTRY,0,1,0,28,0,100,0,0,0,0,0,28,44643,0,0,0,0,0,23,0,0,0,0,0,0,0,"Iron Rune Construct - Passenger removed - remove aura from owner"),
(@ENTRY,0,2,0,8,0,100,0,44626,0,5000,5000,80,2482600,0,0,0,0,0,19,24826,1,0,0,0,0,0,"Iron Rune Construct - On spellhit  - Action List"),
(@ENTRY,0,3,0,8,0,100,0,44626,0,5000,5000,80,2482700,0,0,0,0,0,19,24827,1,0,0,0,0,0,"Iron Rune Construct - On spellhit  - Action List"),
(@ENTRY,0,4,0,8,0,100,0,44626,0,5000,5000,80,2482800,0,0,0,0,0,19,24828,1,0,0,0,0,0,"Iron Rune Construct - On spellhit  - Action List"),
(@ENTRY,0,5,0,8,0,100,0,44626,0,5000,5000,80,2483100,0,0,0,0,0,19,24831,1,0,0,0,0,0,"Iron Rune Construct - On spellhit  - Action List"),
(@ENTRY,0,6,0,8,0,100,0,44626,0,5000,5000,80,2482900,0,0,0,0,0,19,24829,1,0,0,0,0,0,"Iron Rune Construct - On spellhit  - Action List"),
(@ENTRY,0,7,0,8,0,100,0,44626,0,5000,5000,80,2483200,0,0,0,0,0,19,24832,1,0,0,0,0,0,"Iron Rune Construct - On spellhit  - Action List"),
(@ENTRY,0,14,0,58,0,100,0,0,0,0,0,28,44626,0,0,0,0,0,1,0,0,0,0,0,0,0,"Iron Rune Construct - On waypoint end - Remove aura");

-- Alliance Emissary SAI
SET @ENTRY := 27492;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,2,40,0,100,0,2,27492,0,0,54,30000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Alliance Emissary - On reached WP2 - Pause Event"),
(@ENTRY,0,2,0,61,0,100,0,0,0,0,0,80,@ENTRY*100+00,2,0,0,0,0,1,0,0,0,0,0,0,0,"Alliance Emissary - Link - Run script");

-- Crusader Lamoof SAI
SET @ENTRY := 28142;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,54,0,100,0,0,0,0,0,11,50681,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crusader Lamoof - On Just Summoned - Cast 'Bleeding Out'"),
(@ENTRY,0,1,2,61,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,"Crusader Lamoof - On Waypoint 5 Reached - Store Targetlist (No Repeat)"),
(@ENTRY,0,2,3,61,0,100,0,0,0,0,0,29,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Crusader Lamoof - On Waypoint 5 Reached - Start Follow Invoker (No Repeat)"),
(@ENTRY,0,3,4,61,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crusader Lamoof - On Waypoint 5 Reached - Set Event Phase 1 (No Repeat)"),
(@ENTRY,0,4,0,61,0,100,0,0,0,0,0,91,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crusader Lamoof - On Waypoint 5 Reached - Remove Flag Standstate Sit Down (No Repeat)"),
(@ENTRY,0,5,0,23,1,100,1,50681,0,0,0,80,@ENTRY*100+00,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crusader Lamoof - On Has Aura 'Bleeding Out' - Run Script (No Repeat)"),
(@ENTRY,0,6,7,40,0,100,1,5,0,0,0,90,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crusader Lamoof - On Waypoint 5 Reached - Set Flag Standstate Sit Down (No Repeat)"),
(@ENTRY,0,7,0,61,0,100,0,0,0,0,0,41,20000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crusader Lamoof - On Spellhit 'Resuscitate' - Despawn In 20000 ms"),
(@ENTRY,0,8,9,8,1,100,0,50669,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crusader Lamoof - On Spellhit 'Quest Credit' - Set Event Phase 2 (Phase 1)"),
(@ENTRY,0,9,10,61,0,100,0,0,0,0,0,11,50683,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crusader Lamoof - On Spellhit 'Quest Credit' - Cast 'Kill Credit Lamoof 01' (Phase 1)"),
(@ENTRY,0,10,11,61,0,100,0,0,0,0,0,11,50723,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crusader Lamoof - On Spellhit 'Quest Credit' - Cast 'Strip Aura Lamoof 01' (Phase 1)"),
(@ENTRY,0,11,12,61,0,100,0,0,0,0,0,86,50684,0,12,1,0,0,1,0,0,0,0,0,0,0,"Crusader Lamoof - On Spellhit 'Resuscitate' - Cross Cast 'Lamoof Kill Credit'"),
(@ENTRY,0,12,13,61,0,100,0,0,0,0,0,86,50722,0,12,1,0,0,1,0,0,0,0,0,0,0,"Crusader Lamoof - On Spellhit 'Resuscitate' - Cross Cast 'Strip Aura Lamoof'"),
(@ENTRY,0,13,14,61,0,100,0,0,0,0,0,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"Crusader Lamoof - On Spellhit 'Resuscitate' - Stop Follow "),
(@ENTRY,0,14,15,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crusader Lamoof - On Spellhit 'Resuscitate' - Say Line 0"),
(@ENTRY,0,16,0,61,0,100,0,0,0,0,0,83,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crusader Lamoof - On Spellhit 'Resuscitate' - Remove Npc Flag Gossip");

-- D16 Propelled Delivery Device SAI
SET @ENTRY := 30477;
UPDATE `creature_template` SET `AIName`="" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;

-- Highlord Tirion Fordring SAI
SET @ENTRY := 35361;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,3,0,40,0,100,0,5,@ENTRY*100+01,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - On Reached WP 5 (Path 1) - Despawn"),
(@ENTRY,0,4,0,40,0,100,0,7,@ENTRY*100+02,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - On Reached WP 7 (Path 2) - Despawn"),
(@ENTRY,0,5,0,40,0,100,0,53,@ENTRY*100+03,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - On Reached WP 53 (Path 3) - Despawn"),
(@ENTRY,0,6,7,40,0,100,0,26,@ENTRY*100+03,0,0,54,76000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - On Reached WP 26 (Path 3) - Pause WP"),
(@ENTRY,0,7,0,61,0,100,0,0,0,0,0,80,@ENTRY*100+00,2,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - On Reached WP 26 (Path 3) - Run Script");

-- Dorius Stonetender SAI
SET @ENTRY := 8284;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,58,0,100,0,12,0,0,0,50,175704,60000,0,0,0,0,19,8284,0,0,0,0,0,0,"Singed Letter was dropped by Dorius");

-- Melizza Brimbuzzle SAI
SET @ENTRY := 12277;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,61,0,100,0,6132,0,0,0,81,0,0,0,0,0,0,10,0,0,0,0,0,0,0,"Melizza Brimbuzzle - On Quest 'Get Me Out of Here!' Taken - Set Npc Flag "),
(@ENTRY,0,2,0,40,0,100,0,3,@ENTRY*100+00,0,0,1,0,0,0,0,0,0,21,20,0,0,0,0,0,0,"Melizza Brimbuzzle - On Waypoint 3 Reached - Say Line 0"),
(@ENTRY,0,3,4,40,0,100,0,58,@ENTRY*100+00,0,0,15,6132,0,0,0,0,0,17,0,30,0,0,0,0,0,"Melizza Brimbuzzle - On Waypoint 58 Reached - Quest Credit 'Get Me Out of Here!'"),
(@ENTRY,0,4,5,61,0,100,0,58,@ENTRY*100+00,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Melizza Brimbuzzle - On Waypoint 58 Reached - Say Line 1"),
(@ENTRY,0,6,0,61,0,100,0,58,@ENTRY*100+00,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Melizza Brimbuzzle - On Waypoint 58 Reached - Set Active On"),
(@ENTRY,0,7,8,40,0,100,0,69,@ENTRY*100+01,0,0,54,10000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Melizza Brimbuzzle - On Waypoint 69 Reached - Pause Waypoint"),
(@ENTRY,0,8,0,61,0,100,0,69,@ENTRY*100+01,0,0,80,@ENTRY*100+00,0,0,0,0,0,1,0,0,0,0,0,0,0,"Melizza Brimbuzzle - On Waypoint 69 Reached - Run Script"),
(@ENTRY,0,9,0,40,0,100,0,93,@ENTRY*100+01,0,0,41,3000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Melizza Brimbuzzle - On Waypoint 93 Reached - Despawn In 3000 ms"),
(@ENTRY,0,10,0,11,0,100,0,0,0,0,0,81,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Melizza Brimbuzzle - On Respawn - Set Npc Flag Questgiver"),
(@ENTRY,0,11,0,40,0,100,1,57,@ENTRY*100+00,0,0,80,@ENTRY*100+01,0,0,0,0,0,1,0,0,0,0,0,0,0,"Melizza Brimbuzzle - On Waypoint 57 Reached - Run Script (No Repeat)");

-- Vagath SAI
SET @ENTRY := 21768;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,40,0,100,0,2,21768,0,0,54,15000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Vagath - On Reached WP2 - Pause WP"),
(@ENTRY,0,2,3,40,0,100,0,4,21768,0,0,41,0,0,0,0,0,0,9,21776,0,100,0,0,0,0,"Vagath - On Reached WP4 - Despawn Illidari Temptress"),
(@ENTRY,0,3,0,61,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Vagath - On Reached WP4 - Despawn");

-- Akama SAI
SET @ENTRY := 22990;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,40,0,100,0,2,0,0,0,80,@ENTRY*100+00,2,0,0,0,0,1,0,0,0,0,0,0,0,"Akama - On waypoint2 - Start Script"),
(@ENTRY,0,2,0,40,0,100,0,6,0,0,0,11,39932,0,0,0,0,0,1,0,0,0,0,0,0,0,"Akama - On waypoint3 - Cast Spell"),
(@ENTRY,0,3,0,0,0,100,0,1000,1000,4000,4000,11,39945,2,0,0,0,0,2,0,0,0,0,0,0,0,"Akama - IC - Cast Spell");


-- Lady Sinestra SAI
SET @ENTRY := 23284;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,40,0,100,0,1,@ENTRY*100+00,0,0,80,@ENTRY*100+00,0,0,0,0,0,1,0,0,0,0,0,0,0,"Lady Sinestra - On wp1 - Action list"),
(@ENTRY,0,2,0,40,0,100,0,4,@ENTRY*100+00,0,0,80,@ENTRY*100+01,0,0,0,0,0,1,0,0,0,0,0,0,0,"Lady Sinestra - On wp4 - Action list"),
(@ENTRY,0,3,0,58,0,100,0,7,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Lady Sinestra - On wp Ended - Despawn");

-- The Lich King SAI
SET @ENTRY := 37857;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,40,0,100,0,11,37857,0,0,80,@ENTRY*100+00,2,0,0,0,0,1,0,0,0,0,0,0,0,"The Lich King - On Reached WP11 - Run Script");

-- Highlord Tirion Fordring SAI
SET @ENTRY := 32239;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,62,0,100,0,10200,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Highlord Tirion Fordring - On Gossip Select - Close Gossip Menu"),
(@ENTRY,0,1,2,61,0,100,0,0,0,0,0,81,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - On Gossip Select - Set Npc Flags"),
(@ENTRY,0,2,3,61,0,100,0,0,0,0,0,45,1,1,0,0,0,0,9,32241,0,200,0,0,0,0,"Highlord Tirion Fordring - On Gossip Select - Set Data Disguised Crusader"),
(@ENTRY,0,3,4,61,0,100,0,0,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - On Gossip Select - Set Emote State 0"),
(@ENTRY,0,4,5,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - On Gossip Select - Say Line 0"),
(@ENTRY,0,6,0,61,0,100,0,0,0,0,0,91,35536,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - On Gossip Select - Start WP"),
(@ENTRY,0,7,8,40,0,100,1,5,32239,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - On Reached WP5 - Say Line 1"),
(@ENTRY,0,8,0,61,0,100,0,0,0,0,0,12,32272,1,300000,0,0,0,8,0,0,0,6131.26,2763.73,573.997,5.13127,"Highlord Tirion Fordring - On Reached WP5 - Summon High Invoker Basaleph"),
(@ENTRY,0,9,0,40,0,100,1,13,32239,0,0,80,@ENTRY*100+00,2,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - On Reached WP13 - Run Script"),
(@ENTRY,0,11,13,40,0,100,1,3,@ENTRY*100+00,0,0,71,0,0,13262,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - On Reached WP3 (Path2) - Equip Item"),
(@ENTRY,0,12,0,38,0,100,0,2,2,0,0,11,60456,0,0,0,0,0,19,32184,0,0,0,0,0,0,"Highlord Tirion Fordring - On Data Set - Cast Tirion Smashes Heart"),
(@ENTRY,0,13,0,61,0,100,0,0,0,0,0,101,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - On Reached WP3 (Path 2) - Set Home Position"),
(@ENTRY,0,14,15,38,0,100,0,3,3,0,0,66,0,0,0,0,0,0,19,32184,0,0,0,0,0,0,"Highlord Tirion Fordring - On Data Set - Set Orientation"),
(@ENTRY,0,15,0,61,0,100,0,0,0,0,0,90,7,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - On Data Set - Set Bytes 1"),
(@ENTRY,0,16,0,38,0,100,0,6,6,0,0,41,60000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - On Data Set - Despawn");

-- Archmage Rhydian SAI
SET @ENTRY := 33696;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,38,0,100,0,1,1,0,0,1,0,2000,0,0,0,0,1,0,0,0,0,0,0,0,"Archmage Rhydian - On Data Set - Say Line 0"),
(@ENTRY,0,2,3,40,0,100,0,8,33696,0,0,54,8000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Archmage Rhydian - On Reached WP8 - Pause WP"),
(@ENTRY,0,3,0,61,0,100,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Archmage Rhydian - On Reached WP8 - Say Line 1"),
(@ENTRY,0,4,0,40,0,100,0,10,33696,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,5.91667,"Archmage Rhydian - On Reached WP10 - Set Orientation");

-- Automated Lab Transport SAI
SET @ENTRY := 36098;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,38,0,100,1,1,1,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"q14310 - Automated Lab Transport despawn self on activate event"),
(@ENTRY,0,1,2,54,0,100,1,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"q14310 - Automated Lab Transport set phase 1 on event spawn"),
(@ENTRY,0,2,0,61,0,100,0,0,0,0,0,44,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"q14310 - Automated Lab Transport set phasemask"),
(@ENTRY,0,4,5,40,0,100,0,44,36098,0,0,11,68379,3,0,0,0,0,18,15,0,0,0,0,0,0,"q14310 - Automated Lab Transport on waypoint END cast killcredit"),
(@ENTRY,0,5,6,61,0,100,0,0,0,0,0,41,5000,0,0,0,0,0,1,0,0,0,0,0,0,0,"q14310 - Automated Lab Transport on waypoint END Despawn"),
(@ENTRY,0,6,0,61,0,100,0,0,0,0,0,45,1,1,0,0,0,0,11,36061,15,0,0,0,0,0,"q14310 - Automated Lab Transport on waypoint END activate Research Intern talking");

-- The Lich King SAI
SET @ENTRY := 28498;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,2,40,0,100,0,2,0,0,0,54,83000,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Lich King - On WP 2 - Pause movement 83 seconds"),
(@ENTRY,0,2,0,61,0,100,0,0,0,0,0,80,@ENTRY*100+00,2,0,0,0,0,1,0,0,0,0,0,0,0,"The Lich King - On WP 2 - Run script"),
(@ENTRY,0,3,4,40,0,100,0,3,0,0,0,45,0,2,0,0,0,0,10,127495,0,0,0,0,0,0,"The Lich King - On WP 3 - Despawn"),
(@ENTRY,0,4,0,61,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Lich King - On WP 3 - Despawn"),
(@ENTRY,0,5,0,54,0,100,0,0,0,0,0,53,0,@ENTRY*100+00,0,0,0,0,1,0,0,0,0,0,0,0,"The Lich King - On Just Summoned - Start Waypoint"),
(@ENTRY,0,6,0,40,0,100,0,4,@ENTRY*100+00,0,0,1,7,0,0,0,0,0,19,28998,0,0,0,0,0,0,"The Lich King - Reached WP4 - Say"),
(@ENTRY,0,7,0,40,0,100,0,8,@ENTRY*100+00,0,0,80,@ENTRY*100+01,2,0,0,0,0,1,0,0,0,0,0,0,0,"The Lich King - Reached WP8 - Run Script"),
(@ENTRY,0,8,9,40,0,100,0,4,@ENTRY*100+01,0,0,45,2,2,0,0,0,0,10,98914,28960,0,0,0,0,0,"The Lich King - Reached WP4 (Path 2) - Set Data"),
(@ENTRY,0,9,0,61,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Lich King - Reached WP4 (Path 2) - Despawn");

-- Warmage Preston SAI
SET @ENTRY := 25732;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,61,0,100,0,1,1,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Warmage Preston - On Data Set 1 1 - Set Active On"),
(@ENTRY,0,2,0,40,0,100,0,1,25732,0,0,54,10000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Warmage Moran - On Waypoint 1 Reached - Pause Waypoint");

-- Shadow's Edge SAI
SET @ENTRY := 38191;
UPDATE `creature_template` SET `AIName`="" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;

-- Borak, Son of Oronok SAI
SET @ENTRY := 21686;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,2,40,0,100,0,18,21686,0,0,101,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Borak, Son of Oronok - On Reached WP18 - Set Home Position"),
(@ENTRY,0,2,3,61,0,100,0,0,0,0,0,2,495,0,0,0,0,0,1,0,0,0,0,0,0,0,"Borak, Son of Oronok - On Reached WP18 - Set Faction"),
(@ENTRY,0,3,4,61,0,100,0,0,0,0,0,19,768,0,0,0,0,0,1,0,0,0,0,0,0,0,"Borak, Son of Oronok - On Reached WP18 - Set Unit Flags"),
(@ENTRY,0,4,0,61,0,100,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Borak, Son of Oronok - On Reached WP18 - Set Aggresive"),
(@ENTRY,0,5,0,38,0,100,0,2,2,0,0,49,0,0,0,0,0,0,19,21181,0,0,0,0,0,0,"Borak, Son of Oronok - On Data Set - Start Attack"),
(@ENTRY,0,6,0,9,0,100,0,0,5,3000,6000,11,27611,0,0,0,0,0,1,0,0,0,0,0,0,0,"Borak, Son of Oronok - On Range - Cast Eviscerate"),
(@ENTRY,0,7,0,9,0,100,0,0,5,15000,18000,11,30470,0,0,0,0,0,1,0,0,0,0,0,0,0,"Borak, Son of Oronok - On Range - Cast Slice and Dice"),
(@ENTRY,0,8,0,38,0,100,0,3,3,0,0,71,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Borak, Son of Oronok - On Data Set 3 3 - Unequip weapon"),
(@ENTRY,0,10,0,40,0,100,0,1,@ENTRY*100+00,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,1.66084,"Borak, Son of Oronok - On Reached WP1 (Path 2) - Set Orientation");

-- Hunter of the Hand SAI
SET @ENTRY := 17875;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,2,40,0,100,0,7,17875,0,0,66,0,0,0,0,0,0,19,17843,0,0,0,0,0,0,"Hunter of the Hand - On Reached WP7 - Set Orientation"),
(@ENTRY,0,2,0,61,0,100,0,0,0,0,0,90,8,0,0,0,0,0,1,0,0,0,0,0,0,0,"Hunter of the Hand - On Reached WP7 - Set Bytes 1"),
(@ENTRY,0,3,4,38,0,100,0,2,2,0,0,29,10,0,0,0,0,0,19,17843,0,0,0,0,0,0,"Hunter of the Hand - On Data Set - Start Closest path"),
(@ENTRY,0,4,0,61,0,100,0,0,0,0,0,80,@ENTRY*100+00,0,0,0,0,0,1,0,0,0,0,0,0,0,"Hunter of the Hand - On Data Set - Run Script"),
(@ENTRY,0,5,6,38,0,100,0,3,3,0,0,91,8,0,0,0,0,0,1,0,0,0,0,0,0,0,"Hunter of the Hand - On Data Set - Remove Bytes 1"),
(@ENTRY,0,6,7,61,0,100,0,0,0,0,0,5,15,0,0,0,0,0,1,0,0,0,0,0,0,0,"Hunter of the Hand - On Data Set - Play emote OneShotRoar"),
(@ENTRY,0,8,0,40,0,100,0,9,@ENTRY*100+00,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Hunter of the Hand - On Reached WP9 (Path 06) - Despawn");

-- Archaeologist Adamant Ironheart SAI
SET @ENTRY := 17242;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,2,0,40,0,100,0,1,@ENTRY*100+01,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,6.26573,"Archaeologist Adamant Ironheart - On Reached WP1 (Path 2) - Set Orientation");

-- Grom'tor, Son of Oronok SAI
SET @ENTRY := 21687;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,2,40,0,100,0,17,21687,0,0,101,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gromtor, Son of Oronok - On Reached WP17 - Set Home Position"),
(@ENTRY,0,2,3,61,0,100,0,0,0,0,0,19,768,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gromtor, Son of Oronok - On Reached WP17 - Set Unit Flags"),
(@ENTRY,0,3,4,61,0,100,0,0,0,0,0,2,495,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gromtor, Son of Oronok - On Reached WP17 - Set Faction"),
(@ENTRY,0,4,0,61,0,100,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gromtor, Son of Oronok - On Reached WP17 - Set Aggresive"),
(@ENTRY,0,5,0,38,0,100,0,2,2,0,0,49,0,0,0,0,0,0,19,21181,0,0,0,0,0,0,"Gromtor, Son of Oronok - On Data Set - Start Attack"),
(@ENTRY,0,6,0,4,0,100,0,0,0,0,0,11,31403,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gromtor, Son of Oronok - On Agro - Cast Battle Shout"),
(@ENTRY,0,7,0,9,0,100,0,0,5,3000,7000,11,29426,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gromtor, Son of Oronok - On Range - Cast Heroic Strike"),
(@ENTRY,0,8,0,9,0,100,0,0,5,8000,13000,11,12169,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gromtor, Son of Oronok - On Range - Cast Shield Block"),
(@ENTRY,0,9,0,9,0,100,0,0,5,18000,23000,11,15062,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gromtor, Son of Oronok - On Range - Cast Shield Wall"),
(@ENTRY,0,10,0,0,0,100,0,0,5000,5000,8000,11,26281,0,0,0,0,0,2,0,0,0,0,0,0,0,"Gromtor, Son of Oronok - IC - Cast Taunt"),
(@ENTRY,0,11,0,2,0,100,0,0,40,5000,8000,45,4,4,0,0,0,0,19,21685,0,0,0,0,0,0,"Gromtor, Son of Oronok - On Less than 40% HP - Set Data Oronok Torn-heart"),
(@ENTRY,0,12,0,38,0,100,0,3,3,0,0,71,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gromtor, Son of Oronok - On Data Set 3 3 - Unequip weapon"),
(@ENTRY,0,14,0,40,0,100,0,1,@ENTRY*100+00,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,1.50312,"Gromtor, Son of Oronok - On Reached WP1 (Path 2) - Set Orientation");

-- The Chef SAI
SET @ENTRY := 47405;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,2,40,0,100,0,2,47405,0,0,54,11000,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Chef - On Waypoint 2 Reached - Pause Waypoint"),
(@ENTRY,0,2,0,61,0,100,0,2,47405,0,0,17,233,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Chef - On Waypoint 2 Reached - Set Emote State 233"),
(@ENTRY,0,3,4,40,0,100,0,3,47405,0,0,54,10000,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Chef - On Waypoint 3 Reached - Pause Waypoint"),
(@ENTRY,0,4,0,61,0,100,0,3,47405,0,0,17,69,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Chef - On Waypoint 3 Reached - Set Emote State 69"),
(@ENTRY,0,5,0,40,0,100,0,4,47405,0,0,17,26,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Chef - On Waypoint 4 Reached - Set Emote State 26");

-- Tiny Arcane Construct SAI
SET @ENTRY := 18237;
UPDATE `creature_template` SET `AIName`="" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;

-- Perry Gatner SAI
SET @ENTRY := 19228;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,2,40,0,100,0,3,19228,0,0,54,220000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Perry Gatner - On Reached WP3 - Pause WP"),
(@ENTRY,0,2,0,61,0,100,0,0,0,0,0,80,@ENTRY*100+00,2,0,0,0,0,1,0,0,0,0,0,0,0,"Perry Gatner - On Reached WP3 - Run Script 1"),
(@ENTRY,0,3,0,40,0,100,0,6,19228,0,0,41,5000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Perry Gatner - On Reached WP6 - Despawn"),
(@ENTRY,0,4,0,40,0,100,0,2,19228,0,0,80,@ENTRY*100+01,0,0,0,0,0,1,0,0,0,0,0,0,0,"Perry Gatner - On Reached WP2 - Run Script 2"),
(@ENTRY,0,5,0,40,0,100,0,4,19228,0,0,80,@ENTRY*100+02,0,0,0,0,0,1,0,0,0,0,0,0,0,"Perry Gatner - On Reached WP6 - Run Script 3");

-- Axle SAI
SET @ENTRY := 23995;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,2,40,0,100,0,4,23995,0,0,54,24000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Axle - On Waypoint 4 Reached - Pause Waypoint"),
(@ENTRY,0,2,0,61,0,100,0,0,0,0,0,80,@ENTRY*100+00,0,0,0,0,0,1,0,0,0,0,0,0,0,"Axle - On Waypoint 4 Reached - Run Script"),
(@ENTRY,0,3,4,40,0,100,0,8,23995,0,0,54,140000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Axle - On Waypoint 8 Reached - Pause Waypoint"),
(@ENTRY,0,4,0,61,0,100,0,0,0,0,0,66,23995,0,0,0,0,0,1,0,0,0,0,0,0,0,"Axle - On Waypoint 8 Reached - Set Orientation Home Position"),
(@ENTRY,0,5,6,62,0,100,0,9123,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Axle - On Gossip Option 0 Selected - Close Gossip"),
(@ENTRY,0,6,0,61,0,100,0,0,0,0,0,85,24751,0,0,0,0,0,7,0,0,0,0,0,0,0,"Axle - On Gossip Option 0 Selected - Invoker Cast 'Trick or Treat'");

-- Scout Vor'takh SAI
SET @ENTRY := 26666;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,40,0,100,0,6,26666,0,0,54,32000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Scout Vor'takh - On On reached wp6 - Pause WP"),
(@ENTRY,0,2,0,40,0,100,0,7,26666,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,4.55531,"Scout Vor'takh - On On reached wp7 - Set Orientation");

-- Buddy SAI
SET @ENTRY := 17953;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,38,0,100,0,1,1,0,0,29,0,0,0,0,0,0,19,17831,0,0,0,0,0,0,"Buddy - On Data Set - Follow Watcher Leesa'oh "),
(@ENTRY,0,1,2,1,0,100,0,0,30000,60000,75000,5,36,0,0,0,0,0,1,0,0,0,0,0,0,0,"Buddy - OOC - Play emote OneShotAttack1H"),
(@ENTRY,0,2,0,61,0,100,0,0,0,0,0,4,643,0,0,0,0,0,1,0,0,0,0,0,0,0,"Buddy - OOC - Play Sound ID 643"),
(@ENTRY,0,3,0,25,0,100,0,0,0,0,0,89,6,0,0,0,0,0,1,0,0,0,0,0,0,0,"Buddy - On Reset Set Random Movement"),
(@ENTRY,0,4,5,38,0,100,0,2,2,0,0,29,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Buddy - On Data Set - Follow Watcher Leesa'oh "),
(@ENTRY,0,6,0,40,0,100,0,1,17953,0,0,89,6,0,0,0,0,0,1,0,0,0,0,0,0,0,"Buddy - On Reached WP1 - Set Random Movement");

-- Kyle the Frenzied SAI
SET @ENTRY := 23616;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,2,8,0,100,0,42222,0,55000,55000,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,"Kyle the Frenzied - On Spellhit 'Lunch for Kyle' - Store Targetlist"),
(@ENTRY,0,2,0,61,0,100,0,0,0,0,0,80,@ENTRY*100+00,2,0,0,0,0,1,0,0,0,0,0,0,0,"Kyle the Frenzied - On Spellhit 'Lunch for Kyle' - Run Script");

-- Lou the Cabin Boy SAI
SET @ENTRY := 27923;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,28,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Lou the Cabin Boy - On Passenger Removed - Despawn Instant"),
(@ENTRY,0,2,0,54,0,100,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Lou the Cabin Boy - On Just Summoned - Set Reactstate Passive"),
(@ENTRY,0,3,0,40,0,100,0,13,27923,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Lou the Cabin Boy - On Waypoint 13 Reached - Despawn Instant");

-- King Jokkum SAI
SET @ENTRY := 30331;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,2,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Jokkum - JustSummoned - Talk1"),
(@ENTRY,0,2,0,61,0,100,0,0,0,0,0,18,768,0,0,0,0,0,1,0,0,0,0,0,0,0,"Jokkum - JustSummoned - Add unit flag"),
(@ENTRY,0,3,0,40,0,100,0,22,@ENTRY*100+00,0,0,80,@ENTRY*100+00,0,0,0,0,0,1,0,0,0,0,0,0,0,"Jokkum - On way pont 22 - Actionlist");

-- Crusade Commander Korfax SAI
SET @ENTRY := 28175;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,38,0,100,0,1,1,0,0,66,0,0,0,0,0,0,19,28244,0,0,0,0,0,0,"Crusade Commander Korfax - On Data Set 1 1 - Set Orientation"),
(@ENTRY,0,1,2,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crusade Commander Korfax - On Data Set 1 1 - Say Line 1"),
(@ENTRY,0,3,0,40,0,100,0,1,28175,0,0,80,@ENTRY*100+00,2,0,0,0,0,1,0,0,0,0,0,0,0,"Crusade Commander Korfax - On Reached WP4 - Run Script"),
(@ENTRY,0,4,0,40,0,100,0,1,28175,0,0,54,18000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crusade Commander Korfax - On Reached WP3 - Pause WP"),
(@ENTRY,0,5,0,40,0,100,0,5,28175,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,1.54325,"Crusade Commander Korfax - On Reached WP5 - Set Orientation");

-- Lady Jaina Proudmoore SAI
SET @ENTRY := 35320;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,40,0,100,0,11,35320,0,0,54,70000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Lady Jaina Proudmoore - On Reached WP13 - Pause WP"),
(@ENTRY,0,2,0,40,0,100,0,16,35320,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Lady Jaina Proudmoore - On Reached WP18 - Despawn"),
(@ENTRY,0,3,0,38,0,100,0,1,1,0,0,66,0,0,0,0,0,0,19,35361,0,0,0,0,0,0,"Lady Jaina Proudmoore - On Data Set 1 1 - Face Tirion");

-- Blood Lord Zarath SAI
SET @ENTRY := 21410;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,2,61,0,100,1,0,0,0,0,45,1,1,0,0,0,0,11,21293,500,0,0,0,0,0,"Blood Lord Zarath - On Just Summoned - Set Data 1 1"),
(@ENTRY,0,2,0,61,0,100,1,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Blood Lord Zarath - On Just Summoned - Set Reactstate Aggressive"),
(@ENTRY,0,3,0,38,0,100,0,0,1,0,0,66,0,0,0,0,0,0,19,21409,10,0,0,0,0,0,"Blood Lord Zarath - On Data Set 0 1 - Set Orientation Closest Creature 'Envoy Icarius'"),
(@ENTRY,0,4,5,38,0,100,0,1,1,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,4.716,"Blood Lord Zarath - On Data Set 1 1 - Set Orientation 5"),
(@ENTRY,0,5,0,61,0,100,0,0,0,0,0,80,@ENTRY*100+00,2,0,0,0,0,1,0,0,0,0,0,0,0,"Blood Lord Zarath - On Data Set 1 1 - Run Script"),
(@ENTRY,0,6,0,40,0,100,0,1,21410,0,0,101,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Blood Lord Zarath - On Waypoint 1 Reached - Set Home Position");

-- Olum's Spirit SAI
SET @ENTRY := 22870;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,54,0,100,0,0,0,0,0,11,36545,0,0,0,0,0,1,0,0,0,0,0,0,0,"Olums Spirit - On Just Summoned - Cast Floating Drowned"),
(@ENTRY,0,1,2,61,0,100,0,0,0,0,0,11,36550,0,0,0,0,0,1,0,0,0,0,0,0,0,"Olums Spirit - On Just Summoned - Cast Floating Drowned"),
(@ENTRY,0,3,0,40,0,100,0,1,22870,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Olums Spirit - On Reached WP1 - Despawn");

-- Garrosh Hellscream SAI
SET @ENTRY := 25237;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,6,40,0,100,0,2,@ENTRY*100+00,0,0,54,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Garrosh Hellscream - On Reached WP 2 (Path 1) - Pause WP"),
(@ENTRY,0,1,0,40,0,100,0,3,@ENTRY*100+00,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,3.82227,"Garrosh Hellscream - On Reached WP 3 (Path 1) - Set Orientation"),
(@ENTRY,0,2,6,40,0,100,0,3,@ENTRY*100+01,0,0,54,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Garrosh Hellscream - On Reached WP 3 (Path 2) - Pause WP"),
(@ENTRY,0,3,0,40,0,100,0,5,@ENTRY*100+01,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,3.82227,"Garrosh Hellscream - On Reached WP 5 (Path 2) - Set Orientation"),
(@ENTRY,0,6,0,61,0,100,0,0,0,0,0,11,45404,0,0,0,0,0,1,0,0,0,0,0,0,0,"Garrosh Hellscream - Link - Cast Crush Under Foot");

-- Skeletal Assault Gryphon SAI
SET @ENTRY := 31157;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,2,40,0,100,0,35,31157,0,0,11,50630,2,0,0,0,0,1,0,0,0,0,0,0,0,"Skeletal Assault Gryphon - On Waypoint 35 Reached - Cast 'Eject All Passengers'"),
(@ENTRY,0,2,0,61,0,100,0,36,31157,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Skeletal Assault Gryphon - On Waypoint 36 Reached - Despawn In 1000 ms");

-- Daphne Stilwell SAI
SET @ENTRY := 6182;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,19,0,100,0,1651,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Daphne Stilwell - On Accepted Quest 'The Tome of Valor' - Say Line 0"),
(@ENTRY,0,1,2,61,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,"Daphne Stilwell - Link With Previous - Store Target List"),
(@ENTRY,0,2,3,61,0,100,0,0,0,0,0,83,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Daphne Stilwell - Link With Previous - Remove npcflag 'Quest Giver'"),
(@ENTRY,0,3,4,61,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Daphne Stilwell - Link With Previous - Set Event Phase to 1"),
(@ENTRY,0,5,0,40,0,100,0,5,6182,0,0,80,@ENTRY*100+00,2,0,0,0,0,1,0,0,0,0,0,0,0,"Daphne Stilwell - On WP 5 Reached - Call TAL 618200"),
(@ENTRY,0,6,0,40,0,100,0,8,6182,0,0,80,@ENTRY*100+01,2,0,0,0,0,1,0,0,0,0,0,0,0,"Daphne Stilwell - On WP 8 Reached - Call TAL 618201"),
(@ENTRY,0,7,8,38,2,100,0,1,1,0,0,103,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Daphne Stilwell - On Data Set 1 1(phase 2) - Remove Root"),
(@ENTRY,0,8,0,61,0,100,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Daphne Stilwell - Link With Previous - Say Line 1"),
(@ENTRY,0,9,0,40,2,100,0,9,6182,0,0,80,@ENTRY*100+02,0,0,0,0,0,1,0,0,0,0,0,0,0,"Daphne Stilwell - On WP 9 Reached - Call TAL 618202"),
(@ENTRY,0,10,11,38,4,100,0,1,1,0,0,103,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Daphne Stilwell - On Data Set 1 1(phase 3) - Remove Root"),
(@ENTRY,0,11,0,61,0,100,0,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Daphne Stilwell - Link With Previous - Say Line 2"),
(@ENTRY,0,12,0,40,0,100,0,10,6182,0,0,80,@ENTRY*100+03,0,0,0,0,0,1,0,0,0,0,0,0,0,"Daphne Stilwell - On WP 10 Reached - Call TAL 618203"),
(@ENTRY,0,13,14,38,8,100,0,1,1,0,0,103,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Daphne Stilwell - On Data Set 1 1(phase 4) - Remove Root"),
(@ENTRY,0,14,0,61,0,100,0,0,0,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,"Daphne Stilwell - Link With Previous - Say Line 3"),
(@ENTRY,0,15,0,40,8,100,0,11,6182,0,0,59,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Daphne Stilwell - On WP 11 Reached - Disable Run"),
(@ENTRY,0,16,0,40,8,100,0,12,6182,0,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0,"Daphne Stilwell - On WP 12 Reached - Say Line 4"),
(@ENTRY,0,17,18,40,8,100,0,14,6182,0,0,54,3000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Daphne Stilwell - On WP 14 Reached - Pause WP"),
(@ENTRY,0,18,19,61,8,100,0,0,0,0,0,40,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Daphne Stilwell - Link With Previous - Set Sheath to 0"),
(@ENTRY,0,19,0,61,8,100,0,0,0,0,0,5,432,0,0,0,0,0,1,0,0,0,0,0,0,0,"Daphne Stilwell - Link With Previous - Play Emote"),
(@ENTRY,0,20,21,40,8,100,0,18,6182,0,0,15,1651,0,0,0,0,0,12,1,0,0,0,0,0,0,"Daphne Stilwell - On WP 18 Reached - Area Explored Or Event Happens"),
(@ENTRY,0,21,0,61,8,100,0,0,0,0,0,82,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Daphne Stilwell - Link With Previous - Add npcflag 'Quest Giver'"),
(@ENTRY,0,22,0,0,0,100,0,0,0,0,0,11,6660,64,0,0,0,0,2,0,0,0,0,0,0,0,"Daphne Stilwell - In Combat - Cast spell 'Shoot'"),
(@ENTRY,0,23,24,11,0,100,0,0,0,0,0,103,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Daphne Stilwell - On Respawn - Remove Root"),
(@ENTRY,0,24,0,61,0,100,0,0,0,0,0,40,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Daphne Stilwell - Link With Previous - Set Sheath to 0"),
(@ENTRY,0,25,26,40,0,100,0,19,6182,0,0,55,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Daphne Stilwell - On WP 19 Reached - Stop WP"),
(@ENTRY,0,26,0,61,0,100,0,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Daphne Stilwell - Link With Previous - Evade");

-- Sentinel Selarin SAI
SET @ENTRY := 3694;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,40,0,100,0,23,3694,0,0,41,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Sentinel Selarin - On Waypoint 23 Reached - Despawn Instant"),
(@ENTRY,0,2,0,61,0,100,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Sentinel Selarin - On Just Summoned - Set Active On"),
(@ENTRY,0,3,0,40,0,100,0,1,3694,0,0,54,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Sentinel Selarin - On Waypoint 1 Reached - Pause Waypoint"),
(@ENTRY,0,4,0,40,0,100,0,12,3694,0,0,54,120000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Sentinel Selarin - On Waypoint 12 Reached - Pause Waypoint");

-- Sagan SAI
SET @ENTRY := 19482;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,38,0,100,0,1,1,0,0,11,34718,0,0,0,0,0,1,0,0,0,0,0,0,0,"Sagan <Ravandwyrs Familiar> - On Data Set - Cast Transform Sagan (Skunk)"),
(@ENTRY,0,2,0,38,0,100,0,2,2,0,0,28,34718,0,0,0,0,0,1,0,0,0,0,0,0,0,"Sagan <Ravandwyrs Familiar> - On Data Set - Remove Aura Transform Sagan (Skunk)");

-- Iron Rune Construct SAI
SET @ENTRY := 24806;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,25,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Iron Rune Construct - Just Summoned - Set phase 1"),
(@ENTRY,0,1,0,61,0,100,0,0,0,0,0,50,186952,60,0,0,0,0,1,0,0,0,0,0,0,0,"Iron Rune Construct - Just Summoned - SummonGob"),
(@ENTRY,0,2,3,8,1,100,0,44498,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Iron Rune Construct - spell hit - Say text"),
(@ENTRY,0,3,4,61,0,100,0,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Iron Rune Construct - spell hit - Set phase 2"),
(@ENTRY,0,4,5,61,0,100,0,0,0,0,0,60,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Iron Rune Construct - spell hit - Set fly"),
(@ENTRY,0,6,7,61,0,100,0,0,0,0,0,9,0,0,0,0,0,0,14,65653,186956,0,0,0,0,0,"Iron Rune Construct - spell hit - Activate Gobject"),
(@ENTRY,0,7,0,61,0,100,0,0,0,0,0,80,2471700,0,0,0,0,0,19,24717,30,0,0,0,0,0,"Iron Rune Construct - spell hit - ActionList"),
(@ENTRY,0,8,9,40,0,100,0,5,24806,0,0,11,44499,0,0,0,0,0,23,0,0,0,0,0,0,0,"Iron Rune Construct - Waypoint reached - cast credit spell"),
(@ENTRY,0,9,10,61,0,100,0,0,0,0,0,22,3,0,0,0,0,0,1,0,0,0,0,0,0,0,"Iron Rune Construct - Waypoint reached - Set phase 3"),
(@ENTRY,0,10,0,61,0,100,0,0,0,0,0,9,0,0,0,0,0,0,14,65654,186957,0,0,0,0,0,"Iron Rune Construct - Just Summoned - Activate gob"),
(@ENTRY,0,11,0,1,4,100,1,7000,7000,0,0,28,46598,0,0,0,0,0,1,0,0,0,0,0,0,0,"Iron Rune Construct - OOC (phase 3) - Remove Vehicle aura");


-- Thassarian SAI
SET @ENTRY := 32310;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,2,40,0,100,0,8,32310,0,0,101,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Thassarian - On Data Set - Set Home Position"),
(@ENTRY,0,2,0,61,0,100,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Thassarian - On Data Set - Set Hostile"),
(@ENTRY,0,4,5,38,0,100,0,3,3,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Thassarian - On Data Set - Set Passive"),
(@ENTRY,0,5,6,61,0,100,0,0,0,0,0,41,60000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Thassarian - On Data Set - Despawn After 30 seconds"),
(@ENTRY,0,6,0,61,0,100,0,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Thassarian - On Data Set - Evade");

-- Thrall SAI
SET @ENTRY := 35368;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,54,0,100,0,0,0,0,0,45,1,1,0,0,0,0,9,35460,0,200,0,0,0,0,"Thrall - On Just Summoned - Set Data 1 1 on Kor Kron Elite"),
(@ENTRY,0,2,3,40,0,100,0,7,35368,0,0,54,39000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Thrall - On Reached WP7 - Pause WP"),
(@ENTRY,0,3,0,61,0,100,0,0,0,0,0,80,@ENTRY*100+00,2,0,0,0,0,1,0,0,0,0,0,0,0,"Thrall - On Reached WP7 - Run Script 1"),
(@ENTRY,0,4,5,40,0,100,0,12,35368,0,0,54,85000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Thrall - On Reached WP12 - Pause WP"),
(@ENTRY,0,5,0,61,0,100,0,0,0,0,0,80,@ENTRY*100+01,2,0,0,0,0,1,0,0,0,0,0,0,0,"Thrall - On Reached WP15 - Run Script 2"),
(@ENTRY,0,6,7,40,0,100,0,19,35368,0,0,45,2,2,0,0,0,0,9,35460,0,200,0,0,0,0,"Thrall - On Reached WP19 - Set Data 2 2 on Kor Kron Elite"),
(@ENTRY,0,7,0,61,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Thrall - On Reached WP19 - Despawn");

-- Dusk SAI
SET @ENTRY := 28182;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,40,0,100,0,21,28182,0,0,41,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Dusk - On Waypoint 21 Reached - Despawn Instant"),
(@ENTRY,0,2,0,54,0,100,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Dusk - On Just Summoned - Set Reactstate Passive"),
(@ENTRY,0,3,0,28,0,100,0,0,0,0,0,41,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Dusk - On Passenger Removed - Despawn Instant");

-- Bouldercrag the Rockshaper SAI
SET @ENTRY := 29801;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,2,0,100,1,0,30,0,0,11,56330,0,0,0,0,0,1,0,0,0,0,0,0,0,"Cast Iron's Bane at 30% HP"),
(@ENTRY,0,2,0,61,0,100,0,0,0,0,0,83,3,0,0,0,0,0,1,0,0,0,0,0,0,0,"On link - Remove npc flags"),
(@ENTRY,0,3,4,58,0,100,0,0,0,0,0,66,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"On WP end - Set orientation"),
(@ENTRY,0,4,0,61,0,100,0,0,0,0,0,80,@ENTRY*100+00,0,0,0,0,0,1,0,0,0,0,0,0,0,"On link - Start script"),
(@ENTRY,0,5,6,38,0,100,0,1,1,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,"On data - Despawn"),
(@ENTRY,0,6,0,61,0,100,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"On data - Talk");

-- Audrid SAI
SET @ENTRY := 18903;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,11,40,0,100,0,4,18903,0,0,54,60000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Audrid - On Reached WP4 - Pause WP"),
(@ENTRY,0,2,12,40,0,100,0,9,18903,0,0,54,60000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Audrid - On Reached WP9 - Pause WP"),
(@ENTRY,0,3,13,40,0,100,0,11,18903,0,0,54,60000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Audrid - On Reached WP11 - Pause WP"),
(@ENTRY,0,4,14,40,0,100,0,12,18903,0,0,54,60000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Audrid - On Reached WP12 - Pause WP"),
(@ENTRY,0,5,15,40,0,100,0,13,18903,0,0,54,60000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Audrid - On Reached WP13 - Pause WP"),
(@ENTRY,0,6,16,40,0,100,0,14,18903,0,0,54,60000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Audrid - On Reached WP14 - Pause WP"),
(@ENTRY,0,7,17,40,0,100,0,17,18903,0,0,54,60000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Audrid - On Reached WP17 - Pause WP"),
(@ENTRY,0,8,18,40,0,100,0,22,18903,0,0,54,60000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Audrid - On Reached WP22 - Pause WP"),
(@ENTRY,0,9,19,40,0,100,0,25,18903,0,0,54,60000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Audrid - On Reached WP25 - Pause WP"),
(@ENTRY,0,10,20,40,0,100,0,28,18903,0,0,54,60000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Audrid - On Reached WP29 - Pause WP"),
(@ENTRY,0,11,21,61,0,100,0,0,0,0,0,80,@ENTRY*100+00,2,0,0,0,0,1,0,0,0,0,0,0,0,"Audrid - Linked with Previous Event - Run Script 1"),
(@ENTRY,0,12,22,61,0,100,0,0,0,0,0,80,@ENTRY*100+01,2,0,0,0,0,1,0,0,0,0,0,0,0,"Audrid - Linked with Previous Event - Run Script 2"),
(@ENTRY,0,13,22,61,0,100,0,0,0,0,0,80,@ENTRY*100+02,2,0,0,0,0,1,0,0,0,0,0,0,0,"Audrid - Linked with Previous Event - Run Script 3"),
(@ENTRY,0,14,21,61,0,100,0,0,0,0,0,80,@ENTRY*100+03,2,0,0,0,0,1,0,0,0,0,0,0,0,"Audrid - Linked with Previous Event - Run Script 4"),
(@ENTRY,0,14,23,61,0,100,0,12,18903,0,0,80,@ENTRY*100+03,2,0,0,0,0,1,0,0,0,0,0,0,0,"Audrid - On Waypoint 12 Reached - Run Script"),
(@ENTRY,0,15,21,61,0,100,0,0,0,0,0,80,@ENTRY*100+04,2,0,0,0,0,1,0,0,0,0,0,0,0,"Audrid - Linked with Previous Event - Run Script 5"),
(@ENTRY,0,16,24,61,0,100,0,0,0,0,0,80,@ENTRY*100+05,2,0,0,0,0,1,0,0,0,0,0,0,0,"Audrid - Linked with Previous Event - Run Script 6"),
(@ENTRY,0,17,22,61,0,100,0,0,0,0,0,80,@ENTRY*100+06,2,0,0,0,0,1,0,0,0,0,0,0,0,"Audrid - Linked with Previous Event - Run Script 7"),
(@ENTRY,0,18,21,61,0,100,0,0,0,0,0,80,@ENTRY*100+07,2,0,0,0,0,1,0,0,0,0,0,0,0,"Audrid - Linked with Previous Event - Run Script 8"),
(@ENTRY,0,19,21,61,0,100,0,0,0,0,0,80,@ENTRY*100+08,2,0,0,0,0,1,0,0,0,0,0,0,0,"Audrid - Linked with Previous Event - Run Script 9"),
(@ENTRY,0,20,21,61,0,100,0,0,0,0,0,80,@ENTRY*100+09,2,0,0,0,0,1,0,0,0,0,0,0,0,"Audrid - Linked with Previous Event - Run Script 10"),
(@ENTRY,0,21,0,61,0,100,0,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,1.5,"Audrid - Linked with Previous Event - Set Orientation"),
(@ENTRY,0,22,0,61,0,100,0,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,3,"Audrid - Linked with Previous Event - Set Orientation"),
(@ENTRY,0,23,0,61,0,100,0,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,4.5,"Audrid - Linked with Previous Event - Set Orientation"),
(@ENTRY,0,24,0,61,0,100,0,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,6,"Audrid - Linked with Previous Event - Set Orientation");

-- Envoy Icarius SAI
SET @ENTRY := 21409;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,61,0,100,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Envoy Icarius - On Just Summoned - Set Reactstate Aggressive"),
(@ENTRY,0,2,0,40,0,100,0,1,21409,0,0,80,@ENTRY*100+00,2,0,0,0,0,1,0,0,0,0,0,0,0,"Envoy Icarius - On Waypoint 1 Reached - Run Script"),
(@ENTRY,0,3,0,4,1,100,1,0,0,0,0,1,6,0,0,0,0,0,1,0,0,0,0,0,0,0,"Envoy Icarius - On Aggro - Say Line 6");

-- Lady Sinestra SAI
SET @ENTRY := 23283;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,58,0,100,0,1,@ENTRY*100+00,0,0,80,@ENTRY*100+00,2,0,0,0,0,1,0,0,0,0,0,0,0,"Lady Sinestra - On way point ended - action list");

-- Feero Ironhand SAI
SET @ENTRY := 4484;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,19,0,100,1,976,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,"Feero Ironhand - On Quest Accept (Supplies to Aubderdine) - Store Targetlist "),
(@ENTRY,0,1,2,61,0,100,1,0,0,0,0,2,774,0,0,0,0,0,1,0,0,0,0,0,0,0,"Feero Ironhand - On Quest Accept (Supplies to Aubderdine) - Set Faction"),
(@ENTRY,0,2,3,61,0,100,1,0,0,0,0,19,512,0,0,0,0,0,1,0,0,0,0,0,0,0,"Feero Ironhand - On Quest Accept (Supplies to Aubderdine) - Remove Unit Flags"),
(@ENTRY,0,3,0,61,0,100,1,0,0,0,0,1,7,5000,0,0,0,0,1,0,0,0,0,0,0,0,"Feero Ironhand - On Quest Accept (Supplies to Aubderdine) - Say Line 7"),
(@ENTRY,0,4,0,7,0,100,0,0,0,0,0,19,512,0,0,0,0,0,1,0,0,0,0,0,0,0,"Feero Ironhand - On Evade - Remove Unit Flags"),
(@ENTRY,0,5,6,40,0,100,1,18,4484,0,0,1,0,5000,0,0,0,0,1,0,0,0,0,0,0,0,"Feero Ironhand - On Reached WP18 - Say Line 0"),
(@ENTRY,0,6,7,61,0,100,1,0,0,0,0,107,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Feero Ironhand - On Reached WP18 - Summon Summon Group 0"),
(@ENTRY,0,7,0,61,0,100,1,0,0,0,0,54,5000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Feero Ironhand - On Reached WP18 - Pause WP (2 Seconds)"),
(@ENTRY,0,8,0,40,0,100,1,19,4484,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Feero Ironhand - On Reached WP19 - Say Line 1"),
(@ENTRY,0,9,10,40,0,100,1,27,4484,0,0,1,2,5000,0,0,0,0,1,0,0,0,0,0,0,0,"Feero Ironhand - On Reached WP27 - Say"),
(@ENTRY,0,10,11,61,0,100,1,0,0,0,0,107,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Feero Ironhand - On Reached 27 - Summon Summon Group 1"),
(@ENTRY,0,11,0,61,0,100,1,0,0,0,0,54,5000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Feero Ironhand - On Reached WP27 - Pause WP (5 Seconds)"),
(@ENTRY,0,12,0,40,0,100,1,28,4484,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,"Feero Ironhand - On Reached WP28 - Say Line 3"),
(@ENTRY,0,13,14,40,0,100,1,41,4484,0,0,1,4,5000,0,0,0,0,1,0,0,0,0,0,0,0,"Feero Ironhand - On Reached WP41 - Say Line 4"),
(@ENTRY,0,14,15,61,0,100,1,0,0,0,0,107,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Feero Ironhand - On Reached WP41 - Summon Summon Group 2"),
(@ENTRY,0,15,0,61,0,100,1,0,0,0,0,54,10000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Feero Ironhand - On Reached WP41 - Pause WP (10 Seconds)"),
(@ENTRY,0,16,17,40,0,100,1,43,4484,0,0,1,6,0,0,0,0,0,1,0,0,0,0,0,0,0,"Feero Ironhand - On Reached WP43 - Say Line 5"),
(@ENTRY,0,17,18,61,0,100,1,0,0,0,0,15,976,0,0,0,0,0,12,1,0,0,0,0,0,0,"Feero Ironhand - On Reached 43 - Call Areaexploredoreventhappens"),
(@ENTRY,0,18,19,61,0,100,1,0,0,0,0,59,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Feero Ironhand - On Reached 43 - Set Run"),
(@ENTRY,0,19,0,61,0,100,1,0,0,0,0,54,5000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Feero Ironhand - On Reached WP43 - Pause WP (5 Seconds)"),
(@ENTRY,0,20,0,40,0,100,1,45,4484,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Feero Ironhand - On Reached WP45 - Despawn"),
(@ENTRY,0,21,0,6,0,100,1,0,0,0,0,6,976,0,0,0,0,0,12,1,0,0,0,0,0,0,"Feero Ironhand - On Death - Fail Quest"),
(@ENTRY,0,22,0,52,0,100,1,2,4484,0,0,45,1,1,0,0,0,0,9,3893,0,100,0,0,0,0,"Feero Ironhand - On Text Over line 2 - Set Data Forsaken Scout"),
(@ENTRY,0,23,0,52,0,100,1,4,4484,0,0,1,0,5000,0,0,0,0,19,3899,0,0,0,0,0,0,"Feero Ironhand - On Text Over line 4 - Say Line 0 (Balizar the Umbrage)"),
(@ENTRY,0,27,0,52,0,100,1,0,4484,0,0,45,1,1,0,0,0,0,9,3879,0,100,0,0,0,0,"Feero Ironhand - On Text Over line 0 - Set Data Dark Strand assasin");

-- Gharsul the Remorseless SAI
SET @ENTRY := 15958;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,54,0,100,0,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gharsul the Remorseless - On Just Summoned - Set Phase 2"),
(@ENTRY,0,2,3,40,0,100,0,1,15958,0,0,101,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gharsul the Remorseless - On Reached WP1 - Set Home position"),
(@ENTRY,0,3,4,61,0,100,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gharsul the Remorseless - On Reached WP1 - Set react state agressive"),
(@ENTRY,0,4,0,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,19,15402,0,0,0,0,0,0,"Gharsul the Remorseless - On Reached WP1 - Attack Apprentice Mirveda");

-- Zeev Fizzlespark SAI
SET @ENTRY := 29525;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,38,0,100,0,1,1,0,0,1,0,5000,0,0,0,0,1,0,0,0,0,0,0,0,"Zeev Fizzlespark - On Data Set - Say Line"),
(@ENTRY,0,2,0,40,0,100,0,8,29525,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Zeev Fizzlespark - On Reached WP8 - Despawn");

-- The Lich King SAI
SET @ENTRY := 32184;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,2,40,0,100,0,6,32184,0,0,80,@ENTRY*100+00,2,0,0,0,0,1,0,0,0,0,0,0,0,"The Lich King - On Reached WP8 - Run Script"),
(@ENTRY,0,2,0,61,0,100,0,0,0,0,0,101,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Lich King - On Reached WP8 - Set Home Position"),
(@ENTRY,0,3,0,61,0,100,0,0,0,0,0,102,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Lich King - On Reached WP8 - Switch HP Regen off"),
(@ENTRY,0,4,0,38,0,100,0,1,1,0,0,41,60000,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Lich King - On Data Set - Despawn");

-- Crusader Jonathan SAI
SET @ENTRY := 28136;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,54,0,100,0,0,0,0,0,11,50665,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crusader Jonathan - On Just Summoned - Cast 'Bleeding Out'"),
(@ENTRY,0,1,2,61,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,"Crusader Jonathan - On Waypoint 5 Reached - Store Targetlist (No Repeat)"),
(@ENTRY,0,2,3,61,0,100,0,0,0,0,0,29,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Crusader Jonathan - On Waypoint 5 Reached - Start Follow Invoker (No Repeat)"),
(@ENTRY,0,3,4,61,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crusader Jonathan - On Waypoint 5 Reached - Set Event Phase 1 (No Repeat)"),
(@ENTRY,0,4,0,61,0,100,0,0,0,0,0,91,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crusader Jonathan - On Waypoint 5 Reached - Remove Flag Standstate Sit Down (No Repeat)"),
(@ENTRY,0,5,0,23,1,100,1,50665,0,0,0,80,@ENTRY*100+00,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crusader Jonathan - On Has Aura 'Bleeding Out' - Run Script (No Repeat)"),
(@ENTRY,0,6,7,40,0,100,1,5,0,0,0,90,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crusader Jonathan - On Waypoint 5 Reached - Set Flag Standstate Sit Down (No Repeat)"),
(@ENTRY,0,7,0,61,0,100,0,0,0,0,0,41,20000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crusader Jonathan - On Waypoint 5 Reached - Despawn In 20000 ms (No Repeat)"),
(@ENTRY,0,8,9,8,1,100,0,50669,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crusader Jonathan - On Spellhit 'Quest Credit' - Set Event Phase 2 (Phase 1)"),
(@ENTRY,0,9,10,61,0,100,0,0,0,0,0,11,50671,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crusader Jonathan - On Spellhit 'Resuscitate' - Cast 'Kill Credit Jonathan 01'"),
(@ENTRY,0,10,11,61,0,100,0,0,0,0,0,11,50709,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crusader Jonathan - On Spellhit 'Resuscitate' - Cast 'Strip Aura Jonathan 01'"),
(@ENTRY,0,11,12,61,0,100,0,0,0,0,0,86,50680,0,12,1,0,0,1,0,0,0,0,0,0,0,"Crusader Jonathan - On Spellhit 'Resuscitate' - Cross Cast 'Jonathan Kill Credit'"),
(@ENTRY,0,12,13,61,0,100,0,0,0,0,0,86,50710,0,12,1,0,0,1,0,0,0,0,0,0,0,"Crusader Jonathan - On Spellhit 'Resuscitate' - Cross Cast 'Strip Aura Jonanthan'"),
(@ENTRY,0,13,14,61,0,100,0,0,0,0,0,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"Crusader Jonathan - On Waypoint 5 Reached - Stop Follow  (No Repeat)"),
(@ENTRY,0,14,15,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crusader Jonathan - On Waypoint 5 Reached - Say Line 0 (No Repeat)"),
(@ENTRY,0,16,0,61,0,100,0,0,0,0,0,83,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crusader Jonathan - On Waypoint 5 Reached - Remove Npc Flag Gossip (No Repeat)");

-- Warmage Moran SAI
SET @ENTRY := 25727;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,61,0,100,0,1,1,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Warmage Moran - On Data Set 1 1 - Set Active On"),
(@ENTRY,0,2,3,40,0,100,0,1,25727,0,0,54,10000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Warmage Moran - On Waypoint 1 Reached - Pause Waypoint"),
(@ENTRY,0,3,0,61,0,100,0,1,25727,0,0,75,42726,0,0,0,0,0,9,25724,0,100,0,0,0,0,"Warmage Moran - On Waypoint 1 Reached - Add Aura 'Cosmetic - Immolation (Whole Body)'");

-- High Abbot Landgren SAI
SET @ENTRY := 27439;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,2,40,0,100,0,2,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"High Abbot Landgren - On Reached WP2 - Say"),
(@ENTRY,0,2,0,61,0,100,0,0,0,0,0,54,6000,0,0,0,0,0,1,0,0,0,0,0,0,0,"High Abbot Landgren - Linked with Previous Event - Pause WP"),
(@ENTRY,0,3,4,40,0,100,0,9,0,0,0,66,0,0,0,0,0,0,1,0,0,0,0,0,0,4.5,"High Abbot Landgren - On Reached WP10 - Set Orientation"),
(@ENTRY,0,4,0,61,0,100,0,0,0,0,0,1,1,10000,0,0,0,0,21,50,0,0,0,0,0,0,"High Abbot Landgren - Linked with Previous Event - Say"),
(@ENTRY,0,5,0,52,0,100,0,1,27439,0,0,1,2,10000,0,0,0,0,21,50,0,0,0,0,0,0,"High Abbot Landgren - On Text Over Say - Say"),
(@ENTRY,0,6,0,52,0,100,0,2,27439,0,0,1,3,10000,0,0,0,0,21,50,0,0,0,0,0,0,"High Abbot Landgren - On Text Over Say - Say"),
(@ENTRY,0,7,0,52,0,100,0,3,27439,0,0,1,4,10000,0,0,0,0,21,50,0,0,0,0,0,0,"High Abbot Landgren - On Text Over Say - Say"),
(@ENTRY,0,8,9,52,0,100,0,4,27439,0,0,1,5,10000,0,0,0,0,21,50,0,0,0,0,0,0,"High Abbot Landgren - On Text Over Say - Say"),
(@ENTRY,0,9,10,61,0,100,0,0,0,0,0,11,48771,0,0,0,0,0,21,50,0,0,0,0,0,0,"High Abbot Landgren - Linked with Previous Event - Cast A Fall from Grace: Kill Credit"),
(@ENTRY,0,10,11,61,0,100,0,0,0,0,0,15,12274,0,0,0,0,0,21,50,0,0,0,0,0,0,"High Abbot Landgren - Linked with Previous Event - Call Areaexploredoreventhappens"),
(@ENTRY,0,11,12,61,0,100,0,0,0,0,0,11,48773,0,0,0,0,0,1,0,0,0,0,0,0,0,"High Abbot Landgren - Linked with Previous Event - Cast A Fall from Grace: High Abbot Ride Vehicle"),
(@ENTRY,0,12,13,61,0,100,0,0,0,0,0,11,66733,2,0,0,0,0,1,0,0,0,0,0,0,0,"High Abbot Landgren - Linked with Previous Event - Cast Jump Back"),
(@ENTRY,0,13,0,61,0,100,0,0,0,0,0,41,2000,0,0,0,0,0,1,0,0,0,0,0,0,0,"High Abbot Landgren - Linked with Previous Event - Despawn After 2 Seconds");

-- Crusader Josephine SAI
SET @ENTRY := 28148;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,54,0,100,0,0,0,0,0,11,50695,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crusader Josephine - On Just Summoned - Cast 'Bleeding Out'"),
(@ENTRY,0,1,2,61,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,"Crusader Josephine - On Spellhit 'Resuscitate' - Store Targetlist"),
(@ENTRY,0,2,3,61,0,100,0,0,0,0,0,29,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Crusader Josephine - On Waypoint 4 Reached - Start Follow Invoker (No Repeat)"),
(@ENTRY,0,3,4,61,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crusader Josephine - On Waypoint 4 Reached - Set Event Phase 1 (No Repeat)"),
(@ENTRY,0,4,0,61,0,100,0,0,0,0,0,91,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crusader Josephine - On Waypoint 4 Reached - Remove Flag Standstate Sit Down (No Repeat)"),
(@ENTRY,0,5,0,23,1,100,1,50695,0,0,0,80,@ENTRY*100+00,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crusader Josephine - On Has Aura 'Bleeding Out' - Run Script (No Repeat)"),
(@ENTRY,0,6,7,40,0,100,1,4,0,0,0,90,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crusader Josephine - On Waypoint 4 Reached - Set Flag Standstate Sit Down (No Repeat)"),
(@ENTRY,0,7,0,61,0,100,0,0,0,0,0,41,20000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crusader Josephine - On Spellhit 'Quest Credit' - Despawn In 20000 ms (Phase 1)"),
(@ENTRY,0,8,9,8,1,100,0,50669,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crusader Josephine - On Spellhit 'Quest Credit' - Set Event Phase 2 (Phase 1)"),
(@ENTRY,0,9,10,61,0,100,0,0,0,0,0,11,50698,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crusader Josephine - On Just Summoned - Cast 'Kill Credit Jospehine 01'"),
(@ENTRY,0,10,11,61,0,100,0,0,0,0,0,11,50711,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crusader Josephine - On Just Summoned - Cast 'Strip Aura Josephine 01'"),
(@ENTRY,0,11,12,61,0,100,0,0,0,0,0,86,50699,0,12,1,0,0,1,0,0,0,0,0,0,0,"Crusader Josephine - On Just Summoned - Cross Cast 'Josephine Kill Credit'"),
(@ENTRY,0,12,13,61,0,100,0,0,0,0,0,86,50712,0,12,1,0,0,1,0,0,0,0,0,0,0,"Crusader Josephine - On Just Summoned - Cross Cast 'Strip Aura Josephine'"),
(@ENTRY,0,13,14,61,0,100,0,0,0,0,0,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"Crusader Josephine - On Just Summoned - Stop Follow "),
(@ENTRY,0,14,15,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crusader Josephine - On Just Summoned - Say Line 0"),
(@ENTRY,0,16,0,61,0,100,0,0,0,0,0,83,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crusader Josephine - On Just Summoned - Remove Npc Flag Gossip");


-- Veranus SAI
SET @ENTRY := 30393;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,61,0,100,0,0,0,0,0,18,33554432,0,0,0,1,0,1,0,0,0,0,0,0,0,"Veranus - JustSummoned - Set unit_flag not selectable"),
(@ENTRY,0,2,0,40,0,100,0,2,0,0,0,11,50630,0,0,0,0,0,1,0,0,0,0,0,0,0,"Veranus - On waypoint 2 - Eject passenger");

-- Brann Bronzebeard SAI
SET @ENTRY := 34044;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,2,40,0,100,0,11,34044,0,0,54,4000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Brann Bronzebeard - On Reached WP13 - Pause WP"),
(@ENTRY,0,2,3,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Brann Bronzebeard - On Reached WP13 - Say Line 1"),
(@ENTRY,0,3,0,61,0,100,0,0,0,0,0,45,1,1,0,0,0,0,19,16128,0,0,0,0,0,0,"Brann Bronzebeard - On Reached WP13 - Set Data On Rhonin"),
(@ENTRY,0,4,0,38,0,100,0,1,1,0,0,41,5000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Brann Bronzebeard - On Data Set - Despawn");

-- Garrosh Hellscream SAI
SET @ENTRY := 35372;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,40,0,100,0,7,35372,0,0,54,39000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Garrosh Hellscream - On Reached WP10 - Pause WP"),
(@ENTRY,0,3,0,40,0,100,0,12,35372,0,0,54,85000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Garrosh Hellscream - On Reached WP15 - Pause WP"),
(@ENTRY,0,4,0,40,0,100,0,19,35372,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Garrosh Hellscream - On Reached WP22 - Despawn"),
(@ENTRY,0,5,0,38,0,100,0,1,1,0,0,66,0,0,0,0,0,0,19,35368,0,0,0,0,0,0,"Garrosh Hellscream - On Data Set 1 1 - Face Thrall"),
(@ENTRY,0,6,0,38,0,100,0,2,2,0,0,66,0,0,0,0,0,0,19,35361,0,0,0,0,0,0,"Garrosh Hellscream - On Data Set 2 2 - Face Tirion");

-- Eitrigg SAI
SET @ENTRY := 28244;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,20,0,100,0,12584,0,0,0,1,6,0,0,0,0,0,19,28178,0,0,0,0,0,0,"Eitrigg - On Quest Reward (Pure Evil) - Say Line 7 on Avenger Metz"),
(@ENTRY,0,2,3,40,0,100,0,1,28244,0,0,80,@ENTRY*100+00,2,0,0,0,0,1,0,0,0,0,0,0,0,"Eitrigg - On Reached WP2 - Run Script"),
(@ENTRY,0,3,0,61,0,100,0,0,0,0,0,54,3000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Eitrigg - On Reached WP2 - Pause WP"),
(@ENTRY,0,4,0,40,0,100,0,3,28244,0,0,54,100000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Eitrigg - On Reached WP3 - Pause WP"),
(@ENTRY,0,5,0,40,0,100,0,4,28244,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,1.56042,"Eitrigg - On Reached WP4 - Set Orientation");

-- Overseer Kraggosh SAI
SET @ENTRY := 36217;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,38,0,100,0,2,2,0,0,66,0,0,0,0,0,0,10,79267,36213,0,0,0,0,0,"Overseer Kraggosh - On Data Set  - Face Kor kron overseer"),
(@ENTRY,0,2,0,40,0,100,0,2,36217,0,0,54,45000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Overseer Kraggosh - On Reached WP2  - Pause WP"),
(@ENTRY,0,3,0,40,0,100,0,5,36217,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,3.12414,"Overseer Kraggosh - On Reached WP5  - Set Orientation");

-- Whisperwind Druid SAI
SET @ENTRY := 48487;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,2,40,0,100,0,1,48487,0,0,80,@ENTRY*100+00,2,0,0,0,0,1,0,0,0,0,0,0,0,"Whisperwind Druid - On Waypoint 1 Reached - Run Script"),
(@ENTRY,0,2,0,61,0,100,0,1,48487,0,0,54,12000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Whisperwind Druid - On Waypoint 1 Reached - Pause Waypoint"),
(@ENTRY,0,3,0,40,0,100,0,3,48487,0,0,41,2000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Whisperwind Druid - On Waypoint 3 Reached - Despawn In 2000 ms");

-- Seer Olum SAI
SET @ENTRY := 22820;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,54,0,100,0,0,0,0,0,81,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Seer Olum - On Just Summoned - Set NPC Flags"),
(@ENTRY,0,2,0,40,0,100,0,2,22820,0,0,101,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Seer Olum - On Reached WP2 - Set Home Position"),
(@ENTRY,0,3,4,8,0,100,0,39552,0,0,0,37,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Seer Olum - On Spellhit (Olums Sacrifice) - Die"),
(@ENTRY,0,4,0,61,0,100,0,0,0,0,0,12,22870,1,20000,0,0,0,1,0,0,0,0,0,0,0,"Seer Olum - On Spellhit (Olums Sacrifice) - Summon Olums Spirit");

-- Apothecary Ravien SAI
SET @ENTRY := 23782;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,2,40,0,100,0,6,23782,0,0,54,60000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Apothecary Ravien - On Reached WP6 - Pause WP"),
(@ENTRY,0,2,3,61,0,100,0,0,0,0,0,66,0,0,0,0,0,0,19,24126,0,0,0,0,0,0,"Apothecary Ravien - On Reached WP6 - Set Orientation"),
(@ENTRY,0,3,0,61,0,100,0,0,0,0,0,45,1,1,0,0,0,0,19,24126,0,0,0,0,0,0,"Apothecary Ravien - On Reached WP6 - Set Data on Apothecary Lysander"),
(@ENTRY,0,4,0,40,0,100,0,7,23782,0,0,45,2,2,0,0,0,0,19,24126,0,0,0,0,0,0,"Apothecary Ravien - On Reached WP7 - Set Data on Apothecary Lysander"),
(@ENTRY,0,5,0,40,0,100,0,18,23782,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Apothecary Ravien - On Reached WP18 - Despawn");

-- Ashtongue Deathsworn SAI
SET @ENTRY := 21701;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,40,0,100,0,2,0,0,0,54,23000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Akama - On waypoint2 - event");

-- Hungry Bog Lord SAI
SET @ENTRY := 17955;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,40,0,100,0,9,17955,0,0,54,11500,0,0,0,0,0,1,0,0,0,0,0,0,0,"Hungry Boglord - On Reached WP10 Pause WP"),
(@ENTRY,0,2,0,40,0,100,0,23,17955,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Hungry Boglord - On Reached WP24 - Despawn");

-- Maiev Shadowsong SAI
SET @ENTRY := 22989;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,40,0,100,0,1,0,0,0,80,@ENTRY*100+00,2,0,0,0,0,1,0,0,0,0,0,0,0,"Vagath - On waypoint1 - Start Script"),
(@ENTRY,0,2,0,0,0,100,0,1000,1000,3000,3000,11,39954,0,0,0,0,0,2,0,0,0,0,0,0,0,"Maiev - IC - Cast Spell");

-- Warmage Austin SAI
SET @ENTRY := 25733;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,61,0,100,0,1,1,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Warmage Austin - On Data Set 1 1 - Set Active On"),
(@ENTRY,0,2,0,40,0,100,0,1,25733,0,0,54,10000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Warmage Moran - On Waypoint 1 Reached - Pause Waypoint");

-- Highlord Darion Mograine SAI
SET @ENTRY := 32312;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,40,0,100,1,8,32312,0,0,107,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Darion Mograine - On Reached WP1 - Summon Group"),
(@ENTRY,0,2,3,40,0,100,1,14,32312,0,0,101,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Darion Mograine - On Reached WP9 - Set Home Position"),
(@ENTRY,0,3,4,61,0,100,0,0,0,0,0,45,1,1,0,0,0,0,9,32309,0,200,0,0,0,0,"Highlord Darion Mograine - On Reached WP9 - Set Data 1 1 Ebon Knight"),
(@ENTRY,0,4,5,61,0,100,0,0,0,0,0,45,1,1,0,0,0,0,19,32310,0,0,0,0,0,0,"Highlord Darion Mograine - On Reached WP9 - Set Data 1 1 Thassarian"),
(@ENTRY,0,5,6,61,0,100,0,0,0,0,0,45,1,1,0,0,0,0,19,32311,0,0,0,0,0,0,"Highlord Darion Mograine - On Reached WP9 - Set Data 1 1 Koltira"),
(@ENTRY,0,6,7,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,19,32311,0,0,0,0,0,0,"Highlord Darion Mograine - On Reached WP9 - Set Data 1 1 Koltira"),
(@ENTRY,0,7,8,61,0,100,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Darion Mograine - On Reached WP9 - Set Hostile"),
(@ENTRY,0,8,10,61,0,100,0,0,0,0,0,45,3,3,0,0,0,0,9,32175,0,200,0,0,0,0,"Highlord Darion Mograine - On Reached WP9 - Set Data 3 3 Chosen Zealot"),
(@ENTRY,0,9,0,7,2,100,0,0,0,0,0,80,@ENTRY*100+00,2,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Darion Mograine - On Evade (Phase 2) - Run Script"),
(@ENTRY,0,10,0,61,0,100,0,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Darion Mograine - On Just Summoned - Set Phase 2");

-- D16 Propelled Delivery Device SAI
SET @ENTRY := 30487;
UPDATE `creature_template` SET `AIName`="" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;

-- King Varian Wrynn SAI
SET @ENTRY := 35321;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,54,0,100,0,0,0,0,0,45,1,1,0,0,0,0,9,35322,0,200,0,0,0,0,"King Varian Wrynn - On Just Summoned - Set Data 1 1 on Stormwind Royal Guard"),
(@ENTRY,0,2,3,40,0,100,0,11,35321,0,0,54,70000,0,0,0,0,0,1,0,0,0,0,0,0,0,"King Varian Wrynn - On Reached WP11 - Pause WP"),
(@ENTRY,0,3,0,61,0,100,0,0,0,0,0,80,@ENTRY*100+00,2,0,0,0,0,1,0,0,0,0,0,0,0,"King Varian Wrynn - On Reached WP11 - Run Script 1"),
(@ENTRY,0,4,5,40,0,100,0,19,35321,0,0,45,2,2,0,0,0,0,9,35322,0,200,0,0,0,0,"King Varian Wrynn - On Reached WP19 - Set Data 2 2 on Stormwind Royal Guard"),
(@ENTRY,0,5,0,61,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"King Varian Wrynn - On Reached WP19 - Despawn");

-- Spirit of Sathrah SAI
SET @ENTRY := 7411;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,40,0,100,0,9,7411,0,0,41,3000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Spirit of Sathrah - On Waypoint 9 Reached - Despawn In 3000 ms");

-- Black Dragon Whelpling SAI
SET @ENTRY := 23364;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,11,0,100,0,0,0,0,0,11,15750,2,0,0,0,0,1,0,0,0,0,0,0,0,"Black Dragon Whelpling - On Spawn - Cast Rookery Whelp Spawn-in Spell"),
(@ENTRY,0,1,2,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Black Dragon Whelpling - On Spawn - Say"),
(@ENTRY,0,2,3,61,0,100,0,0,0,0,0,18,33536,0,0,0,0,0,1,0,0,0,0,0,0,0,"Black Dragon Whelpling - On Spawn - Set Unit Flags"),
(@ENTRY,0,3,4,61,0,100,0,0,0,0,0,70,300,0,0,0,0,0,14,27915,185932,0,0,0,0,0,"Black Dragon Whelpling - On Spawn - Despawn Obsidia's Egg"),
(@ENTRY,0,5,6,40,0,100,0,2,23364,0,0,45,1,1,0,0,0,0,19,23282,0,0,0,0,0,0,"Black Dragon Whelpling - On Reached WP2 - Set Data on Obsidia"),
(@ENTRY,0,6,0,61,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Black Dragon Whelpling - Reached WP2 - Despawn");

-- Prince Keleseth SAI
SET @ENTRY := 24041;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,61,0,100,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Prince Keleseth - On Just Summoned - Set Passive"),
(@ENTRY,0,2,0,40,0,100,0,2,24041,0,0,45,1,1,0,0,0,0,9,24044,0,200,0,0,0,0,"Prince Keleseth - On Just Summoned - Set Data"),
(@ENTRY,0,3,0,38,0,100,0,1,1,0,0,11,42982,0,0,0,0,0,1,0,0,0,0,0,0,0,"Prince Keleseth - On Data Set - Cast Vampire Prince Teleport"),
(@ENTRY,0,4,0,38,0,100,0,2,2,0,0,11,43056,0,0,0,0,0,1,0,0,0,0,0,0,0,"Prince Keleseth - On Data Set - Cast Vampire Soul Retrieve Channel");

-- Warmage Archus SAI
SET @ENTRY := 27888;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,61,0,100,0,1,1,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Warmage Archus - On Data Set 1 1 - Set Active On"),
(@ENTRY,0,2,0,40,0,100,0,1,27888,0,0,54,10000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Warmage Moran - On Waypoint 1 Reached - Pause Waypoint");

-- The Lich King SAI
SET @ENTRY := 28498;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,2,40,0,100,0,2,0,0,0,54,83000,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Lich King - On WP 2 - Pause movement 83 seconds"),
(@ENTRY,0,2,0,61,0,100,0,0,0,0,0,80,@ENTRY*100+00,2,0,0,0,0,1,0,0,0,0,0,0,0,"The Lich King - On WP 2 - Run script"),
(@ENTRY,0,3,4,40,0,100,0,3,0,0,0,45,0,2,0,0,0,0,10,127495,0,0,0,0,0,0,"The Lich King - On WP 3 - Despawn"),
(@ENTRY,0,4,0,61,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Lich King - On WP 3 - Despawn"),
(@ENTRY,0,6,0,40,0,100,0,4,@ENTRY*100+00,0,0,1,7,0,0,0,0,0,19,28998,0,0,0,0,0,0,"The Lich King - Reached WP4 - Say"),
(@ENTRY,0,7,0,40,0,100,0,8,@ENTRY*100+00,0,0,80,@ENTRY*100+01,2,0,0,0,0,1,0,0,0,0,0,0,0,"The Lich King - Reached WP8 - Run Script"),
(@ENTRY,0,8,9,40,0,100,0,4,@ENTRY*100+01,0,0,45,2,2,0,0,0,0,10,98914,28960,0,0,0,0,0,"The Lich King - Reached WP4 (Path 2) - Set Data"),
(@ENTRY,0,9,0,61,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Lich King - Reached WP4 (Path 2) - Despawn");






































