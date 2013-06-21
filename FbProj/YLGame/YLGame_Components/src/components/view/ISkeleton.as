package components.view
{
	import components.bitmap.net.SkeletonLoader;
	
	public interface ISkeleton
	{
		function set skeleton(v:SkeletonLoader):void;
		function set direction(v:uint):void;
		function set action(v:uint):void;
		function set status(v:uint):void;
	}
}