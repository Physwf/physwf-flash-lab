package com.physwf.system.entity
{
	import com.physwf.components.rpc.RPCConnectioin;
	import com.physwf.components.rpc.events.MessageEvent;
	import com.physwf.system.System;
	import com.physwf.system.events.BagEvent;
	import com.physwf.system.vo.BagItemInfo;
	import com.physwf.system.vo.EquipInfo;
	import com.physwf.system.vo.ItemInfo;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class BagSystem extends EventDispatcher
	{
		public var bagItems:Vector.<BagItemInfo>;
		
		public function BagSystem()
		{
		}
		
		public function initialize():void
		{
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1050,onBagMessage);
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1051,onBagMessage);
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1052,onBagMessage);
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1053,onBagMessage);
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1092,onBagMessage);
		}
		
		public function getBagItems():void
		{
			var msg:MSG_REQ_GET_BAG_1050 = new MSG_REQ_GET_BAG_1050();
			RPCConnectioin.online.call(msg);
		}
		
		public function delBagItem(bInfo:BagItemInfo,count:uint):void
		{
			var msg:MSG_REQ_DEL_ITEM_1051 = new MSG_REQ_DEL_ITEM_1051();
			msg.grid = bInfo.girdTag;
			msg.itemid = bInfo.item.itemID;
			msg.itemcnt = count;
			RPCConnectioin.online.call(msg);
		}
		
		public function delBagEquip(bInfo:BagItemInfo):void
		{
			var msg:MSG_REQ_DEL_EQUIP_1092 = new MSG_REQ_DEL_EQUIP_1092();
			var equip:EquipInfo = bInfo.item as EquipInfo;
			msg.grid = bInfo.girdTag;
			msg.instance_id = equip.instanceID;
			RPCConnectioin.online.call(msg);
		}
		
		public function changeItemGrid(srcGrid:uint,destGrid:uint):void
		{
			var msg:MSG_REQ_CHANGE_GRID_1052 = new MSG_REQ_CHANGE_GRID_1052();
			msg.source_grid = srcGrid;
			msg.obj_grid = destGrid;
			RPCConnectioin.online.call(msg);
		}
		/**
		 * 背包改变。包括改变格子，换装 
		 * @param items
		 * 
		 */		
		public function changeBag(items:Vector.<BagItemInfo>):void
		{
			var msg:MSG_REQ_CHANGE_EQUIPS_1091 = new MSG_REQ_CHANGE_EQUIPS_1091();
			msg.grids = new Vector.<bag_item_t>();
			for(var i:uint=0;i<items.length;++i)
			{
				var item:bag_item_t = new bag_item_t();
				item.grid = items[i].girdTag;
				item.item_cnt = items[i].count;
				item.item_id = items[i].item.itemID;
				msg.grids.push(item);
			}
			RPCConnectioin.online.call(msg);
		}
		
		private function onBagMessage(e:MessageEvent):void
		{
			switch(e.type)
			{
				case MessageEvent.MSG_SUCCESS_+1050://拉取背包
					var msg1050:MSG_RES_GET_BAG_1050 = e.message as MSG_RES_GET_BAG_1050;
					bagItems = new Vector.<BagItemInfo>();
					var items:Vector.<BagItemInfo> = setBagItems(msg1050.items,msg1050.equips);
					dispatchEvent(new BagEvent(BagEvent.BAG_ITEM_LIST,items));
					break;
				case MessageEvent.MSG_SUCCESS_+1051://删除消耗品
					var msg1051:MSG_RES_DEL_ITEM_1051 = e.message as MSG_RES_DEL_ITEM_1051;
					var count:uint = bagItems.length;
					var bagItem:BagItemInfo;
					for(var i:uint=0;i<count;++i)
					{
						if(bagItems[i].girdTag == msg1051.grid)
						{
							bagItem = bagItems[i];
							bagItems.splice(i,1);
							break;
						}
					}
					dispatchEvent(new BagEvent(BagEvent.BAG_ITEM_DEL,Vector.<BagItemInfo>([bagItem])));
					break;
				case MessageEvent.MSG_SUCCESS_+1052://移动物品
					var msg1052:MSG_RES_CHANGE_GRID_1052 = e.message as MSG_RES_CHANGE_GRID_1052;
					dispatchEvent(new BagEvent(BagEvent.BAG_ITEM_CHANGE_GRID,null));
					break;
				case MessageEvent.MSG_SUCCESS_+1053://添加物品
//					var msg1053:MSG_RES_NOTI_ADD_ITEM_1053 = e.message as MSG_RES_NOTI_ADD_ITEM_1053;
//					items = setBagItems(msg1053.items,msg1053.equips);
//					dispatchEvent(new BagEvent(BagEvent.BAG_ITEM_OR_EQUIP_ADDED,items));
					break;
				case MessageEvent.MSG_SUCCESS_+1092://删除装备
					var msg1092:MSG_RES_DEL_EQUIP_1092 = e.message as MSG_RES_DEL_EQUIP_1092;
					count = bagItems.length;
					for(i=0;i<count;++i)
					{
						if(bagItems[i].girdTag == msg1092.grid)
						{
							bagItem = bagItems[i];
							bagItems.splice(i,1);
							break;
						}
					}
					dispatchEvent(new BagEvent(BagEvent.BAG_EQUIP_DEL,Vector.<BagItemInfo>([bagItem])));
					break;
			}
		}
		
		private function setBagItems(items:Vector.<bag_item_t>,equips:Vector.<bag_equip_t>):Vector.<BagItemInfo>
		{
			var count:uint = items.length;
			var offsetItems:Vector.<BagItemInfo> = new Vector.<BagItemInfo>();
			for(var i:int=0;i<count;++i)
			{
				var itemInfo:ItemInfo = new ItemInfo();
				itemInfo.itemID = items[i].item_id;
				var bagItem:BagItemInfo = new BagItemInfo();
				bagItem.count = items[i].item_cnt;
				bagItem.item = itemInfo;
				bagItem.girdTag = items[i].grid;
				offsetItems.push(bagItem);
			}
			count = equips.length;
			for(i=0;i<count;++i)
			{
				var equip:EquipInfo = new EquipInfo();
				equip.instanceID = equips[i].equip.instance_id;
				equip.itemID = equips[i].equip.equip_id;
				equip.strength = equips[i].equip.strength;
				equip.solar = equips[i].equip.solar;
				equip.physique = equips[i].equip.physique;
				equip.spirit = equips[i].equip.spirit;
				equip.agility = equips[i].equip.agility;
				equip.atk = equips[i].equip.phy_atk;
				equip.def = equips[i].equip.phy_def;
				equip.magicAtk = equips[i].equip.solar_atk;
				equip.magicDef = equips[i].equip.solar_def;
				equip.crit = equips[i].equip.crit;
				equip.critDamage = equips[i].equip.crit_damage;
				equip.critTenacity = equips[i].equip.crit_tenacity;
				equip.hit = equips[i].equip.hit;
				equip.dodge = equips[i].equip.dodge;
				equip.earthAtk = equips[i].equip.earth_atk;
				equip.earthDef = equips[i].equip.earth_def;
				equip.waterAtk = equips[i].equip.water_atk;
				equip.waterDef = equips[i].equip.water_def;
				equip.windAtk = equips[i].equip.wind_atk;
				equip.windDef = equips[i].equip.wind_def;
				equip.fireAtk = equips[i].equip.fire_atk;
				equip.fireDef = equips[i].equip.fire_def;
				equip.durability = equips[i].equip.durability;
				bagItem = new BagItemInfo();
				bagItem.girdTag = equips[i].grid;
				bagItem.item = equip ;
				offsetItems.push(bagItem);
			}
			bagItems = bagItems.concat(offsetItems);
			return offsetItems;
		}
	}
}