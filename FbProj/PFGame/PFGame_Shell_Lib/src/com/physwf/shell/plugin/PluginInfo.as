package com.physwf.shell.plugin
{
	public class PluginInfo
	{
		public var name:String;
		public var type:String;
		public var url:String;
		public var domain:DomainInfo;
		public var thread:uint;
		
		public function PluginInfo($name:String,$type:String,$thread:String,$url:String,$domain:DomainInfo):void
		{
			name = $name;
			type = $type;
			thread = uint($thread);
			url = $url;
			domain = $domain;
		}
	}
}