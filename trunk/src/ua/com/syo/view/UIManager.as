package ua.com.syo.view {
	import flash.display.Sprite;
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
		public var embedView:EmbedView;
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
		}
		
		private function controlActionHandler(event:ControlEvent):void {
			if (event.actionType == "play") {
				playVideo();
			} else if (event.actionType == "pause") {
				videoArea.stop();
			}
			
		}
		
		public function bigPlayButtonClicked():void {
			playVideo();
			controlPanel.playStopButton.gotoAndStop("pause");
		}
		
		public function endOfPlay():void {
			videoArea.stop();
			videoArea.seekStream(0);
			controlPanel.playStopButton.gotoAndStop("play");
			showStartImage();
			//showPlayListView();
		}
		
		public function playVideo():void {
			if (startImage && startImageContainer.contains(startImage)) {
				startImageContainer.removeChild(startImage);
			}
			videoArea.play();
			hidePlayListVideo();
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
		
		public function hidePlayListVideo():void {
			if (playListView) {
				if (startImage) {
					startImage.visible = true;
				}
				removeChild(playListView);
				playListView = null;
			}
		}
		
		public function showEmbedView():void {
			if (embedView) {
				/* if (startImage) {
					startImage.visible = true;
				} */
				removeChild(embedView);
				embedView = null;
			} else {
				/* if (startImage) {
					startImage.visible = false;
				} */
				embedView = new EmbedView();
				addChild(embedView);
			}
		}
		
	}
}