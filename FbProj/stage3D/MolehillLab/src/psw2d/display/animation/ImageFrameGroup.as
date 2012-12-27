package psw2d.display.animation
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;

	public class ImageFrameGroup
	{
		private var _name:String;
		private var _startFrame:int;
		private var _endFrame:int;
		
		public function ImageFrameGroup(name:String,start:int,end:int)
		{
			_name = name; _startFrame = start; _endFrame = end;
		}
		
		public function get name():String
		{
			return _name;
		}

		public function get startFrame():int
		{
			return _startFrame;
		}

		public function get endFrame():int
		{
			return _endFrame;
		}


	}
}