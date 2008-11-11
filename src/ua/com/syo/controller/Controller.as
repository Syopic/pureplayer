package ua.com.syo.controller {
	import ua.com.syo.view.UIManager;
	import ua.com.syo.view.VideoArea;
	
	
	public class Controller	{
		
		/**
		 * Singleton
		 */
		private static var _instance:Controller;

		public static function get instance():Controller {
			if (_instance == null) {
				_instance = new Controller();
			}
			return _instance;
		}
		
		private var videoArea:VideoArea; 
		
		public function init(w:Number, h:Number):void {
			UIManager.instance.init();
			videoArea = UIManager.instance.videoArea;
			
			videoArea.setSize(w, h - 40);
		}
	}
}