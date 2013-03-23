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
			var npc:NPC = new NPC();
			var cfg:cfg_npc = Config.getNPCConfig(40000);
			npc.initialize(cfg);
			Engine.map.addNPC(npc);;
		}
	}
}