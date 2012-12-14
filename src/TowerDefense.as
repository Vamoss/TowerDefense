package {
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	[SWF(width="550", height="400", frameRate="24", backgroundColor="#ffffff")]
	public class TowerDefense extends Sprite
	{
		
		//setting vars to step in for turns and special blocks
		private const S:String = 'START';
		private const F:String = 'FINISH';
		private const U:String = 'UP';
		private const R:String = 'RIGHT';
		private const D:String = 'DOWN';
		private const L:String = 'LEFT';
		
		public var startDir:String;//the direction the enemies go when they enter
		public var finDir:String;//the direction the enemies go when they exit
		public var startCoord:int;//the coordinates of the beginning of the road
		private var lvlArray:Array;//this array will hold the formatting of the roads
		
		//the names of these variables explain what they do
		private var currentLvl:int;
		public var isGameOver:Boolean;
		
		private var currentEnemy:int;//the current enemy that we're creating from the array
		private var enemyTime:int;//how many frames have elapsed since the last enemy was created
		private var enemyLimit:int;//how many frames are allowed before another enemy is created
		private var enemyArray:Array;//this array will tell the function when to create an enemy
		public var enemiesLeft:int;//how many enemies are left on the field
		
		public var money:int;//how much money the player has to spend on turrets
		public var lives:int;//how many lives the player has
		
		public var rangeCircle:Shape = new Shape();
		private var roadHolder:Sprite = new Sprite();//create an object that will hold all parts of the road
		public var enemyHolder:Sprite = new Sprite();
		
		private var txtLevel:TextField = new TextField();		
		private var txtMoney:TextField = new TextField();		
		private var txtLives:TextField = new TextField();		
		private var txtEnemiesLeft:TextField = new TextField();
		
		private var screenWin:ScreenWin = new ScreenWin();
		private var screenLose:ScreenLose = new ScreenLose();
		
		public function TowerDefense()
		{
			
			txtLevel.x = 
			txtMoney.x = 
			txtLives.x = 
			txtEnemiesLeft.x = 10;
			
			txtLevel.y = 310;
			txtMoney.y = 330;
			txtLives.y = 350;
			txtEnemiesLeft.y = 370;
			
			screenLose.addEventListener(MouseEvent.CLICK, restartGame);
			screenWin.addEventListener(MouseEvent.CLICK, restartGame);
			
			addChild(txtLevel);
			addChild(txtMoney);
			addChild(txtLives);
			addChild(txtEnemiesLeft);
			
			rangeCircle.graphics.beginFill(0x006600,.5);
			rangeCircle.graphics.drawCircle(12.5,12.5,100);
			rangeCircle.graphics.endFill();
			
			addChild(roadHolder);//add it to the stage
			
			addChild(enemyHolder);
			
			restartGame(null);
		}
		
		private function startGame():void{//we'll run this function every time a new level begins
			for(var i:int=0;i<enemyArray[currentLvl-1].length;i++){
				if(enemyArray[currentLvl-1][i] != 0){
					enemiesLeft ++;
				}
			}
		}
		
		private function restartGame(e:MouseEvent):void
		{
			if(contains(screenLose)) removeChild(screenLose);
			if(contains(screenWin)) removeChild(screenWin);
					
			initVars();
			makeRoad();
			startGame();
			
			addEventListener(Event.ENTER_FRAME, update);//adding an update function
		}
		
		private function gameOver():void
		{
			isGameOver=true;//set the game to be over
			
			//reset all the stats
			currentLvl = 1;
			currentEnemy = 0;
			enemyTime = 0;
			enemyLimit = 12;
			enemiesLeft = 0;
			
			removeEventListener(Event.ENTER_FRAME, update);//remove this listener
		}
		
		public function initVars():void{
			lvlArray = [
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,R,1,1,D,0,0,R,1,1,D,0,0,R,1,1,D,0,0,
				0,0,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,
				0,0,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,
				S,D,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,R,1,F,
				0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,0,0,0,
				0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,0,0,0,
				0,R,1,1,U,0,0,R,1,1,U,0,0,R,1,1,U,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
			];
			
			enemyArray = [
				[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],//1's will just represent an enemy to be created
				[2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2],//another row means another level
				[3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3],
				[100],
				[5,6,7,6,5,6,7,6,5,6,7,6,5,6,7,6,5,6,7,6,5,6,7,6,5,6,7,6,5],
				[250,250,250]
			];
			
			currentLvl = 1;
			isGameOver = false;
			
			currentEnemy = 0;
			enemyTime = 0;
			enemyLimit = 12;
			money=100;
			lives=20;
			
		}
		
		
		private function makeRoad():void{
			var row:int = 0;//the current row we're working on
			var block;//this will act as the block that we're placing down
			for(var i:int=0;i<lvlArray.length;i++){//creating a loop that'll go through the level array
				if(lvlArray[i] == 0){//if the current index is set to 0
					block = new EmptyBlock(this);//create a gray empty block
					block.graphics.beginFill(0x333333);
					block.graphics.drawRect(0,0,25,25);
					block.graphics.endFill();
					addChild(block);
					//and set the coordinates to be relative to the place in the array
					block.x= (i-row*22)*25;
					block.y = row*25;
				} else if(lvlArray[i] == 1){//if there is supposed to be a row
					//just add a box that will be a darker color and won't have any actions
					block = new Shape();
					block.graphics.beginFill(0x111111);
					block.graphics.drawRect(0,0,25,25);
					block.graphics.endFill();		
					block.x= (i-row*22)*25;
					block.y = row*25;	
					roadHolder.addChild(block);//add it to the roadHolder
				} else if(lvlArray[i] is String){//if it's a string, meaning a special block
					//then create a special block
					block = new DirectBlock(this, lvlArray[i],(i-row*22)*25,row*25);
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
		
		public function makeTurret(xValue:int,yValue:int):void{//this will need to be told the x and y values
			var turret:Turret = new Turret(this);//creating a variable to hold the Turret
			//changing the coordinates
			turret.x = xValue+12.5;
			turret.y = yValue+12.5;
			addChild(turret);//add it to the stage
		}
		
		private function update(e:Event):void{
			//if there aren't any levels left
			if(currentLvl > enemyArray.length){
				gameOver();
				addChild(screenWin);
				return;
			}
			if(lives<=0){//if the user runs out of lives
				gameOver();
				addChild(screenLose);
				return;
			}
			makeEnemies();//we'll just make some enemies
			if(enemiesLeft==0){//if there are no more enemies left
				currentLvl ++;//continue to the next level
				currentEnemy = 0;//reset the amount of enemies there are
				startGame();//restart the game
			}
			//Updating the text fields
			txtLevel.text = 'Level '+currentLvl;
			txtMoney.text = '$'+money;
			txtLives.text = 'Lives: '+lives;
			txtEnemiesLeft.text = 'Enemies Left:  '+enemiesLeft;
		}
		
		private function makeEnemies():void{//this function will add enemies to the field
			if(enemyTime < enemyLimit){//if it isn't time to make them yet
				enemyTime ++;//then keep on waiting
			} else {//otherwise
				var theCode:int = enemyArray[currentLvl-1][currentEnemy];//get the code from the array
				if(theCode != 0){//if it isn't an empty space
					var newEnemy:Enemy = new Enemy(this, theCode);//then create a new enemy and pass in the code
					enemyHolder.addChild(newEnemy);//and add it to the enemyholder
				}
				currentEnemy ++;//move on to the next enemy
				enemyTime = 0;//and reset the time
			}
		}
	}
}
