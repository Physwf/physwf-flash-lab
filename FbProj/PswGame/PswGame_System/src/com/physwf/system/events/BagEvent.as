package com.physwf.system.events
{
	import com.physwf.system.vo.BagItemInfo;
	
	import flash.events.Event;
	
	public class BagEvent extends Event
	{
		public static const BAG_ITEM_LIST:String = "b_i_l";
		public static const BAG_ITEM_CHANGE_GRID:String = "b_i_c_g";
		public static const BAG_ITEM_DEL:String = "b_i_d";
		public static const BAG_EQUIP_DEL:String = "b_e_d";
		public static const BAG_ITEM_OR_EQUIP_ADDED:String = "b_i_o_e_a";
		
		private var mItemInfos:Vector.<BagItemInfo>;
		
		public function BagEvent(type:String,itemInfos:Vector.<BagItemInfo>)
		{
			mItemInfos = itemInfos;
			super(type, false, false);
		}
		
		public function get itemInfos():Vector.<BagItemInfo>
		{
			return mItemInfos;
		}
	}
}