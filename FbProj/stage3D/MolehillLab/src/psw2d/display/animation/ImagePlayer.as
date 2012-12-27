package psw2d.display.animation
{
	import psw2d.display.DisplayObject;
	import psw2d.display.Image;

	public class ImagePlayer extends DisplayObject implements IAnimation
	{
		private var _image:Image;
		private var _imagePackage:ImageFramePackage;
		
		public function ImagePlayer()
		{
			super();
//			_image = new Image();
		}
		
		public function addvanceTime(time:Number):void
		{
			
		}
	}
}