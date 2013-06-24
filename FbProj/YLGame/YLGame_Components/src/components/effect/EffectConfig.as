package components.effect
{
	public class EffectConfig
	{
		public var Definition:Class;
		public var url:String;
		public var life:uint;
		
		public function EffectConfig(def:Class,url:String,life:uint)
		{
			Definition = def;
			this.url = url;
			this.life = life;
		}
	}
}