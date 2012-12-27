package psw2d.render
{
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Matrix3D;
	
	import psw2d.Alcedo;
	import psw2d.core.Context2D;
	import psw2d.display.DisplayObject;
	import psw2d.texture.Texture;

	public class RenderBase
	{
		protected var _numDisplays:int;
		
		protected var _tinted:Boolean;
		protected var _texture:Texture;
		protected var _smoothing:String;
		
		protected var _blendMode:String;
		
		public function RenderBase()
		{
			Alcedo.instance.addEventListener("contextCreated",onContextCreated);
		}
		
		protected function onContextCreated(e:Event):void
		{
			
		}
		
		public function addDisplay(display:DisplayObject,parentAlpha:Number=1.0,texture:Texture=null,
												smoothing:String=null,modelViewMatrix:Matrix=null,
												blendMode:String=null):DisplayObject
		{
			return null
		}
		
		public function render(projectionMatrix:Matrix3D):void
		{
			
		}
		
		public function reset():void
		{
			
		}
		
		public function isStateChange(parentAlpha:Number, texture:Texture, smoothing:String,
									   blendMode:String,tinted:Boolean = false,numDisplay:int=1):Boolean
		{
			if(_numDisplays==0) return false;
			else if(_numDisplays + numDisplay > 8192) return true;
			else if(_texture == null && texture == null) return false;
			else if(_texture != null && texture != null) 
				return 	_texture.base != texture.base ||
						_texture.repeat != texture.repeat ||
						_smoothing != smoothing ||
						_tinted != (tinted || parentAlpha != 1.0) ||
						_blendMode != blendMode;
			else return true;
		}

		public function canBatch(display:DisplayObject):Boolean
		{
			return false;
		}
		
		public function get blendMode():String
		{
			return _blendMode;
		}

		public function set blendMode(value:String):void
		{
			_blendMode = value;
		}

		public function get numDisplays():int
		{
			return _numDisplays;
		}


	}
}