package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import starling.core.Starling;
	
	[SWF(width="700", height="500", frameRate="60", backgroundColor="#ffffff")]
	public class StarlingLab extends MovieClip
	{
		private var _starling:Starling;
		
		public function StarlingLab()
		{
			_starling = new Starling(Game,stage);	
			_starling.start(); 
		}
	}
}


import flash.display.Bitmap;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.utils.Timer;

import starling.display.Image;
import starling.display.Quad;
import starling.display.Sprite;
import starling.text.TextField;
import starling.textures.Texture;

class Game extends Sprite
{
	private var timer:Timer = new Timer(30);
	private var q:Quad;
	private var image1:Image;
	private var image2:Image;
	
	[Embed(source="../texture/flower.png")]
	private var Flower2:Class;
	[Embed(source="../texture/bird.jpg")]
	private var Bird:Class;
	
	public function Game()
	{
		var tf:TextField = new TextField(400, 300, "Welcome to Starling!");
		q = new Quad(100,100,0xFF0000,false);
		var bird:Bitmap = new Bird() as Bitmap;
		var flower:Bitmap = new Flower2() as Bitmap;
		image1 = new Image(Texture.fromBitmap(bird));
		image2 = new Image(Texture.fromBitmap(flower));
		
//		addChild(q);
//		addChild(image1);
//		addChild(image2);
		image2.color = 0xFFFF00;
		image2.x += 256;
//		addChild(tf);
		 
		timer.addEventListener(TimerEvent.TIMER,onTimer);
		timer.start();
	}
	
	private function onTimer(e:Event):void
	{
		q.x++;
		image1.y++;
	}
		
		
}
	