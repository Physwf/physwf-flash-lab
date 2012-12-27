package com.physwf.application.parser
{
	import com.physwf.application.plugin.PluginInfo;

	public interface IParser
	{
		/**
		 * 解析脚本数据 
		 * @param data 
		 * @return 返回命令队列
		 * 
		 */		
		function parse(data:*):Vector.<PluginInfo>;
	}
}