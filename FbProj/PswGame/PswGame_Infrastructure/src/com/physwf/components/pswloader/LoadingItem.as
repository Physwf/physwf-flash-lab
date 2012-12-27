package com.physwf.components.pswloader
{
	import com.physwf.components.interfaces.INumerical;
	
	import flash.net.URLStream;

	public class LoadingItem extends URLStream implements INumerical
	{
		protected var _id:String;
		
		protected var _priority:int;
		
		protected var _isLoaded:Boolean;
		protected var _isLoading:Boolean;
		
		public function LoadingItem(url:String,type:String)
		{
		}
		
		public function set priority(v:int):void
		{
			_priority = v;
		}
		
		public function get priority():int
		{
			return _priority;
		}
		
		public function get value():Number
		{
			return _priority;
		}
		
		public function stop():void
		{
			
		}
		
		internal function _parseOptions(props:Object):void
		{
			_id = props["id"];
			_priority = props["priority"];
		}
		
		
	}
}