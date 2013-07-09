package
{
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import components.bitmap.net.SkeletonLoader;
	import components.character.CharacterAnimation;
	import components.character.enums.AvatarConfig;
	import components.character.enums.CharacterAction;
	
	[SWF(width="1000",height="600",frameRate="30", backgroundColor="#0")]
	public class SkeletonTest extends Sprite
	{
		private var mCharas:Vector.<CharacterAnimation>;
		private var lastTime:uint;
		
		public function SkeletonTest()
		{
			skeletonTest();
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}
		
		private function skeletonTest():void
		{
			mCharas = new Vector.<CharacterAnimation>();
			var nude:SkeletonLoader = SkeletonLoader.getSameSkeletonLoader("cdn_n/assets/armor/10_00001");
			var weapon:SkeletonLoader = SkeletonLoader.getSameSkeletonLoader("cdn_n/assets/weapon/10_00002");
			var mask:SkeletonLoader = SkeletonLoader.getSameSkeletonLoader("cdn_n/assets/armor/40003/mask");
			var ride:SkeletonLoader = SkeletonLoader.getSameSkeletonLoader("cdn_n/assets/armor/40003");
			var wing:SkeletonLoader = SkeletonLoader.getSameSkeletonLoader("cdn_n/assets/wing/10_00001");
			
			for(var i:uint = 0; i< 8; i++)
			{
				var chara:CharacterAnimation = new CharacterAnimation();
				chara.action = CharacterAction.ACTION_RIDE_RUN;
				chara.direction = i;
				chara.skeleton = nude;
				
				chara.body.changeWear(0,nude);
				chara.body.changeWear(1,weapon);
				chara.body.changeWear(2,wing);
				chara.body.changeWear(3,ride);
				chara.body.changeWear(4,mask);
				
				
				chara.body.setDepths(AvatarConfig.direct2depths[i]);
				chara.x = (i%4)*250+100;
				chara.y = Math.floor(i/4) * 300 +200;
				/*if(Math.random() > 0.9)*/ addChild(chara);
				//				chara.x = Math.random() * 1024
				//				chara.y = Math.random() * 600;
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