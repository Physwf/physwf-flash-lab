package psw2d.display.animation
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.flash_proxy;

	public class ImageKeyFrame
	{
		/**
		 * 帧数据。即纹理坐标，从0到3，共四组，每组2个数据。 
		 */		
		private var _frameData:Vector.<Number>;
		
		public function ImageKeyFrame()
		{
			
		}
		
		public function get frameData():Vector.<Number>
		{
			return _frameData;
		}
		
		public function readFrame(input:IDataInput):void
		{
			_frameData = new Vector.<Number>();
			for(var i:int=0;i<16;++i)
			{
				_frameData.push(input.readFloat());
			}
		}
		
		public function writeFrame(output:IDataOutput):void
		{
			
		}
	}
}