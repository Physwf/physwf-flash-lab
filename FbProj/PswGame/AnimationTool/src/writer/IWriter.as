package writer
{
	import struct.SkeletonStruct;

	public interface IWriter
	{
		function writeSkeleton(skeletonStruct:SkeletonStruct):void;
	}
}