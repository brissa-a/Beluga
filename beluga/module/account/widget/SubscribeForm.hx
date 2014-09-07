package beluga.module.account.widget;

import beluga.core.Beluga;
import beluga.core.widget.AccountWidget;
import beluga.core.widget.MttWidget;
import beluga.core.macro.ConfigLoader;
import beluga.module.account.Account;

/**
 * ...
 * @author brissa_A
 */
 
class SubscribeForm extends AccountWidget
{
	public var context : {
		base_url : String,
		id: Int
	};
	
	public static var id(default, null) = 0;
	
	private function new (mttfile = "beluga_account_subscribe.mtt") {
		super(mttfile);
		
		var acc = Beluga.getInstance().getModuleInstance(Account);
		this.context = {
			base_url : ConfigLoader.getBaseUrl(),
			id: SubscribeForm.id++,
		};
	}

	override public function render() : String {
        return template.execute(context);
	}
	
}