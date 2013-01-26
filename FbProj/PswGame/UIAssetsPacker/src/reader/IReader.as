package reader
{
	import flash.display.BitmapData;
	import flash.events.IEventDispatcher;

	public interface IReader extends IEventDispatcher
	{
		function readFile(path:String):void;
		function readDir(paths:Vector.<String>):void;
		function get data():Vector.<BitmapData>;
		function clear():void;
	}
}