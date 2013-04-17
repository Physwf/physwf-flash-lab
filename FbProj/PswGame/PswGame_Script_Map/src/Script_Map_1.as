package
{
	import com.physwf.config.Config;
	import com.physwf.config.struct.cfg_npc;
	import com.physwf.engine.Engine;
	import com.physwf.engine.script.MapScriptBase;
	import com.physwf.engine.world.objects.NPC;
	import com.physwf.engine.world.objects.Teleport;
	
	import flash.utils.ByteArray;
	
	public class Script_Map_1 extends MapScriptBase
	{
		[Embed(source="desc/1.xml",mimeType="application/octet-stream")]
		private var Desc:Class;
		
		public function Script_Map_1()
		{
			super();
		}
		
		override public function initialize():void
		{
			var descData:ByteArray = new Desc();
			description = XML(descData.readUTFBytes(descData.length));
			
			if(description.teleports) createTeleport(description.teleports);
			if(description.npcs) createNPC(description.npcs);
		}
		
		private function createTeleport(teleports:XMLList):void
		{
			for each(var item:XML in teleports)
			{
				var tp:Teleport = new Teleport();
				tp.view.x = item.@x;
				tp.view.y = item.@y;
				Engine.map.addTeleport(tp);
			}
		}
		
		private function createNPC(npcList:XMLList):void
		{
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
		}
		
		override public function destroy():void
		{
		}
	}
}