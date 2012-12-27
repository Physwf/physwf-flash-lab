package psw2d.display
{
	import flash.geom.Matrix;
	
	import psw2d.filters.FragmentFilter;
	import psw2d.render.RenderMaster;

	public class DisplayObject
	{
		private var _x:Number;
		private var _y:Number;
		private var _width:Number;
		private var _height:Number;
		private var _scaleX:Number;
		private var _scaleY:Number;
		private var _rotation:Number;
		private var _alpha:Number;
		protected var _tined:Boolean;
		private var _visible:Boolean;
		private var _blendMode:String;
		private var _filter:FragmentFilter;
		private var _transformationMatrix:Matrix;
		private var _parent:DisplayObjectContainer;
		private var _isOrientationChanged:Boolean;//显示对象的方位参数是否改变过
		
		private var _root:DisplayObjectContainer;
		private var _stage:Stage;
		
		public function DisplayObject()
		{
			_x = _y = _width = _height = _rotation = 0;
			_scaleX = _scaleY = _alpha = 1.0;
			_blendMode = BlendMode.AUTO;
			_visible = true;
			_transformationMatrix = new Matrix();
			_isOrientationChanged = false;
		}
		
		public function get x():Number
		{
			return _x;
		}

		public function set x(value:Number):void
		{
			if(_x != value)
			{
				_x = value;
				_isOrientationChanged = true;
			}
		}

		public function get y():Number
		{
			return _y;
		}

		public function set y(value:Number):void
		{
			if(_y != value)
			{
				_y = value;
				_isOrientationChanged = true;
			}
		}

		public function get width():Number
		{
			return _width;
		}

		public function set width(value:Number):void
		{
			if(_width != value)
			{
				_width = value;
				_isOrientationChanged = true;
			}
		}

		public function get height():Number
		{
			return _height;
		}

		public function set height(value:Number):void
		{
			if(_height != value)
			{
				_height = value;
				_isOrientationChanged = true;
			}
		}

		public function get scaleX():Number
		{
			return _scaleX;
		}

		public function set scaleX(value:Number):void
		{
			if(_scaleX != value)
			{
				_scaleX = value;
				_isOrientationChanged = true;
			}
		}

		public function get scaleY():Number
		{
			return _scaleY;
		}

		public function set scaleY(value:Number):void
		{
			if(_scaleY != value)
			{
				_scaleY = value;
				_isOrientationChanged = true;
			}
		}
		
		public function get rotation():Number
		{
			return _rotation;
		}
		
		public function set rotation(value:Number):void
		{
			_rotation = value;
		}
		
		public function get alpha():Number
		{
			return _alpha;
		}

		public function set alpha(value:Number):void
		{
			_alpha = value < 0.0 ? 0.0 : (value > 1.0 ? 1.0 : value); 
		}

		public function get tined():Boolean
		{
			return _tined;
		}
		
		public function get visible():Boolean
		{
			return _visible;
		}
		
		public function set visible(value:Boolean):void
		{
			_visible = value;
		}
		
		public function get blendMode():String
		{
			return _blendMode;
		}
		
		public function set blendMode(value:String):void
		{
			_blendMode = value;
		}
		
		public function get filter():FragmentFilter
		{
			return _filter;
		}
		
		public function set filter(value:FragmentFilter):void
		{
			_filter = value;
		}
		
		public function get transformationMatrix():Matrix
		{
			if(_isOrientationChanged)
			{
				_transformationMatrix.identity();
				_transformationMatrix.translate(_x,_y);
				_transformationMatrix.rotate(_rotation);
				_transformationMatrix.scale(_scaleX,_scaleY);
				_isOrientationChanged = false;
			}
			return _transformationMatrix;
		}

		public function set transformationMatrix(value:Matrix):void
		{
			_isOrientationChanged = false;
			
			_x = _transformationMatrix.tx;
			_y = _transformationMatrix.ty;
			
			var a:Number = value.a;
			var b:Number = value.b;
			var c:Number = value.c;
			var d:Number = value.d;
			
			_transformationMatrix = value;
		}

		public function get parent():DisplayObjectContainer
		{
			return _parent;
		}

		public function render(renderMaster:RenderMaster,parentAlpha:Number=1.0):void
		{
			
		}

		internal function get hasVisibleArea():Boolean
		{
			return _alpha != 0 && _visible && _scaleX != 0 && _scaleY != 0;
		}

		public function get root():DisplayObjectContainer
		{
			return _root;
		}

		public function get stage():Stage
		{
			return _stage;
		}

	}
}