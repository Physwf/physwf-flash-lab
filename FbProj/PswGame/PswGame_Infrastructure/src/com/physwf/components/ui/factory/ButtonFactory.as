package com.physwf.components.ui.factory
{
	import com.physwf.components.ui.SpriteLoader;
	import com.physwf.components.ui.assets.ButtonAssets;
	import com.physwf.components.ui.config.ButtonConfig;
	import com.physwf.components.ui.controls.Button;
	
	import flash.events.Event;
	import flash.utils.Dictionary;
	

	public class ButtonFactory
	{
		private var assets:Dictionary;
		
		public function ButtonFactory()
		{
			assets = new Dictionary();
		}
		
		public function createButton(config:ButtonConfig):Button
		{
			var asset:ButtonAssets
			if(assets[config])
			{
				asset = assets[config] as ButtonAssets;
			}
			else
			{
				asset = new ButtonAssets();
				assets[config] = asset;
				var sLoader:SpriteLoader = SpriteLoader.getSameSpriteLoader(config.url);
				function onComplete(e:Event):void
				{
					sLoader.removeEventListener(Event.COMPLETE,onComplete);
					asset.upState = sLoader.getAsset(config.up);
					asset.overState = sLoader.getAsset(config.over);
					asset.downState = sLoader.getAsset(config.down);
					asset.hitState = sLoader.getAsset(config.hit);
				};
				sLoader.addEventListener(Event.COMPLETE,onComplete);
				sLoader.load();
			}
			return new Button(asset);
		}
	}
}