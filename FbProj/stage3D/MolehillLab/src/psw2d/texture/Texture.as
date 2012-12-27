package psw2d.texture
{
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.textures.Texture;

	public class Texture
	{
		public static const SMOOTHING_NONE:String = "none";
		public static const SMOOTHING_TRILINEAR:String = "trilinear";
		public static const SMOOTING_BILINEAR:String = "bilinear";
		
		public static const FORMAT_COMPRESSED:String = "compressed";
		
		private var isRepeat:Boolean;
		
		public function Texture()
		{
		}
		public function uploadData(data:*=null):void {}
		
		public function get repeat():Boolean { return isRepeat; }
		
		public function get width():Number { return 0; }
		
		public function get height():Number { return 0; }
		
		public function get format():String { return Context3DTextureFormat.BGRA; }
		
		public function get base():flash.display3D.textures.Texture { return null; }
		
		public function get mipMapping():Boolean { return false; }	
	}
}