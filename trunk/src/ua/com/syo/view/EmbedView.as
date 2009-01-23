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
			
			linkTF.text = "http://new.ppc.net.ua/ru/video/item/2/";
			codeTF.text = '<object height="250" width="390"><param name="movie" value="http://new.ppc.net.ua/images/pureplayer.swf" /><param name="allowFullScreen" value="true" /><param name="allowscriptaccess" value="always" /><param name="FlashVars" value="playlist=http://new.ppc.net.ua/uploaded/video/playlist.xml" /> <embed src="http://new.ppc.net.ua/images/pureplayer.swf" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" flashvars="playlist=http://new.ppc.net.ua/uploaded/video/playlist.xml" height="250" width="390"></embed></object>';

			
			addChild(panelContainer);
			x =  Math.round((Globals.stageWidth / 2) - panelContainer.width / 2);
			y =  Math.round((Globals.stageHeight / 2) - panelContainer.height / 2) - 20;
			//System.setClipboard(
			
			linkBut.addEventListener(MouseEvent.CLICK, function():void {System.setClipboard(linkTF.text);} );
			codeBut.addEventListener(MouseEvent.CLICK, function():void {System.setClipboard(codeTF.text);} );
		}
		
	}
}