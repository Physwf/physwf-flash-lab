package com.physwf.components.ui.factory
{
	import com.physwf.components.ui.SpriteLoader;
	import com.physwf.components.ui.assets.CellAssets;
	import com.physwf.components.ui.config.CellConfig;
	import com.physwf.components.ui.controls.Cell;
	
	import flash.events.Event;
	import flash.utils.Dictionary;

	public class CellFactory
	{
		private var assets:Dictionary;
		
		public function CellFactory()
		{
			assets = new Dictionary();
		}
		
		public function createCell(config:CellConfig):Cell
		{
			var asset:CellAssets;
			if(assets[config])
			{
				asset = assets[config] as CellAssets;
			}
			else
			{
				asset = new CellAssets();
				asset.size = config.size;
				assets[config] = asset;
				var sLoader:SpriteLoader = SpriteLoader.getSameSpriteLoader(config.url);
				function onComplete(e:Event):void
				{
					sLoader.removeEventListener(Event.COMPLETE,onComplete);
					asset.bg = sLoader.getAsset(config.bg);
					asset.downstate = sLoader.getAsset(config.down);
					asset.overstate = sLoader.getAsset(config.over);
					asset.upstate = sLoader.getAsset(config.up);
				};
				sLoader.addEventListener(Event.COMPLETE,onComplete);
				sLoader.load();
			}
			return new Cell(asset);
		}
	}
}