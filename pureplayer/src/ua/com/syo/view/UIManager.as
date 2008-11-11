package ua.com.syo.view {
	import flash.display.Sprite;

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
		
		public function init():void {
			videoArea = new VideoArea(this);
		}
		
	}
}