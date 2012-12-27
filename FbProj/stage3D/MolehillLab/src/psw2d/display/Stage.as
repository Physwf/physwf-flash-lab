package psw2d.display
{

	public class Stage extends DisplayObjectContainer
	{
		private var _stageWidth:Number;
		private var _stageHeight:Number;
		private var _stageColor:uint;
		
		public function Stage(sw:Number,sh:Number,color:uint)
		{
			_stageWidth = sw;
			_stageHeight = sh;
			_stageColor = color;
		}

		public function get stageWidth():Number
		{
			return _stageWidth;
		}

		public function set stageWidth(value:Number):void
		{
			_stageWidth = value;
		}

		public function get stageHeight():Number
		{
			return _stageHeight;
		}

		public function set stageHeight(value:Number):void
		{
			_stageHeight = value;
		}

		public function get stageColor():uint
		{
			return _stageColor;
		}

		public function set stageColor(value:uint):void
		{
			_stageColor = value;
		}


	}
}