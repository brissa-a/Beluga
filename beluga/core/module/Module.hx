package beluga.core.module;
import beluga.core.Widget;
import beluga.core.trigger.TriggerHelper;

/**
 * ...
 * @author Masadow
 */
interface Module
{
	public function getWidget(name : String) : Widget;
	public var lastDispatch : LastDispatch;
}