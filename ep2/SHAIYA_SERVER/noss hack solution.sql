-- noss hack solution by Bowie 09/2018
-- execute this query while the ps_game service is shut down
update ps_gamedefs.dbo.skills set reqlevel = 255 where skillid between 201 and 286
delete from ps_gamedata.dbo.charskills where skillid between 201 and 286

