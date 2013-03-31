package com.physwf.engine.world.objects
{
	import com.physwf.components.bitmap.display.BitmapPlayer;
	import com.physwf.components.bitmap.net.SkeletonLoader;
	import com.physwf.components.interfaces.IDisposible;
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.view.Animation;
	import com.physwf.system.vo.ItemInfo;
	
	import flash.events.EventDispatcher;

	public class Item implements IUpdatable,IDisposible
	{
		public var view:Animation;
		private var mInfo:ItemInfo;
		private var itemId:uint;
		
		public function Item(info:ItemInfo)
		{
			mInfo = info;
			itemId = mInfo.itemID;
			var skeleton:SkeletonLoader = SkeletonLoader.getSameSkeletonLoader("resource/item/"+info.itemID);
			view = new Animation(skeleton);
			view.gotoAndPlay("1");
		}
		
		public function update():void
		{
			view.update();
		}
		
		public function get id():uint { return itemId; }
		
		public function destroy():void
		{
			view.destroy();
			view = null;
			mInfo = null;
		}
	}
}