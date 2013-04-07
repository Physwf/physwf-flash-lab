package
{
	import com.physwf.config.Config;
	import com.physwf.config.struct.cfg_npc;
	import com.physwf.engine.Engine;
	import com.physwf.engine.script.MapScriptBase;
	import com.physwf.engine.world.objects.NPC;
	import com.physwf.engine.world.objects.Teleport;
	
	public class Script_Map_2 extends MapScriptBase
	{
		[Embed(source="desc/2.xml"),mimeType="application/octet-stream"]
		private var Desc:Class;
		
		public function Script_Map_2()
		{
		}
		
		override public function initialize():void
		{
			description = 
				<desc>
					<npcs>
						<npc id="40000" x="900" y="400"/>
					</npcs>;
					<teleports>
						<teleport id="1" x="1000" y="400"/>
					</teleports>;
				</desc>;
			var npcList:XMLList = description.npcs[0].npc;
			var teleports:XMLList = description.teleports[0].teleport;
			for each(var item:XML in npcList)
			{
				var npc:NPC = new NPC();
				var cfg:cfg_npc = Config.getNPCConfig(item.@id);
				npc.initialize(cfg);
				npc.view.x = item.@x;
				npc.view.y = item.@y;
				npc.headEffect.setNPCStatus(NPC.STATUS_TASK_FINISHED);
				Engine.map.addNPC(npc);;
			}
			return;
			for each(item in teleports)
			{
				var tp:Teleport = new Teleport();
				tp.view.x = item.@x;
				tp.view.y = item.@y;
				Engine.map.addTeleport(tp);
			}
		}
	}
}