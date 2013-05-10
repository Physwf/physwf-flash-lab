package
{
	import com.physwf.engine.Engine;
	import com.physwf.engine.script.MapScriptBase;
	import com.physwf.engine.world.objects.Teleport;
	
	import flash.utils.ByteArray;

	public class Script_Map_2  extends MapScriptBase
	{
		[Embed(source="desc/2.xml",mimeType="application/octet-stream")]
		private var Desc:Class;
		
		public function Script_Map_2()
		{
			
		}
		
		override public function initialize():void
		{
			var descData:ByteArray = new Desc();
			description = XML(descData.readUTFBytes(descData.length));
			
			if(description.teleports) createTeleport(description.teleports.teleport);
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
		}
		
		override public function destroy():void
		{
		}
	}
}