package com.physwf.application.game
{
	import com.physwf.application.game.layer.MapLayer;
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.map.Map;
	import com.physwf.components.map.camera.Camera;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	public class Game extends Sprite
	{
		private const gameTimer:Timer = new Timer(33);
		
		private var mapLayer:MapLayer;
		
		
		public function Game()
		{
			super();
			mapLayer = new MapLayer();
		}
		
		public function initialize():void
		{
			gameTimer.addEventListener(TimerEvent.TIMER,onTimer);
		}
		
		public function onTimer(e:Event):void
		{
			mapLayer.update();
		}
	}
}