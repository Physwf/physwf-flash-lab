package
{
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import components.character.CharacterAnimation;
	import components.effect.Effect;
	import components.effect.EffectConfig;
	
	[SWF(width="1900",height="1000",frameRate="30", backgroundColor="#0")]
	public class EffectTest extends Sprite
	{
		private var mCharas:Vector.<CharacterAnimation>;
		private var lastTime:uint;
		
		public function EffectTest()
		{
			effectTest();
			stage.scaleMode = StageScaleMode.NO_SCALE;
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
		
		private function onEnterFrame(e:Event):void
		{
			
			var delta:uint = getTimer() - lastTime;
			lastTime = getTimer();
			var effects:Vector.<Effect> = Effect.effects;
			for(var i:uint=0;i<effects.length;++i)
			{
				effects[i].update(delta);
			}
		}
	}
}