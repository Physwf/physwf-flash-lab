package psw2d.texture
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.textures.Texture;
		
	public class BitmapTexture extends psw2d.texture.Texture
	{
		private var _data:BitmapData;
		private var _mipMapping:Boolean;
		private var _width:Number;
		private var _height:Number;
		private var _base:flash.display3D.textures.Texture;
		
		public function BitmapTexture(base:flash.display3D.textures.Texture,data:*,mipMapping:Boolean)
		{
			if(data is Bitmap)
			{
				_data = (data as Bitmap).bitmapData;
			}
			else if(data is BitmapData)
			{
				_data = data as BitmapData;
			}
			else
			{
				throw "无效的位图数据格式！";
			}
			_base = base;
			_mipMapping = mipMapping;
			_width = data.width;
			_height = data.height;
		}
		
		public function get data():BitmapData { return _data; }
		override public function uploadData(data:*=null):void
		{
			if(data) _data = data as BitmapData;
			_base.uploadFromBitmapData(_data,0);
		}
		override public function get base():flash.display3D.textures.Texture { return _base; }
		override public function get format():String { return Context3DTextureFormat.BGRA; }
		override public function get width():Number { return _width; }
		override public function get height():Number { return _height; }
		override public function get mipMapping():Boolean { return _mipMapping; }
		
	}
}