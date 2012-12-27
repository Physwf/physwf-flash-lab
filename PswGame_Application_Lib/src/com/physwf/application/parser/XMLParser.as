package com.physwf.application.parser
{
	import com.physwf.application.plugin.DomainInfo;
	import com.physwf.application.plugin.PluginInfo;

	public class XMLParser implements IParser
	{
		public function XMLParser()
		{
		}
		/**
		 * 解析脚本并返回命令队列。
		 * 命令的结构为[name,type,url,domain,useSub]，其中最后一项的值类型为Boolean
		 * @param data
		 * @return 
		 * 
		 */		
		public function parse(data:*):Vector.<PluginInfo>
		{
			var script:XML = data as XML;
			var comands:XMLList = script.item;
			var ret:Vector.<PluginInfo> = new <PluginInfo>[];
			var domainRaw:XML;
			for(var i:int=0;i<comands.length();++i)
			{
				domainRaw = comands[i].domain[0];
				var domain:DomainInfo = new DomainInfo( int(domainRaw.@level) ,domainRaw.@useSub=="1", domainRaw.@name);
				ret[i]  = new PluginInfo(comands[i].@name,comands[i].@type,comands[i].@url,domain);
			}
			return ret;
		}
	}
}