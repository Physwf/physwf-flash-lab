package com.physwf.components.ui.assets
{
	import com.physwf.components.interfaces.IDisposible;
	
	import flash.display.BitmapData;

	public class ButtonAssets implements IDisposible
	{
		public var upState:BitmapData;
		public var overState:BitmapData;
		public var downState:BitmapData;
		public var hitState:BitmapData;
		
		public function ButtonAssets()
		{
			upState = overState = downState = hitState = new BitmapData(1,1,true,0x0);
		}
		
		public function destroy():void
		{
			upState && upState.dispose();
			overState && overState.dispose();
			downState && downState.dispose();
			hitState && hitState.dispose();
		}
	}
}