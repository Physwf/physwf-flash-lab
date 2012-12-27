package cookie
{
	import flash.net.SharedObject;

	public class Cookie
	{
		public static var instance:Cookie = new Cookie();
		
		private var _writeMode:String;
		private var _writeModeSO:SharedObject;
		
		public function Cookie()
		{
			init();
		}
		
		private function init():void
		{
			_writeModeSO = SharedObject.getLocal("writeMode");
		}
		
		public function setWriteMode(mode:String):void
		{
			_writeMode = mode;
			_writeModeSO.data.writeMode = _writeMode;
			_writeModeSO.flush();
		}
		
		public function getWriteMode():String
		{
			return _writeModeSO.data.writeMode as String;
		}
	}
}