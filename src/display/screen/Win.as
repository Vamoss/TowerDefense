package display.screen{	import flash.display.MovieClip;
	import flash.text.TextField;

	public class Win extends MovieClip{				private var label:TextField;				public function Win(){						graphics.beginFill(0xFFFFFF);			graphics.drawRect(0,0,9000,9000);			graphics.endFill();						label = new TextField();			label.x = 80;			label.y = 150;			label.width = 390;			label.text = "Congratulations! You ve beaten the game!";			addChild(label);		}	}}