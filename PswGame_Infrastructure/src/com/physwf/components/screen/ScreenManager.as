package com.physwf.components.screen
{
	import com.physwf.components.screen.layer.ILayer;

	public class ScreenManager
	{
//		private static var _layerList:Vector.<ILayer>;
		
		private var _mapLayer:ILayer;//地图层,最底层
		private var _functioinLayer:ILayer;//功能层,功能UI
		private var _effectLayer:ILayer;//特效层
		private var _notifyLayer:ILayer;//通知，提示层，最上层
		
		public function ScreenManager()
		{
			
		}
		
		
	}
}