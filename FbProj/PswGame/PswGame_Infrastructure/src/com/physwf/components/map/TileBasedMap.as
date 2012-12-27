package com.physwf.components.map
{
	import com.physwf.components.map.camera.IScreen;
	import com.physwf.components.map.layer.depth.DepthLayerBase;
	import com.physwf.components.map.layer.depth.IDepthLayer;
	import com.physwf.components.map.layer.ground.GroundLayerRFC002;
	import com.physwf.components.map.layer.ground.IGroundLayer;
	import com.physwf.components.map.layer.landform.ILandformLayer;
	import com.physwf.components.map.layer.landform.LandformLayerBase;
	
	import flash.display.Sprite;
	
	public class TileBasedMap implements IMap
	{
		public static const W:Number = 10000;
		public static const H:Number = 10000;
		
		private var _screen:IScreen;
		private var _display:Sprite;
		
		private var _groundLayer:IGroundLayer;
		private var _landformLayer:ILandformLayer;
		private var _depthLayer:IDepthLayer;
		
		public function TileBasedMap()
		{
		}
		
		public function initialize():void
		{
			_display = new Sprite();
			_display.x=100;
			_display.y=100;
			_groundLayer = new GroundLayerRFC002(_screen);
//			_groundLayer = new SpriteGroundLayer(_screen);
			_landformLayer = new LandformLayerBase(_screen);
			_depthLayer = new DepthLayerBase(_screen);
			_display.addChild(_groundLayer.form);
//			_display.addChild(_depthLayer.form);
		}
		
		public function set screen(v:IScreen):void
		{
			_screen = v;
		}
		
		public function get landfomLayer():ILandformLayer
		{
			return _landformLayer;
		}
		
		public function get depthLayer():IDepthLayer
		{
			return _depthLayer;
		}
		
		public function get groundLayer():IGroundLayer
		{
			return _groundLayer;
		}
		
		public function get display():Sprite
		{
			return _display;
		}
		private var lastTimer:Number=0;
		
		public function update():void
		{
//			_groundLayer.x = -_screen.rect.x;
//			_groundLayer.y = -_screen.rect.y;
//			_groundLayer.x = 0;
//			_groundLayer.y = 0;
//			lastTimer = getTimer();
//			_groundLayer.tileRender.render();
//			trace(getTimer()-lastTimer);
			_groundLayer.render();
		}
		
		public function destroy():void
		{
		}
	}
}