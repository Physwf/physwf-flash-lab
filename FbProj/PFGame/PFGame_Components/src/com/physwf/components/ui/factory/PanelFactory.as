package com.physwf.components.ui.factory
{
	import com.physwf.components.ui.SpriteLoader;
	import com.physwf.components.ui.assets.PanelAssets;
	import com.physwf.components.ui.config.PanelConfig;
	import com.physwf.components.ui.layout.Panel;
	
	import flash.events.Event;
	import flash.utils.Dictionary;

	public class PanelFactory
	{
		private var assets:Dictionary;
		
		public function PanelFactory()
		{
			assets = new Dictionary();
		}
		
		public function createPanel(config:PanelConfig):Panel
		{
			var asset:PanelAssets;
			if(assets[config])
			{
				asset = assets[config] as PanelAssets;
			}
			else
			{
				asset = new PanelAssets();
				assets[config] = asset;
				var sLoader:SpriteLoader = SpriteLoader.getSameSpriteLoader(config.url);
				function onComplete(e:Event):void
				{
					sLoader.removeEventListener(Event.COMPLETE,onComplete);
					asset.asset = sLoader.getAsset(config.assetsID);
					asset.scale9Grid = config.scale9Grid;
					asset.isDirty = true;
				};
				sLoader.addEventListener(Event.COMPLETE,onComplete);
				sLoader.load();
			}
			
			return new Panel(asset);
		}
	}
}