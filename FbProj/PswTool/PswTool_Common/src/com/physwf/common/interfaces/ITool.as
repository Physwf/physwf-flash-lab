package com.physwf.common.interfaces
{
	import spark.components.Application;

	public interface ITool
	{
		function execute(root:Application):void;
		function exit():void;
	}
}