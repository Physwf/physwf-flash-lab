package model
{
	import model.struct.NPCStruct;
	import model.struct.TeleportStruct;

	public class MapModel
	{
		public var teleports:Vector.<TeleportStruct>;
		public var npcs:Vector.<NPCStruct>;
		
		public function MapModel()
		{
		}
		
		public function newMap():void
		{
			teleports = new <TeleportStruct>[];
			npcs = new <NPCStruct>[];
		}
		
		public function addTeleport(x:uint,y:uint):void
		{
			var teleport:TeleportStruct = new TeleportStruct();
			teleport.x = x;
			teleport.y = y;
			teleports.push(teleport);
		}
		
		public function removeTeleport(tpt:TeleportStruct):void
		{
			var i:int = teleports.indexOf(tpt);
			teleports.splice(i,1);
		}
		
		public function addNPC(id:uint,x:uint,y:uint):void
		{
			var npc:NPCStruct = new NPCStruct();
			npc.id = id;
			npc.x = x;
			npc.y = y;
			npcs.push(npc);
		}
		
		public function removeNPC(npc:NPCStruct):void
		{
			var i:int = npcs.indexOf(npc);
			npcs.splice(i,1);
		}
		
		public function toXML():String
		{
			var ret:XML = <desc/>;
			
			return ret;
		}
	}
}