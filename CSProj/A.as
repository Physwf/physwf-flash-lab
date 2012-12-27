package
{
	import flash.display.Shape;
	import flash.events.Event;
	import flash.display.Sprite;
	
	public class A 
	{
		//private var s:Shape = new Shape();
		private var s:Sprite = new Sprite();
		
		public function A()
		{
			s.addEventListener(Event.ENTER_FRAME,render);
		}
		
		private function render(e:Event):void
		{
			trace("11");
		}
	}
}