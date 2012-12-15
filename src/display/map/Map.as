package display.map{
	import flash.display.Sprite;
	
	public class Map extends Sprite
	{
		
		//setting vars to step in for turns and special blocks
		public static const S:String = 'START';
		public static const F:String = 'FINISH';
		public static const U:String = 'UP';
		public static const R:String = 'RIGHT';
		public static const D:String = 'DOWN';
		public static const L:String = 'LEFT';
		
		private var _root:TowerDefense;
		
		public function Map(root:TowerDefense)
		{
			_root = root;
		}
		
		public function makeRoad():void{
			var row:int = 0;//the current row we're working on
			var block:Block;//this will act as the block that we're placing down
			for(var i:int=0;i<_root.game.level.lvlArray.length;i++){//creating a loop that'll go through the level array
				if(_root.game.level.lvlArray[i] == 0){//if the current index is set to 0
					block = new EmptyBlock(_root, (i-row*22)*_root.gridScale, row*_root.gridScale);//create a gray empty block
					addChild(block);
				} else if(_root.game.level.lvlArray[i] == 1){//if there is supposed to be a row
					//just add a box that will be a darker color and won't have any actions
					block = new RoadBlock(_root, (i-row*22)*_root.gridScale, row*_root.gridScale);
					addChild(block);//add it to the roadHolder
				} else if(_root.game.level.lvlArray[i] is String){//if it's a string, meaning a special block
					//then create a special block
					block = new DirectBlock(_root, (i-row*22)*_root.gridScale, row*_root.gridScale, _root.game.level.lvlArray[i]);
					addChild(block);
				}
				for(var c:int = 1;c<=16;c++){
					if(i == c*22-1){
						//if 22 columns have gone by, then we move onto the next row
						row++;
					}
				}
			}
		}
	}
}
