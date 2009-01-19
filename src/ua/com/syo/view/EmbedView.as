package ua.com.syo.view {
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.system.System;
	import flash.text.TextField;
	
	import ua.com.syo.data.Globals;

	public class EmbedView extends Sprite {
		
		[Embed(source = "/../assets/library.swf" , symbol = "EmbedPanel")]
		private var EmbedPanel:Class;
		
		private var panelContainer:Sprite;
		
		private var linkTF:TextField;
		private var codeTF:TextField;
		
		private var linkBut:SimpleButton;
		private var codeBut:SimpleButton;
		
		public function EmbedView() {
			panelContainer = new EmbedPanel();
			
			linkTF = panelContainer["linkTF"];
			codeTF = panelContainer["codeTF"];
			
			linkBut = panelContainer["linkBut"];
			codeBut = panelContainer["codeBut"];
			
			addChild(panelContainer);
			x =  Math.round((Globals.stageWidth / 2) - panelContainer.width / 2);
			y =  Math.round((Globals.stageHeight / 2) - panelContainer.height / 2) - 20;
			//System.setClipboard(
			
			linkBut.addEventListener(MouseEvent.CLICK, function():void {System.setClipboard(linkTF.text);} );
			codeBut.addEventListener(MouseEvent.CLICK, function():void {System.setClipboard(codeTF.text);} );
		}
		
	}
}