package beluga.core.widget;

import haxe.Template;
import haxe.Resource;

/**
 * ...
 * @author brissa_A
 */
class MttWidget implements Widget
{
	private var template : Template;

	private function new(mttfile : String) 
	{
		var templateFileContent = Resource.getString(mttfile);
		template = new haxe.Template(templateFileContent);
	}
	
	public function render() : String {
        return template.execute({});
	}
}