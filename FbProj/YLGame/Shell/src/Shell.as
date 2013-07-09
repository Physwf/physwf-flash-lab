package
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	import components.bitmap.net.SkeletonLoader;
	import components.character.CharacterAnimation;
	import components.character.enums.AvatarConfig;
	import components.character.enums.CharacterAction;
	import components.character.enums.ISODirection;
	import components.effect.Effect;
	import components.effect.EffectConfig;
	import components.map.MapView;
	import components.map.piece.PieceLoader;
	import components.utils.Stats;
	
	import engine.world.objects.Map;
	
	[SWF(width="1900",height="1000",frameRate="30", backgroundColor="#0")]
	public class Shell extends Sprite
	{
		private var tf:TextField;
		private var mCharas:Vector.<CharacterAnimation>;
		private var lastTime:uint;
		private var mStatus:Stats;
		
		public function Shell()
		{
			//skeletonTest();
			//mapTest();
//			mapTest2();
			
			var s:String = "112ddsfgdf4535341sdfa345353q4";
			trace(s.replace(/[^0-9]/g,""));
			
//			OSDTest();
//			multiTest();
			loadMain();
			var b:ByteArray = new ByteArray();
			b[0] = 1;
			trace(1<<0)
			trace((1<<(2&0x7)).toString(2));
			return;
			trace((0xF0F0F0F0 & 0xFF000000) >> 24)
			
			var color:uint = 0xF0F0F0F0;
			var a:uint =	(color & 0xFF000000) >> 24;
			var red:uint =	(color & 0x00FF0000) >> 16;
			var green:uint =(color & 0x0000FF00) >> 8;
			var blue:uint = (color & 0x000000FF);
			trace(a.toString(16));
			trace(red.toString(16));
			trace(green.toString(16));
			trace(blue.toString(16));
			setBit(0);
			return;
			effectTest();
			mStatus = new Stats();
			addChild(mStatus);
			trace(2>>1);
		}
		private var map:Map;
		private function mapTest2():void
		{
			map = new Map();
			map.id = 10001;
			map.load();
			addChild(map.view);
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		
		private function setBit(index : uint) : void 
		{
			var ba:ByteArray = new ByteArray;
			ba[index >> 3] |= (1 << (index & 0x7));
			trace(ba[0]);
		}
		private function effectTest():void
		{
			var eCfg0:EffectConfig = new EffectConfig(Effect,"cdn_n/assets/effect/basket_atk10",10);
			var eCfg1:EffectConfig = new EffectConfig(Effect,"cdn_n/assets/effect/wand_atk10",10);
			var eCfg2:EffectConfig = new EffectConfig(Effect,"cdn_n/assets/effect/treasure_atk1005",10);
			var eCfg3:EffectConfig = new EffectConfig(Effect,"cdn_n/assets/effect/wand_atked05",10);
			var eCfg4:EffectConfig = new EffectConfig(Effect,"cdn_n/assets/effect/lantern_atk06",10);
			var eCfg5:EffectConfig = new EffectConfig(Effect,"cdn_n/assets/effect/brush_atkpro06",10);
			var eCfg6:EffectConfig = new EffectConfig(Effect,"cdn_n/assets/effect/monster_atkpro01",10);
			var eCfg7:EffectConfig = new EffectConfig(Effect,"cdn_n/assets/effect/lantern_atked02",10);
			var configs:Vector.<EffectConfig> = new Vector.<EffectConfig>();
			configs.push(eCfg0,eCfg1,eCfg2,eCfg3,eCfg4,eCfg5,eCfg6,eCfg7);
			for(var i:uint = 0; i< 100; i++)
			{
				var e:Effect = Effect.create(configs[uint(Math.random() * 8)],this);
//				e.y = Math.floor(i/4) * 500;
//				e.x = (i%4) * 400+400;
				e.x = Math.random() * 1900;
				e.y = Math.random() * 900-300;
			}
			
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		
		private function mapTest():void
		{
			var mapView:MapView = new MapView();
			var pgLoader:PieceLoader = PieceLoader.create("cdn_n/assets/maps/10001",mapView.bottom);
			pgLoader.load();
			addChild(mapView);
		}
		
		private function OSDTest():void
		{
			mCharas = new Vector.<CharacterAnimation>();
			var nude:SkeletonLoader = SkeletonLoader.getSameSkeletonLoader("cdn_n/assets/armor/10_00001");
			
			for(var i:uint = 0; i< 100; i++)
			{
				var chara:CharacterAnimation = new CharacterAnimation();
				
				chara.action = CharacterAction.ACTION_RUN;
				chara.direction = ISODirection.DOWN;
				chara.skeleton = nude;
				
				chara.body.changeWear(0,nude);
				
//				chara.body.setDepths(AvatarConfig.direct2depths[i]);
				/*if(Math.random() > 0.9)*/ addChild(chara);
				chara.x = Math.random() * stage.stageWidth
				chara.y = Math.random() * stage.stageHeight;
				mCharas.push(chara);
			}
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
			lastTime = getTimer();
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
//			mStatus.update();
			for(var i:uint=0;i<mCharas.length;++i)
			{
				mCharas[i].update(delta);
			}
			//map.update(delta);
			return;
//			var effects:Vector.<Effect> = Effect.effects;
//			for(var i:uint=0;i<effects.length;++i)
//			{
//				effects[i].update(delta);
//			}
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
		}
	}
}