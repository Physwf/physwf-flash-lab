package reader
{
	import flash.display.BitmapData;
	import flash.events.IEventDispatcher;

	public interface IReader extends IEventDispatcher
	{
		function readFile(path:String):void;
		function readDir():void;
		function get data():Vector.<BitmapData>;
	}
}