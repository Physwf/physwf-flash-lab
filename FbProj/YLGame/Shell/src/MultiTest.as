package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import components.bitmap.net.SkeletonLoader;
	import components.character.CharacterAnimation;
	import components.character.enum.CharacterAction;
	import components.character.enum.ISODirection;
	
	[SWF(width="1900",height="1000",frameRate="30", backgroundColor="#0")]
	public class MultiTest extends Sprite
	{
		private var mCharas:Vector.<CharacterAnimation>;
		private var lastTime:uint;
		
		public function MultiTest()
		{
			multiTest();
		}
		
		private function multiTest():void
		{
			mCharas = new Vector.<CharacterAnimation>();
			var nude:SkeletonLoader = SkeletonLoader.getSameSkeletonLoader("cdn_n/assets/armor/10_00001");
			
			for(var i:uint = 0; i< 500; i++)
			{
				var chara:CharacterAnimation = new CharacterAnimation();
				
				chara.action = CharacterAction.ACTION_RUN;
				chara.direction = ISODirection.DOWN;
				chara.skeleton = nude;
				
				chara.body.changeWear(0,nude);
				
				//				chara.body.setDepths(AvatarConfig.direct2depths[i]);
				if(Math.random() > 0.6) 
				{
					chara.x = Math.random() * stage.stageWidth
					chara.y = Math.random() * stage.stageHeight;
				}
				else
				{
					chara.x = 10000;
				}
				addChild(chara);
				
				mCharas.push(chara);
			}
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
			lastTime = getTimer();
		}
		
		private function onEnterFrame(e:Event):void
		{
			
			var delta:uint = getTimer() - lastTime;
			lastTime = getTimer();
			for(var i:uint=0;i<mCharas.length;++i)
			{
				mCharas[i].update(delta);
			}
			return;
		}
	}
}