package  {
	import flash.display.MovieClip;
	
	public class MC extends  MovieClip
	{

		public function MC() 
		{
			trace("constructor");
			trace(name)
		}
		
		override public function set name(v:String):void
		{
			trace(v);
			//super.name = v;
			
		}
		//this.fun();
		public function fun():void
		{
			trace("222");
		}
		sFun();
		private static function sFun():void
		{
			trace("1111111111")
		}

	}
	
}
