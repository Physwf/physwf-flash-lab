package components.character
{
	import flash.display.Sprite;
	
	import components.bitmap.net.SkeletonLoader;
	import components.character.enums.ISODirection;
	import components.interfaces.IUpdatable;
	import components.view.ISkeleton;
	
	public class CharacterAnimation extends Sprite implements ISkeleton,IUpdatable
	{
		private var mDirect:uint;
		private var mAction:uint;
		private var mStatus:uint;
		private var mDirty:Boolean;
		private var mActionDirty:Boolean;
		
		private var mBody:Avatar;
		public function get body():Avatar {return mBody; }
		
		public var interval:uint = 50;//最小更新周期
		private var mAccum:uint;//当前累积时间
		
		public function CharacterAnimation()
		{
			mouseChildren = false;
			mouseEnabled = false;
			mBody = new Avatar(this,0,5,"body");
		}
		
		public function set skeleton(v:SkeletonLoader):void
		{
		}
		
		public function set direction(v:uint):void
		{
			if(v == ISODirection.LEFT_DOWN)
			{
				v = ISODirection.RIGHT_DOWN;
				scaleX = -1;
			}
			else if(v == ISODirection.LEFT)
			{
				v = ISODirection.RIGHT;
				scaleX = -1;
			}
			else if(v == ISODirection.LEFT_UP)
			{
				v = ISODirection.RIGHT_UP;
				scaleX = -1;
			}
			else
			{
				scaleX = 1;
			}
			if(mDirect == v) return;
			mBody.direction = v;
			//mBody.setDepths(AvatarConfig.direct2depths[mDirect]);
			mDirect = v;
		}
		
		public function set action(v:uint):void
		{
			mAction = v;
			mBody.action = v;
		}
		
		public function set status(v:uint):void
		{
			mStatus = v;
			mBody.status = v;
		}
	
		public function set cull(v:Boolean):void
		{
			body.cull = v;
		}
		
		public function update(delta:uint):void
		{
			var numStep:uint = mAccum / interval;
			if(numStep>0)
			{
				mAccum %= interval;
			}
			else
			{
				mAccum+=delta;
			}
			mBody.step(numStep);
		}
	}
}