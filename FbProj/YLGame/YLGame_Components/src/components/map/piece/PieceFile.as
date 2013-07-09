package components.map.piece
{
	import components.pswloader.ImageFile;
	
	/**
	 * 用来加载地图切片 
	 * @author Physwf
	 * 
	 */	
	public class PieceFile extends ImageFile
	{
		public var x:uint;//切片的x坐标
		public var y:uint;//切片的y坐标
		
		public function PieceFile(url:String, uid:String,...args)
		{
			var postfix:String = args[0]?args[0]:".jpg";
			mUrl = url+postfix;
			super(mUrl, uid);
		}
	}
}