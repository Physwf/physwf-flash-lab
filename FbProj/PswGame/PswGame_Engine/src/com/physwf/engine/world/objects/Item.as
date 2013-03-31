package com.physwf.engine.world.objects
{
	import com.physwf.components.bitmap.display.BitmapPlayer;
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.view.Animation;
	
	import flash.events.EventDispatcher;

	public class Item extends EventDispatcher implements IUpdatable
	{
		public var view:Animation;
		
		public function Item()
		{
		}
		
		public function update():void
		{
		}
	}
}