package com.physwf.application.plugin
{
	public class PluginInfo
	{
		public var name:String;
		public var type:String;
		public var url:String;
		public var domain:DomainInfo;
		
		public function PluginInfo($name:String,$type:String,$url:String,$domain:DomainInfo):void
		{
			name = $name;
			type = $type;
			url = $url;
			domain = $domain;
		}
	}
}