package
{
	import flash.display.Sprite;
	
	import psw2d.Alcedo;
	
	import test.CubeTextureTest;
	import test.DynamicTextureTest;
	import test.EnviorementCubeTextureTest;
	import test.EnviorementTeapotTextureTest;
	import test.FooTest;
	import test.IncubatorExample;
	import test.MixPasses;
	import test.Plane2dTest;
	import test.QuadTest;
	import test.SinWaveTest;
	import test.SparrowTest;
	import test.TexturePlane2DTest;
	import test.TranditionGlowFilter;

	[SWF(width="512",height="512",color="#0000000")]
	public class MolehillLab extends Sprite
	{
		private var _sparrow:Alcedo;
		
		public function MolehillLab()
		{
//			var sp:Sprite = new IncubatorExample();
//			var sp:Sprite = new Plane2dTest();
//			var sp:Sprite = new TexturePlane2DTest();
//			var sp:Sprite = new SparrowTest();
//			var sp:Sprite = new FooTest();
//			var sp:Sprite = new DynamicTextureTest();
//			var sp:Sprite = new EnviorementTeapotTextureTest();
//			var sp:Sprite = new MixPasses();
//			var sp:Sprite = new Test03_MixPasses();
//			var sp:Sprite = new SinWaveTest();
			var sp:Sprite = new TranditionGlowFilter();
			addChild(sp);
			stage.color = 0
		}
	}
}