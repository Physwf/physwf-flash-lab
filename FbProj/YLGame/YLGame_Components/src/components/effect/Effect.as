package components.effect
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import components.bitmap.display.BitmapFrame;
	import components.bitmap.display.BitmapPlayer;
	import components.interfaces.IDisposible;
	import components.interfaces.IUpdatable;
	
	public class Effect extends Sprite implements IUpdatable, IDisposible
	{
		public static var effects:Vector.<Effect> = new Vector.<Effect>();
		
		public var interval:uint = 50;//最小更新周期
		
		protected var mContent:BitmapPlayer;
		protected var mTarget:DisplayObject;
		protected var mSource:DisplayObject;
		protected var mLayer:Sprite;
		protected var mTime:uint;
		protected var mLife:uint;//单位ms
		protected var mBornTime:uint;
		protected var mCurFrameNum:uint;
		
		public function Effect(layer:Sprite,life:uint,source:DisplayObject=null,target:DisplayObject=null)
		{
			mLayer = layer;
			mLife = life;
			mTarget = target;
			mSource = source;
			mouseEnabled = false;
			mouseChildren = false;
			mContent = new BitmapPlayer();
			addChild(mContent);
			mLayer.addChild(this);
			mBornTime = getTimer();
			effects.push(this);
		}
		
		public function update(delta:uint=0):void
		{
			var numStep:uint = mTime / interval;
			if(numStep>0)
			{
				mTime %= interval;
			}
			else
			{
				mTime+=delta;
			}
			mContent.step(numStep);
		}
		
		public function setFrames(frames:Vector.<BitmapFrame>):void
		{
			mContent.bitmapFrames = frames;
		}
		
		public function destroy():void
		{
			effects.splice(effects.indexOf(this),1);
		}
		
		public static var zeroFrames:Vector.<BitmapFrame> = new <BitmapFrame>[new BitmapFrame()];
		public static function create(config:EffectConfig,layer:Sprite,source:DisplayObject=null,target:DisplayObject=null):Effect
		{
			var effect:Effect = new config.Definition(layer,config.life,source,target);
			effect.setFrames(zeroFrames);//必须放在load之前，否则将覆盖load完成时的setFrame
			var eLoader:EffectLoader = EffectLoader.getSameEffectLoader(config.url);
			function onComplete(e:Event):void
			{
				eLoader.removeEventListener(Event.COMPLETE,onComplete);
				effect.setFrames(eLoader.getFrames());
			};
			eLoader.addEventListener(Event.COMPLETE,onComplete);
			eLoader.load();
			
			return effect;
		}
	}
}