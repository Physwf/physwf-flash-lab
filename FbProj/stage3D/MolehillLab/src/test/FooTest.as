package test
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import psw2d.Alcedo;
	
	public class FooTest extends flash.display.Sprite
	{
		private var _sparrow:Alcedo;
		
		public function FooTest()
		{
			stage?onAddToStage(null):
			addEventListener(Event.ADDED_TO_STAGE,onAddToStage);
			
		}
		
		private function onAddToStage(e:Event):void
		{
			_sparrow = new Alcedo(Demo,stage,stage.stage3Ds[0]);
			_sparrow.addEventListener("contextCreated",onContextCreated);
			_sparrow.start();
		}
		
		public function onContextCreated(e:Event):void
		{
			Alcedo.context.setOrthographicProjection(stage.stageWidth,stage.stageHeight);
		}
	}
}
import flash.display.Bitmap;

import psw2d.Alcedo;
import psw2d.display.Image;
import psw2d.display.Sprite;
import psw2d.filters.FragmentFilter;
import psw2d.texture.Texture;

class Demo extends Sprite
{
	[Embed(source="../texture/flower.png")]
	private var Flower2:Class;
	[Embed(source="../texture/bird.jpg")]
	private var Bird:Class;
	
	private var image:Image;
	private var image2:Image;
	private var _foo:FragmentFilter;
	
	public function Demo()
	{
		var flower:Bitmap = new Flower2() as Bitmap;
		var tex:Texture = Alcedo.context.createBitmapTexture(flower,false) as Texture;
//		image = new Image(tex);
//		image.x = 200;
//		image.y = 200;
		
		var bird:Bitmap = new Bird() as Bitmap;
		var tex2:Texture = Alcedo.context.createBitmapTexture(bird,false) as Texture;
		image2 = new Image(tex2);
		image2.x = 400;
		
//		addChild(image);
		_foo = new FragmentFilter(tex);
		_foo.target = tex2;
		image2.filter = _foo;
		addChild(image2);
		
	}
}