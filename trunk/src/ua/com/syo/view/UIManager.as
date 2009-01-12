package ua.com.syo.view {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import ua.com.syo.data.CurrentData;
	import ua.com.syo.data.Globals;
	import ua.com.syo.model.Model;
	import ua.com.syo.view.events.ControlEvent;

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
		public var startImageContainer:Sprite;
		public var playListView:PlaylistView;
		public var startImage:StartImage;
		
		public function init():void {
			videoArea = new VideoArea(this);
			videoArea.setSize(Globals.stageWidth, Globals.stageHeight - Globals.controlBarHeight);
			
			startImageContainer = new Sprite();
			addChild(startImageContainer);
			
			controlPanel = new ControlPanel();
			controlPanel.addEventListener(ControlEvent.CONTROL_ACTION, controlActionHandler);
			addChild(controlPanel);
			
		}
		
		public static var tf:TextField = new TextField();
		
		public function showStartImage():void {
			startImage = new StartImage(CurrentData.instance.getStartImage());
			startImageContainer.addChild(startImage);
			startImage.setSize(Globals.stageWidth, Globals.stageHeight - Globals.controlBarHeight);
			startImage.addEventListener(MouseEvent.CLICK, bigPlayButtonClicked);
		}
		
		private function controlActionHandler(event:ControlEvent):void {
			if (event.actionType == "play") {
				playVideo();
			} else if (event.actionType == "pause") {
				videoArea.stop();
			}
			
		}
		
		private function bigPlayButtonClicked(event:MouseEvent):void {
			playVideo();
			controlPanel.playStopButton.gotoAndStop("pause");
		}
		
		public function playVideo():void {
			if (startImage && startImageContainer.contains(startImage)) {
				startImageContainer.removeChild(startImage);
			}
			videoArea.play();
		}
		
		public function updateSlider():void {
			
		}
		
		public function showPlayListView():void {
			if (playListView) {
				if (startImage) {
					startImage.visible = true;
				}
				removeChild(playListView);
				playListView = null;
			} else {
				if (startImage) {
					startImage.visible = false;
				}
				playListView = new PlaylistView();
				playListView.addItems(Model.instance.itemCollection);
				addChild(playListView);
			}
		}
		
	}
}