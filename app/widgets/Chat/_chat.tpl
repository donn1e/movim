<header class="fixed" id="{$jid|cleanupId}-header">
    {autoescape="off"}
        {$c->prepareHeader($jid, $muc)}
    {/autoescape}
</header>

<div id="{$jid|cleanupId}-discussion" class="contained {if="$muc"}muc{/if}" data-muc="{$muc}">
    <a id="scroll_down" class="button action color small semi" onclick="Chat.scrollTotally()">
        <i class="material-icons">expand_more</i>
    </a>
    <section id="{$jid|cleanupId}-messages">
        <ul class="list spin conversation" id="{$jid|cleanupId}-conversation"></ul>
        <div class="placeholder">
            <i class="material-icons">chat</i>
            <h1>{$c->__('chat.new_title')}</h1>
            <h4>{$c->___('chat.new_text')}</h4>
            <h4>{$c->___('message.edit_help')}</h4>
            <h4>{$c->___('message.emoji_help')}</h4>
        </div>
    </section>
</div>
<div class="chat_box">
    <ul class="list thin fill">
        <div id="reply"></div>
        <li class="emojis"></li>
        <li>
            <span class="primary icon gray primary_action"
                  title="{$c->__('sticker.title')}"
                  onclick="Stickers_ajaxShow('{$jid}')">
                <i class="material-icons flip-vert">note</i>
            </span>
            <span class="emojis control icon gray primary_action"
                    title="{$c->__('sticker.title')}"
                    onclick="Stickers_ajaxReaction()">
                <i class="material-icons">face</i>
            </span>
            {if="$c->getUser()->hasUpload()"}
                <span class="attach control icon" onclick="Chat.toggleAttach()">
                    <i class="material-icons">add_circle</i>
                </span>
                <ul class="list middle actions">
                    <li onclick="Chat.toggleAttach(); Snap.init()">
                        <span class="control icon bubble color blue">
                            <i class="material-icons">camera_alt</i>
                        </span>
                        <div>
                            <p class="normal line">Snap</p>
                        </div>
                    </li>
                    <li onclick="Chat.toggleAttach(); Draw.init()">
                        <span class="control icon middle bubble color green">
                            <i class="material-icons">gesture</i>
                        </span>
                        <div>
                            <p class="normal line">{$c->__('draw.title')}</p>
                        </div>
                    </li>
                    <li onclick="Chat.toggleAttach(); Upload_ajaxRequest()">
                        <span class="control icon bubble color purple">
                            <i class="material-icons">attach_file</i>
                        </span>
                        <div>
                            <p class="normal line">{$c->__('upload.title')}</p>
                        </div>
                    </li>
                </ul>
            {/if}
            <span title="{$c->__('button.submit')}"
                class="send control icon gray"
                  onclick="Chat.sendMessage()">
                <i class="material-icons">send</i>
            </span>
            <form>
                <div>
                     <textarea
                        dir="auto"
                        rows="1"
                        id="chat_textarea"
                        data-jid="{$jid}"
                        data-muc="{if="$muc"}true{/if}"
                        {$rand = rand(0, 4)}
                        {if="$rand == 4 && !$muc"}
                            placeholder="{$c->__('message.edit_help')}"
                        {elseif="$rand == 3"}
                            placeholder="{$c->__('message.emoji_help')}"
                        {else}
                            placeholder="{$c->__('chat.placeholder')}"
                        {/if}
                    ></textarea>
                </div>
            </form>
        </li>
    </ul>
</div>