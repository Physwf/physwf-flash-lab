package psw2d.display.animation
{
	public class AnimationMaster implements IAnimation
	{
		private var _objects:Vector.<IAnimation>;
		
		public function AnimationMaster()
		{
			_objects = new <IAnimation>[];
		}
		
		public function add(object:IAnimation):void
		{
			_objects.push(object);
		}
		
		public function addvanceTime(time:Number):void
		{
			var len:int = _objects.length;
			for(var i:int=0;i<len;++i)
			{
				_objects[i].addvanceTime(time);
			}
		}
		
	}
}