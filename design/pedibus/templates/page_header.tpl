<section id="header" class="navbar-fixed-top container-fluid">
    <div class="top-nav row row-eq-height hidden-xs main_cage">
        <div class="col-xs-3">
            <a href="/"><img class="main_logo" src="{'logo.png'|ezimage(no)}" alt="Pedibus" title="Pedibus" /></a>
        </div>
        <div class="col-xs-9 text-right">
            <div class="search">
                <form id="search_form" action="{"/content/search"|ezurl(no)}" class="form-horizontal" role="search">
                    <div class="input-group">
                        {if is_area_tematica()}
                            <input type="hidden" value="{is_area_tematica().node_id}" name="SubTreeArray[]"/>
                            <input type="text" id="cerca" class="Form-input Grid-cell u-sizeFill u-text-r-s u-color-black u-text-r-xs"
                                    required name="SearchText" {if $pagedata.is_edit}disabled="disabled"{/if}>
                            <label class="Form-label u-color-grey-50 u-text-r-xxs" for="cerca">Cerca
                            in {is_area_tematica().name|wash()}</label>
                        {else}
                            <label for="srch">Cerca: </label>
                            <input type="text" class="form-control" placeholder="" required name="SearchText" {if $pagedata.is_edit}disabled="disabled"{/if}>
                        {/if}
                        <div class="input-group-btn">
                            <button class="btn" type="submit" value="cerca" name="SearchButton" {if $pagedata.is_edit}disabled="disabled"{/if} title="Avvia la ricerca" aria-label="Avvia la ricerca"><i class="fa fa-search"></i></button>
                        </div>
                    </div>
                    {if eq( $ui_context, 'browse' )}
                    <input name="Mode" type="hidden" value="browse"/>
                    {/if}
                </form>
            </div>

            {def $area_tematica_links = array()}
            {if is_area_tematica()}
            {set $area_tematica_links = fetch( 'content', 'related_objects', hash( 'object_id', is_area_tematica().contentobject_id, 'attribute_identifier', 'area_tematica/link' ))}
            {/if}
            <div class="contain_icons">
{*                <a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a>
                <a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a>
                <a href="#"><i class="fa fa-linkedin" aria-hidden="true"></i></a>
                <a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a>*}
            {if or(is_set($pagedata.contacts.facebook), is_set($pagedata.contacts.twitter), is_set($pagedata.contacts.linkedin), is_set($pagedata.contacts.instagram))}
                <ul class="Header-socialIcons">
                {if is_set($pagedata.contacts.facebook)}
                    <li>
                    <a href="{$pagedata.contacts.facebook}">
                                    <span class="openpa-icon fa-stack">
                                        <i class="fa fa-circle fa-stack-2x u-color-90"></i>
                                        <i class="fa fa-facebook fa-stack-1x u-color-white" aria-hidden="true"></i>
                                    </span>
                        <span class="u-hiddenVisually">Facebook</span>
                    </a>
                    </li>
                {/if}
                {if is_set($pagedata.contacts.twitter)}
                    <li>
                    <a href="{$pagedata.contacts.twitter}">
                                    <span class="openpa-icon fa-stack">
                                        <i class="fa fa-circle fa-stack-2x u-color-90"></i>
                                        <i class="fa fa-twitter fa-stack-1x u-color-white" aria-hidden="true"></i>
                                    </span>
                        <span class="u-hiddenVisually">Twitter</span>
                    </a>
                    </li>
                {/if}
                {if is_set($pagedata.contacts.linkedin)}
                    <li>
                    <a href="{$pagedata.contacts.linkedin}">
                                    <span class="openpa-icon fa-stack">
                                        <i class="fa fa-circle fa-stack-2x u-color-90"></i>
                                        <i class="fa fa-linkedin fa-stack-1x u-color-white" aria-hidden="true"></i>
                                    </span>
                        <span class="u-hiddenVisually">Linkedin</span>
                    </a>
                    </li>
                {/if}
                {if is_set($pagedata.contacts.instagram)}
                    <li>
                    <a href="{$pagedata.contacts.instagram}">
                                    <span class="openpa-icon fa-stack">
                                        <i class="fa fa-circle fa-stack-2x u-color-90"></i>
                                        <i class="fa fa-instagram fa-stack-1x u-color-white" aria-hidden="true"></i>
                                    </span>
                        <span class="u-hiddenVisually">Instagram</span>
                    </a>
                    </li>
                {/if}

                {def $forms = fetch( 'content', 'class', hash( 'class_id', 'feedback_form' ) )
                        $form = $forms.object_list[0]}
                {if $form}
                    <li>
                    <a href="{$form.main_node.url_alias|ezurl(no)}">
                                    <span class="openpa-icon fa-stack">
                                        <i class="fa fa-circle fa-stack-2x u-color-90"></i>
                                        <i class="fa fa-envelope fa-stack-1x u-color-white" aria-hidden="true"></i>
                                    </span>
                        <span class="u-hiddenVisually">Richiedi informaizini</span>
                    </a>
                    </li>
                {/if}
                {undef $forms $form}
                </ul>
            {/if}

            </div>
        </div>
    </div>
    {include uri='design:menu/header_menu.tpl'}
</section>