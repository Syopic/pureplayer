package ua.com.syo.view {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import ua.com.syo.data.Globals;

	public class UIManager extends Sprite {
		
		/**
		 * Singleton
		 */
		private static var _instance:UIManager;

		public static function get instance():UIManager {
			if (_instance == null) {
				_instance = new UIManager();
			}
			return _instance;
		}
		
		public var videoArea:VideoArea;
		public var controlPanel:ControlPanel;
		
		public function init():void {
			videoArea = new VideoArea(this);
			controlPanel = new ControlPanel();
			addChild(controlPanel);
		}
		
		public function updateSlider():void {
			
		}
		
	}
}