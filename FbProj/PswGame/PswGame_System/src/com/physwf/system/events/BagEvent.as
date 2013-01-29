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
		
		private var mItemInfo:BagItemInfo;
		
		public function BagEvent(type:String,itemInfo:BagItemInfo)
		{
			mItemInfo = itemInfo;
			super(type, false, false);
		}
		
		public function get itemInfo():BagItemInfo
		{
			return mItemInfo;
		}
	}
}