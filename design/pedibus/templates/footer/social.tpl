{if is_set($pagedata.contacts.facebook)}
    <a href="{$pagedata.contacts.facebook}">
        <i class="fa fa-facebook" aria-hidden="true"></i>
    </a>
{/if}
{if is_set($pagedata.contacts.twitter)}
    <a href="{$pagedata.contacts.twitter}">
        <i class="fa fa-twitter" aria-hidden="true"></i>
    </a>
{/if}
{if is_set($pagedata.contacts.linkedin)}
    <a href="{$pagedata.contacts.linkedin}">
        <i class="fa fa-linkedin" aria-hidden="true"></i>
    </a>
{/if}
{if is_set($pagedata.contacts.instagram)}
    <a href="{$pagedata.contacts.instagram}">
        <i class="fa fa-instagram" aria-hidden="true"></i>
    </a>
{/if}

{def $forms = fetch( 'content', 'class', hash( 'class_id', 'feedback_form' ) )
$form = $forms.object_list[0]}
{if $form}
    <a href="{$form.main_node.url_alias|ezurl(no)}">
                                <span class="openpa-icon fa-stack">
                                    <i class="fa fa-circle fa-stack-2x"></i>
                                    <i class="fa fa-envelope fa-stack-1x u-color-grey-80"
                                        aria-hidden="true"></i>
                                </span>
        <span class="u-hiddenVisually">Richiedi informazioni</span>
    </a>
{/if}
{undef $forms $form}