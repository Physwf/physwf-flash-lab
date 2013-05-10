package com.physwf.engine.script
{
	import com.physwf.components.interfaces.IDisposible;
	import com.physwf.components.interfaces.IUpdatable;
	
	public interface INPCScript extends IUpdatable,IDisposible
	{
		function initialize():void;
	}
}