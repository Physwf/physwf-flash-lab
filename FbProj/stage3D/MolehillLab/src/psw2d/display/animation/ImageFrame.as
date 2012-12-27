package psw2d.display.animation
{
	public class ImageFrame
	{
		/**
		 * 对一个关键帧的引用 
		 */		
		private var _keyFrame:ImageKeyFrame;
		
		public function ImageFrame(keyFrame:ImageKeyFrame)
		{
			_keyFrame = keyFrame;
		}
		
		public function get keyFrame():ImageKeyFrame
		{
			return _keyFrame;
		}
	}
}