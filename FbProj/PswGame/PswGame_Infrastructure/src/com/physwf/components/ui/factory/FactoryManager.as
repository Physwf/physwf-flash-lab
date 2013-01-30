package com.physwf.components.ui.factory
{
	public class FactoryManager
	{
		public static var barFactory:BarFactory = new BarFactory();
		public static var btnFactory:ButtonFactory = new ButtonFactory();
		public static var cellFactroy:CellFactory = new CellFactory();
		public static var panelFactory:PanelFactory = new PanelFactory();
		
		public function FactoryManager()
		{
			
		}
	}
}