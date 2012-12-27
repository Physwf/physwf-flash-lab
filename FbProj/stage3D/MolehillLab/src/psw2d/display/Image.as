package psw2d.display
{
	import psw2d.render.RenderMaster;
	import psw2d.texture.Texture;

	/**
	 * 
	 * @author joe
	 * 
	 */
	public class Image extends Quad
	{
		public static const SMOOTHING_NONE:String = "none";
		public static const SMOOTHING_BILINEAR:String = "bilinear";
		public static const SMOOTHING_TRILINEAR:String = "trilinear";
		
		protected var _texture:Texture;
		private var _smoothing:String;
		
		public function Image(texture:Texture)
		{
			if(texture) 
			{
				var w:Number = texture.width;
				var h:Number = texture.height;
				
				super(w,h);
				
				_vertexData.setTexCoords(0,0.0,0.0);
				_vertexData.setTexCoords(1,1.0,0.0);
				_vertexData.setTexCoords(2,1.0,1.0);
				_vertexData.setTexCoords(3,0.0,1.0);
			}
			else
			{
				throw ArgumentError("参数不能为空！");
			}
			
			_texture = texture;
			_smoothing = SMOOTHING_BILINEAR;
		}
		
		public function setTexCoords(index:int,u:Number,v:Number):void
		{
			_vertexData.setTexCoords(index,u,v);
		}
		
		public function get smoothing():String { return _smoothing; }
		
		public function get texture():Texture { return _texture; }
		
		override public function render(renderMaster:RenderMaster, parentAlpha:Number=1.0):void
		{
			renderMaster.bacthDisplay(this,parentAlpha,_texture,_smoothing);
		}
	}
}