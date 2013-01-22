package com.physwf.system.events
{
	import com.physwf.system.vo.ItemInfo;
	
	import flash.events.Event;
	
	public class BagEvent extends Event
	{
		public static const BAG_ITEM_LIST:String = "b_i_l";
		
		private var mItemInfo:ItemInfo;
		
		public function BagEvent(type:String,itemInfo:ItemInfo)
		{
			mItemInfo = itemInfo;
			super(type, false, false);
		}
		
		public function get itemInfo():ItemInfo
		{
			return mItemInfo;
		}
	}
}