package components.command
{
	import components.interfaces.INumerical;
	import components.interfaces.IUpdatable;
	
	import flash.events.IEventDispatcher;
	
	public interface ICommand extends IUpdatable,INumerical,IEventDispatcher
	{
		function execute():void;
	}
}