package components
{
	import com.bit101.components.Window;
	
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	
	public class WinItemBox extends EventDispatcher
	{
		private var mLayer:Sprite;
		private var mWin:Window;
		private var mItemLayer:Sprite;
		private var mItemList:Vector.<ItemDisplay>;
		
		public function WinItemBox(layer:Sprite,name:String="Window")
		{
			mLayer = layer;
			mWin = new Window(null,0,0,name);
			mWin.width = 260;
			mWin.height = 300;
			mWin.x = layer.stage.stageWidth - 280;
			mWin.y = 30;
			
			mItemLayer = new Sprite();
			mWin.addChild(mItemLayer);
			mItemList = new Vector.<ItemDisplay>();
		}
		
		public function show():void
		{
			mLayer.addChild(mWin);
		}
		
		public function hide():void
		{
			mLayer.removeChild(mWin);
		}
		
		public function toogle():void
		{
			if(mLayer.contains(mWin))
			{
				hide();
			}
			else
			{
				show();
			}
		}
		
		public function pushItem(item:ItemDisplay):void
		{
			item.icon.x = 5+mItemList.length % 5 * 40;
			item.icon.y = 5+Math.floor(mItemList.length / 5) * 40;
			mItemList.push(item);
			mItemLayer.addChild(item.icon);
		}
	}
}