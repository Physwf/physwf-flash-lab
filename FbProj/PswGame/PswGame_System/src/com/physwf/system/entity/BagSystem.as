package com.physwf.system.entity
{
	import com.physwf.components.rpc.RPCConnectioin;
	import com.physwf.components.rpc.events.MessageEvent;
	import com.physwf.system.events.BagEvent;
	import com.physwf.system.vo.EquipInfo;
	import com.physwf.system.vo.ItemInfo;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class BagSystem extends EventDispatcher
	{
		private var mItems:Vector.<ItemInfo>;
		
		public function BagSystem()
		{
		}
		
		public function initialize():void
		{
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1050,onBagMessage);
		}
		
		public function getBagItems():void
		{
			var msg:MSG_REQ_GET_BAG_1050 = new MSG_REQ_GET_BAG_1050();
			RPCConnectioin.online.call(msg);
		}
		
		private function onBagMessage(e:MessageEvent):void
		{
			switch(e.type)
			{
				case MessageEvent.MSG_SUCCESS_+1050:
					var msg1050:MSG_RES_GET_BAG_1050 = e.message as MSG_RES_GET_BAG_1050;
					var items:Vector.<stru_item_t> = msg1050.items;
					var equips:Vector.<stru_equip_t> = msg1050.equips;
					var count:uint = items.length;
					mItems = new Vector.<ItemInfo>();
					for(var i:int=0;i<count;++i)
					{
						var itemInfo:ItemInfo = new ItemInfo();
						itemInfo.itemID = items[i].itemid;
						itemInfo.count = items[i].itemcnt;
						mItems.push(itemInfo);
					}
					count = equips.length;
					for(i=0;i<count;++i)
					{
						var equip:EquipInfo = new EquipInfo();
						equip.instanceID = equips[i].instance_id;
						equip.itemID = equips[i].equip_id;
						equip.strength = equips[i].strength;
						equip.magic = equips[i].magic;
						equip.physique = equips[i].physique;
						equip.spell = equips[i].spell;
						equip.mind = equips[i].mind;
						equip.atk = equips[i].atk;
						equip.def = equips[i].def;
						equip.magicAtk = equips[i].magic_atk;
						equip.magicDef = equips[i].magic_def;
						equip.critAtk = equips[i].crit_atk;
						equip.critDef = equips[i].crit_def;
						equip.hit = equips[i].hit;
						equip.dodge = equips[i].dodge;
						equip.earthAtk = equips[i].earth_atk;
						equip.earthDef = equips[i].earth_def;
						equip.waterAtk = equips[i].water_atk;
						equip.waterDef = equips[i].water_def;
						equip.windAtk = equips[i].wind_atk;
						equip.windDef = equips[i].wind_def;
						equip.fireAtk = equips[i].fire_atk;
						equip.fireDef = equips[i].fire_def;
						equip.durability = equips[i].durability;
						equip.equipPos = equips[i].position;
						mItems.push(equip);
					}
					dispatchEvent(new BagEvent(BagEvent.BAG_ITEM_LIST,null));
					break;
			}
		}
	}
}