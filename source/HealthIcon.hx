package;

import flixel.FlxSprite;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;
	public var isPlayer:Bool = false;
	public var curCharacter:String = '';

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();

		this.isPlayer = isPlayer;
		swapCharacter(char);
	}

	public function swapCharacter(char:String)
	{
		curCharacter = char;
		// i hate this code and i hate how the characters are named since this makes it twenty times harder than it should
		switch(char)
		{
			case 'bf' | 'bf-casual' | 'bf-car':
				loadGraphic(Paths.image('icons/icon-bf'), true, 150, 150);
			case 'bf-teasar': 
				loadGraphic(Paths.image('icons/icon-teasar'), true, 150, 150);
			case 'bf-carnight' | 'bfdemoncesar' | 'bf-casualdemon':
				loadGraphic(Paths.image('icons/icon-bfdemoncesar'), true, 150, 150);
			case 'gf' | 'gf-painting' | 'gf-christmas' | 'tea-pixel':
				loadGraphic(Paths.image('icons/icon-gf'), true, 150, 150);
			case 'dad': 
				loadGraphic(Paths.image('icons/icon-peakek'), true, 150, 150);
			case 'peasus' | 'peacensored':
				loadGraphic(Paths.image('icons/icon-peasus'), true, 150, 150);
			case 'senpai' | 'senpai-angry':
				loadGraphic(Paths.image('icons/icon-senpai'), true, 150, 150);
			case 'mom' | 'mom-car' | 'mom-carnight':
				loadGraphic(Paths.image('icons/icon-mom'), true, 150, 150);
			case 'bfiso' | 'bfiso-pixel':
				loadGraphic(Paths.image('icons/icon-iso'), true, 150, 150);
			case 'taki' | 'monster':
				loadGraphic(Paths.image('icons/icon-monster'), true, 150, 150);
			default: 
				loadGraphic(Paths.image('icons/icon-$char'), true, 150, 150);
		}

		var pixel:Array<String> = ['flippy', 'senpai', 'bdbfever'];
		antialiasing = StringTools.contains(char, 'pixel') || pixel.contains(char) ? false : true;
		animation.add('healthy', [0], 0, false, isPlayer);
		animation.add('hurt', [1], 0, false, isPlayer);
		animation.add('winning', [2], 0, false, isPlayer);
			
		animation.play('healthy');

		switch(char)
		{
			case 'bf-pixel' | 'senpai' | 'senpai-angry' | 'flippy' | 'tea-pixel':
				antialiasing = false;
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
