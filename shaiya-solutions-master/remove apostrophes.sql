use ps_gamedefs
--removes apostrophes from these columns to help prevent failed log inserts
update dbo.skills set skillname=replace(skillname,'''','');
update dbo.mobs set mobname=replace(mobname,'''','');
update dbo.items set itemname=replace(itemname,'''','');
