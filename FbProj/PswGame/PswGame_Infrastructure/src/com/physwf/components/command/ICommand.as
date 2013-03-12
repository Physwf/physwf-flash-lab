package com.physwf.components.command
{
	import com.physwf.components.interfaces.INumerical;
	import com.physwf.components.interfaces.IUpdatable;
	
	import flash.events.IEventDispatcher;

	public interface ICommand extends IUpdatable,INumerical,IEventDispatcher
	{
		function execute():void;
	}
}