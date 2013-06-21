package
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.utils.getTimer;
	
	import components.bitmap.net.SkeletonLoader;
	import components.character.Avatar;
	import components.character.CharactorAnimation;
	import components.character.enum.AvatarConfig;
	import components.character.enum.CharacterAction;
	import components.character.enum.ISODirection;
	import components.utils.Stats;
	
	[SWF(width="1024",height="600",frameRate="30", backgroundColor="#0")]
	public class Shell extends Sprite
	{
		private var tf:TextField;
		private var mCharas:Vector.<CharactorAnimation>;
		private var lastTime:uint;
		private var mStatus:Stats;
		
		public function Shell()
		{
			skeletonTest();
		}
		
		private function skeletonTest():void
		{
			mCharas = new Vector.<CharactorAnimation>();
			var nude:SkeletonLoader = SkeletonLoader.getSameSkeletonLoader("cdn_n/assets/armor/10_00001");
			var weapon:SkeletonLoader = SkeletonLoader.getSameSkeletonLoader("cdn_n/assets/weapon/10_00002");
			var mask:SkeletonLoader = SkeletonLoader.getSameSkeletonLoader("cdn_n/assets/armor/40003/mask");
			var ride:SkeletonLoader = SkeletonLoader.getSameSkeletonLoader("cdn_n/assets/armor/40003");
			var wing:SkeletonLoader = SkeletonLoader.getSameSkeletonLoader("cdn_n/assets/wing/10_00001");
				
			for(var i:uint = 0; i< 8; i++)
			{
				var chara:CharactorAnimation = new CharactorAnimation();
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
			mStatus = new Stats();
			addChild(mStatus);
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
			lastTime = getTimer();
		}
		
		private function onEnterFrame(e:Event):void
		{
			var delta:uint = getTimer() - lastTime;
			lastTime = getTimer();
			mStatus.update();
			for(var i:uint=0;i<mCharas.length;++i)
			{
				mCharas[i].update(delta);
			}
		}
		
		private function loadMain():void
		{
			var loader:Loader = new Loader();
			function onComplete(e:Event):void
			{
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onComplete);
				addChild(loader.content);
			}
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
			loader.load(new URLRequest("D:/m3web/client/bin/launcher.swf"));
		}
		
		private function onChange(e:Event):void
		{
		}
		
		private function onPaste(e:Event):void
		{
			e.preventDefault();
			trace(tf.text)
		}
	}
}