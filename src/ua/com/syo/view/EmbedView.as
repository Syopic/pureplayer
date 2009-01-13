package ua.com.syo.view {
	import flash.display.Sprite;
	
	import ua.com.syo.data.Globals;

	public class EmbedView extends Sprite {
		
		[Embed(source = "/../assets/library.swf" , symbol = "EmbedPanel")]
		private var EmbedPanel:Class;
		
		private var panelContainer:Sprite;
		
		public function EmbedView() {
			panelContainer = new EmbedPanel();
			addChild(panelContainer);
			x =  Math.round((Globals.stageWidth / 2) - panelContainer.width / 2);
			y =  Math.round((Globals.stageHeight / 2) - panelContainer.height / 2) - 20;
		}
		
	}
}