<div id="login_widget">
    <script type="text/javascript">
        if (typeof navigator.registerProtocolHandler == 'function') {
            navigator.registerProtocolHandler('xmpp',
                                          '{$c->route("share")}/%s',
                                          'Movim');
        }

        Login.domain = '{$domain}';
        {if="isset($httpAuthUser)"}
            localStorage.username = '{$httpAuthUser}';
            MovimWebsocket.attach(function() {
                MovimWebsocket.connection.register('{$httpAuthHost}');
            });
            MovimWebsocket.register(function() {
                Login_ajaxHTTPLogin('{$httpAuthUser}', '{$httpAuthPassword}');
            });
        {/if}
    </script>

    <div class="logo"></div>

    <div id="form" class="dialog">
        {if="$banner"}
            <img class="banner" src="{$banner}">
        {/if}
        <section>
            {if="$invitation != null"}
                <br />
                <ul class="list middle invite">
                    <li>
                        {$url = $contact->getPhoto('m')}
                        {if="$url"}
                            <span class="primary icon bubble" style="background-image: url({$url});">
                            </span>
                        {else}
                            <span class="primary icon bubble color {$contact->jid|stringToColor}">
                                {$contact->truename|firstLetterCapitalize}
                            </span>
                        {/if}
                        {if="$invitation->room && $invitation->room->getPhoto('m')"}
                            <span class="primary icon bubble" style="background-image: url({$invitation->room->getPhoto('m')});">
                            </span>
                        {/if}
                        <div>
                            <p></p>
                            <p class="all">{$c->__('form.invite_chatroom', $contact->truename)}: {$invitation->resource}</p>
                        </div>
                    </li>
                </ul>
            {/if}

            <form
                method="post" action="login"
                name="login">
                <div>
                    <input type="text" id="complete" tabindex="-1"/>
                    <input type="text" pattern="^[^\u0000-\u001f\u0020\u0022\u0026\u0027\u002f\u003a\u003c\u003e\u0040\u007f\u0080-\u009f\u00a0]+@[a-z0-9.-]+\.[a-z]{2,10}$" name="username" id="username" autofocus required
                        placeholder="username@server.com"/>
                    <label for="username">{$c->__('form.username')}</label>
                </div>
                <div>
                    <input type="password" name="password" id="password" required
                        placeholder="{$c->__('form.password')}"/>
                    <label for="password">{$c->__('form.password')}</label>
                </div>

                <ul class="list thin">
                    <li class="info">
                        <div>
                            <p></p>
                            <p class="center">
                                {if="!empty($whitelist)"}
                                    {$c->__('form.whitelist_info')} :
                                    {loop="$whitelist"}
                                        {$value}
                                    {/loop}
                                {else}
                                    {$c->__('form.connect_info')}
                                {/if}
                            </p>
                        </div>
                    </li>
                </ul>

                <div>
                    <ul class="list thin">
                        <li>
                            <div>
                                <p class="center">
                                    <input
                                        type="submit"
                                        disabled
                                        data-loading="{$c->__('button.connecting')}…"
                                        value="{$c->__('page.login')}"
                                        class="button color"/>
                                    {if="!App\Configuration::get()->disableregistration"}
                                        <a class="button flat" href="{$c->route('account')}">
                                            {$c->__('button.sign_up')}
                                        </a>
                                    {/if}
                                </p>
                            </div>
                        </li>
                    </ul>
                </div>
            </form>
        </section>
    </div>

    <div id="form" class="dialog more">
        <section>
            <span class="info">{$c->__('form.connected')}: {$connected} - {$c->__('form.population')}: {$pop}</span>
            {if="$admins->count() > 0"}
                <ul class="list thin active">
                    <li class="subheader">
                        <div>
                            <p>
                                {$c->__('form.pod_admins')}
                            </p>
                        </div>
                    </li>
                    {loop="$admins"}
                        {$contact = $value->contact}
                        <li class="block" onclick="MovimUtils.redirect('{$c->route('blog', $value->resolvedNickname)}')">
                            <span class="control gray icon">
                                <i class="material-icons">chevron_right</i>
                            </span>
                            {$url = null}
                            {if="$contact"}
                                {$url = $contact->getPhoto()}
                            {/if}
                            {if="$url"}
                                <span class="primary icon bubble small">
                                    <img src="{$url}">
                                </span>
                            {else}
                                <span class="primary icon bubble small color {$value->id|stringToColor}">
                                    <i class="material-icons">person</i>
                                </span>
                            {/if}
                            <div>
                                <p class="line normal" title="{$value->resolvedNickname}">
                                    {if="$contact"}
                                        {$contact->truename}<span class="second">{$value->resolvedNickname}</span>
                                    {else}
                                        {$value->resolvedNickname}
                                    {/if}
                                </p>
                            </div>
                        </li>
                    {/loop}
                </ul>
            {/if}

            {if="isset($info)"}
                <ul class="list thin card">
                    <li class="info">
                        <div>
                            <p></p>
                            {autoescape="off"}
                                {$info}
                            {/autoescape}
                        </div>
                    </li>
                </ul>
            {/if}

            <ul class="list middle">
                <a href="https://f-droid.org/packages/com.movim.movim/" target="_blank">
                    <li class="block active">
                        <span class="primary icon bubble green">
                            <i class="material-icons">adb</i>
                        </span>
                        <div>
                            <p class="line">{$c->__('apps.phone')}<p>
                            <p class="all">
                                {$c->__('apps.android')}
                            </p>
                        </div>
                    </li>
                </a>
            </ul>
        </section>
    </div>

    <div id="error" class="dialog actions">
        {autoescape="off"}
            {$error}
        {/autoescape}
    </div>

    <footer>
        <a href="https://movim.eu" target="_blank" class="on_desktop"></a>
        <!--<a class="button flat color green" href="https://play.google.com/store/apps/details?id=com.movim.movim" target="_blank">
            <i class="material-icons">android</i> Play Store
        </a>
        <a class="button flat color purple on_desktop" href="https://movim.eu/#apps" target="_blank">
            <i class="material-icons">computer</i> Apps
        </a>-->
        <a class="button flat color transparent on_android" href="movim://changepod">
            <i class="material-icons">dns</i>
            {$c->__('global.change_pod')}
        </a>

        <br />
    </footer>
    <script type="text/javascript">
        if (typeof Android !== 'undefined') {
            MovimTpl.remove('#login_widget footer');
        }
    </script>
</div>
