package com.physwf.engine.script
{
	import com.physwf.components.interfaces.IDisposible;
	import com.physwf.components.interfaces.IUpdatable;
	
	import flash.events.IEventDispatcher;

	public interface IMapScript extends IUpdatable,IDisposible,IEventDispatcher
	{
		function initialize():void;
	}
}