package psw2d.display
{
	import flash.geom.Matrix;
	
	import psw2d.render.RenderMaster;
	import psw2d.utlis.QuadVertex;

	/**
	 *	0 -	1
	 * 	| /	|
	 * 	3 - 2
	 * @author Physwf
	 * 
	 */	
	public class Quad extends DisplayObject
	{
		private var _scaleX:Number = 1;
		private var _scaleY:Number = 1;
		private var _color:uint;
		
		
		private var _modelMatrix:Matrix;
		private var _isMatrixDirty:Boolean = false;
		
		protected var _vertexData:QuadVertex;
		
		public function Quad(w:Number,h:Number,color:uint=0xFFFFFFFF)
		{
			x = 0;
			y = 0;
			width = w;
			height = h;
			_color = color;
			_tined = color != 0xFFFFFFFF;
			
			_vertexData = new QuadVertex();
			_vertexData.setPosition(0,0,0);
			_vertexData.setPosition(1,width,0);
			_vertexData.setPosition(2,width,height);
			_vertexData.setPosition(3,0,height);
			
			_vertexData.setColor(0,_color);
			_vertexData.setColor(1,_color);
			_vertexData.setColor(2,_color);
			_vertexData.setColor(3,_color);
			
			_modelMatrix = new Matrix();
		}
		
		public function get color():uint
		{
			return _color;
		}

		public function set color(value:uint):void
		{
			_color = value;
			_vertexData.setColor(0,_color);
			_vertexData.setColor(1,_color);
			_vertexData.setColor(2,_color);
			_vertexData.setColor(3,_color);
//			if()
			
		}

		public function setCoords(index:int,x:Number,y:Number):void
		{
			_vertexData.setPosition(index,x,y);
		}
		
		public function get vertexData():QuadVertex
		{
			return _vertexData;
		}

		override public function render(renderMaster:RenderMaster, parentAlpha:Number=1.0):void
		{
			renderMaster.bacthDisplay(this,parentAlpha);
		}
	}
}