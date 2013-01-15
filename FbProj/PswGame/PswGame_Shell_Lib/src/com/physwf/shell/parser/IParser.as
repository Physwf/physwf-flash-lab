package com.physwf.shell.parser
{
	import com.physwf.shell.plugin.PluginInfo;

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