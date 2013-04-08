package com.physwf.system.entity
{
	import com.physwf.components.rpc.RPCConnectioin;
	import com.physwf.components.rpc.events.MessageEvent;
	import com.physwf.system.events.LootEvent;
	import com.physwf.system.vo.LootInfo;
	import com.physwf.system.vo.ItemInfo;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class LootSystem extends EventDispatcher
	{
		public function LootSystem()
		{
		}
		
		public function initialize():void
		{
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1055,onDropEvent);
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1056,onDropEvent);
		}
		
		public function pickUp(monsterId:uint,items:Vector.<uint>):void
		{
			var msg:MSG_REQ_PICK_UP_ITEM_1056 = new MSG_REQ_PICK_UP_ITEM_1056();
			msg.items = items;
			msg.monster_id = monsterId;
			RPCConnectioin.online.call(msg);
		}
		
		private function onDropEvent(e:MessageEvent):void
		{
			switch(e.type)
			{
				case MessageEvent.MSG_SUCCESS_+1055:
					var msg1055:MSG_RES_NOTI_DROP_ITEM_1055 = e.message as MSG_RES_NOTI_DROP_ITEM_1055;
					var info:LootInfo = new LootInfo();
					info.monsterId = msg1055.monster_id;
					info.items = new Vector.<ItemInfo>();
					var items:Vector.<xml_drop_drop_group_item_t> = msg1055.items;
					for(var i:uint=0;i<items.length;++i)
					{
						var item:ItemInfo = new ItemInfo();
						item.itemID = items[i].item_id;
						info.count = items[i].item_cnt;
						info.items.push(item);
					}
					dispatchEvent(new LootEvent(LootEvent.DROP_NOTI_NEW,info));
					break;
				case MessageEvent.MSG_SUCCESS_+1056:
					var msg1056:MSG_RES_PICK_UP_ITEM_1056 = e.message as MSG_RES_PICK_UP_ITEM_1056;
					info = new LootInfo();
					info.monsterId = msg1056.monster_id;
					info.items = new Vector.<ItemInfo>();
					items = msg1056.items;
					for(i=0;i<items.length;++i)
					{
						item = new ItemInfo();
						item.itemID = items[i].item_id;
						info.count = items[i].item_cnt;
						info.items.push(item);
					}
					dispatchEvent(new LootEvent(LootEvent.DROP_PICKED_UP,info));
					break;
			}
		}
	}
}