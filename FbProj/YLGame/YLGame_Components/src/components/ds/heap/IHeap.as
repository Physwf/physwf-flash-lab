package components.ds.heap
{
	import components.interfaces.INumerical;
	
	public interface IHeap
	{
		function Enqueue(item:INumerical):void;
		function Dequeue():INumerical;
		function hasItem(item:INumerical):Boolean;
		function get size():int;
	}
}