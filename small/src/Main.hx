// Copyright 2014 The Beluga Project Developers. See the LICENCE.md
// file at the top-level directory of this distribution and at
// http://haxebeluga.github.io/licence.html.
//
// Licensed under the MIT License.
// This file may not be copied, modified, or distributed
// except according to those terms.

package ;

import beluga.Beluga;
import php.Web;
import beluga.module.account.Account;
import beluga.module.account.model.User;

class Main {
    public static var beluga : Beluga;

    static function main() {
        var beluga = Beluga.getInstance();
        var account = beluga.getModuleInstance(Account);
        account.triggers.subscribeSuccess.add(function (args: { user : User } ) {
            Sys.print(" Subscribe Success");
        });
        beluga.handleRequest();
        Sys.print(account.widgets.subscribeForm.render());
        Sys.print(account.widgets.loginForm.render());
        beluga.cleanup();
    }
}