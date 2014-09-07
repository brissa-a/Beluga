package modules.account_test;

import beluga.core.Beluga;
import beluga.core.Widget;
import beluga.core.macro.MetadataReader;
import beluga.module.account.model.User;
import beluga.module.account.ESubscribeFailCause;
import beluga.module.account.Account;
import beluga.module.account.widget.SubscribeForm;
import beluga.module.account.widget.LoginForm;
import haxe.Resource;
import main_view.Renderer;

#if php
import php.Web;
#end

/**
 * Beluga #1
 * @author Masadow
 */

class AccountTest {

    public var beluga(default, null) : Beluga;
    public var acc(default, null) : Account;

    public function new(beluga : Beluga) {
        this.beluga = beluga;
        this.acc = beluga.getModuleInstance(Account);
		
		//Binding login
        acc.triggers.loginSuccess.add(displayLogin);
        acc.triggers.loginWrongPassword.add(displayLogin);
        acc.triggers.loginWrongLogin.add(displayLogin);
        acc.triggers.loginInternalError.add(displayLogin);
        acc.triggers.loginUserBanned.add(displayLogin);

        acc.triggers.subscribeFail.add(this.subscribeFail);
        acc.triggers.subscribeSuccess.add(this.subscribeSuccess);
		
        acc.triggers.afterLogout.add(this.logout);
    }

    /*
     * Logination
     */
	public function displayLogin(unused_parameter : Dynamic ) {
		trace("Display Login");
		var html = Renderer.renderDefault("page_login", "Authentification", {
            loginWidget: acc.createWidget(LoginForm).render()
        });
		Sys.print(html);
	}

	public function loginSuccess(args: { args: {login:String, password:String}, user : User} ) {
        var html = Renderer.renderDefault("page_accueil", "Accueil", { success : "Authentification succeeded !" } );
        Sys.print(html);
    }

    public function loginFail(err : String, unused_args : Dynamic) {
        var widget = acc.getWidget("login");
        widget.context = {error : err};
		
        var loginWidget = widget.render();
        var html = Renderer.renderDefault("page_login", "Authentification", {
            loginWidget: loginWidget
        });
        Sys.print(html);
    }

    public function logout() {
        var html = Renderer.renderDefault("page_accueil", "Accueil", {success : "You're disconnected"});
        Sys.print(html);
    }

    /*
     *  Subscription
     */
    public function subscribeSuccess(args : {user : User}) {
        var html = Renderer.renderDefault("page_accueil", "Accueil", {success : "Subscribe succeeded !"});
        Sys.print(html);
    }

    public function subscribeFail(args : {err : String}) {
        var html = Renderer.renderDefault("page_subscribe", "Inscription", {
            subscribeWidget: acc.createWidget(SubscribeForm).render(),
            error : args.err 
        });
        Sys.print(html);
    }

    @bTrigger("beluga_account_show_user")
    public function _printCustomUserInfo(args: { id: Int }) {
        new AccountTest(Beluga.getInstance()).printCustomUserInfo(args);
    }

    @bTrigger("beluga_account_show_user")
    public function printCustomUserInfo(args: { id: Int }) {
        var user = Beluga.getInstance().getModuleInstance(Account).loggedUser;

        if (user == null) {
            var html = Renderer.renderDefault("page_accueil", "Accueil", {success : "", error : ""});
            Sys.print(html);
            return;
        }
        var subscribeWidget = acc.getWidget("info");
        if (!user.isAdmin)
            subscribeWidget.context = {user : user, path : "/accountTest/"};
        else {
            var users = Beluga.getInstance().getModuleInstance(Account).getUsers();
            subscribeWidget.context = {user : user, path : "/accountTest/"};
        }

        var html = Renderer.renderDefault("page_subscribe", "Information", {
            subscribeWidget: subscribeWidget.render()
        });
        Sys.print(html);
    }
}