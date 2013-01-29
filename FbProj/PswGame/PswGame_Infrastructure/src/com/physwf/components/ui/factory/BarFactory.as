package com.physwf.components.ui.factory
{
	import com.physwf.components.ui.SpriteLoader;
	import com.physwf.components.ui.assets.BarAssets;
	import com.physwf.components.ui.config.BarConfig;
	import com.physwf.components.ui.layout.HBar;
	
	import flash.events.Event;
	import flash.utils.Dictionary;

	public class BarFactory
	{
		private var assets:Dictionary;
		
		public function BarFactory()
		{
			assets = new Dictionary();
		}
		
		public function createHBar(config:BarConfig):HBar
		{
			var asset:BarAssets;
			if(assets[config])
			{
				asset = assets[config] as BarAssets;
			}
			else
			{
				asset = new BarAssets();
				assets[config] = asset;
				var sLoader:SpriteLoader = SpriteLoader.getSameSpriteLoader(config.url);
				function onComplete(e:Event):void
				{
					sLoader.removeEventListener(Event.COMPLETE,onComplete);
					var count:uint = config.assets.length;
					for(var i:int=0;i<count;++i)
					{
						asset.parts.push(sLoader.getAsset(config.assets[i]));
						asset.isAssetsDirty = true;
					}
				};
				sLoader.addEventListener(Event.COMPLETE,onComplete);
				sLoader.load();
			}
			return new HBar(asset);
		}
	}
}