package com.physwf.application.plugin
{
	public class DomainInfo
	{
		public var level:int;
		public var useSub:Boolean;
		public var name:String;
		
		public function DomainInfo($level:int,$useSub:Boolean=false,$name:String=null)
		{
			level = $level;
			useSub = $useSub;
			name = $name;
		}
	}
}