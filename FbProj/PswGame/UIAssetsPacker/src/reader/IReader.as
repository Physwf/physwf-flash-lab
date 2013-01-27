package reader
{
	import flash.display.BitmapData;
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;

	public interface IReader extends IEventDispatcher
	{
		function readFile(path:String):void;
		function readDir(paths:Vector.<File>):void;
		function get data():Vector.<BitmapData>;
		function clear():void;
	}
}