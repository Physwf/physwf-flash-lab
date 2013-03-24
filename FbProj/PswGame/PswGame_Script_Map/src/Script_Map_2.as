package
{
	import com.physwf.config.Config;
	import com.physwf.config.struct.cfg_npc;
	import com.physwf.engine.Engine;
	import com.physwf.engine.script.MapScriptBase;
	import com.physwf.engine.world.objects.NPC;
	
	public class Script_Map_2 extends MapScriptBase
	{
		public function Script_Map_2()
		{
		}
		
		override public function initialize():void
		{
			npcList = 
				<npcs>
					<npc id="40000" x="900" y="400"/>
				</npcs>;
			
			for each(var item:XML in npcList)
			{
				var npc:NPC = new NPC();
				var cfg:cfg_npc = Config.getNPCConfig(item.@id);
				npc.initialize(cfg);
				npc.view.x = item.@x;
				npc.view.y = item.@y;
				Engine.map.addNPC(npc);;
			}
		}
	}
}