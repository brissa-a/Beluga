package beluga.module.faq.widget;

import beluga.Beluga;
import beluga.widget.MttWidget;
import beluga.ConfigLoader;
import beluga.module.faq.Faq;
import beluga.I18n;
import beluga.resource.ResourceManager;

class Create extends MttWidget<Faq> {

    public function new (?mttfile : String) {
        if(mttfile == null) mttfile = ResourceManager.getString("/beluga/module/faq/view/tpl/create_faq.mtt");
        super(Faq, mttfile);
        i18n = BelugaI18n.loadI18nFolder("/beluga/module/faq/view/locale/create/", mod.i18n);
    }

    override private function getContext() : Dynamic {
        return {
            path : "/beluga/faq/",
            error : (mod.error_msg != "" ? BelugaI18n.getKey(this.i18n, mod.error_msg) : mod.error_msg),
            success : (mod.success_msg != "" ? BelugaI18n.getKey(this.i18n, mod.success_msg) : mod.success_msg),
            parent: switch (mod.category_id) { case Some(id) : id; case None : -1;},
            question : mod.question, answer: mod.answer,
            base_url : ConfigLoader.getBaseUrl()
        };
    }
}