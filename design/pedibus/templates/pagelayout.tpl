{set-block scope=root variable=cache_ttl}0{/set-block}
<!DOCTYPE html>
<!--[if lt IE 9 ]>
<html xmlns="http://www.w3.org/1999/xhtml" class="unsupported-ie ie no-js"
      lang="{$site.http_equiv.Content-language|wash}"><![endif]-->
<!--[if IE 9 ]>
<html xmlns="http://www.w3.org/1999/xhtml" class="ie ie9 no-js"
      lang="{$site.http_equiv.Content-language|wash}"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html xmlns="http://www.w3.org/1999/xhtml"  class="no-js" lang="{$site.http_equiv.Content-language|wash}">
<!--<![endif]-->
<head>

    {def $user_hash_cache_key = concat( $current_user.role_id_list|implode( ',' ), ',', $current_user.limited_assignment_value_list|implode( ',' ) )}

    {if is_set( $extra_cache_key )|not}
        {def $extra_cache_key = ''}
    {/if}

{*    {def $current_user = fetch( 'user', 'current_user' )}*}

{cache-block keys=array( $module_result.uri, $user_hash_cache_key, $access_type.name, $extra_cache_key )}
    {def $pagedata = openpapagedata()
         $locales = fetch( 'content', 'translation_list' )
         $current_node_id = $pagedata.node_id
         $theme = openpaini('GeneralSettings','theme', 'pac')
         $main_content_class = ''
         $class_body = ''}

    {if is_set($pagedata.persistent_variable.has_container)|not()}
        {if $pagedata.is_homepage}
            {set $main_content_class = 'u-layout-wide u-layoutCenter'}
        {else}
            {set $main_content_class = 'u-layout-wide u-layoutCenter'}
        {/if}
    {/if}


    {include uri='design:page_head.tpl'}
    {include uri='design:page_head_style.tpl'}
    {include uri='design:page_head_script.tpl'}
{* ILPEDIBUS *}
    {include uri='design:pedibus_page_head.tpl'}
    {include uri='design:page_head_google_tag_manager.tpl'}

</head>
{************ ILPEDIBUS ************}
{def $__HOMEPAGE_CLASS = ""}
{if $pagedata.is_homepage}
    {set $__HOMEPAGE_CLASS = "home"}
{/if}
{************ /ILPEDIBUS ***********}
<body class="{$theme} {$class_body} {$__HOMEPAGE_CLASS}{if $current_user.is_logged_in|not()} logged{/if}">
{include uri='design:page_body_google_tag_manager.tpl'}
{*<p>
    HOEMPAGE == {$pagedata.is_homepage}
</p>*}
    <ul class="Skiplinks js-fr-bypasslinks u-hiddenPrint">
      <li><a href="#main">Vai al Contenuto</a></li>
      <li><a class="js-fr-offcanvas-open" href="#menu" aria-controls="menu" aria-label="accedi al menu" title="accedi al menu">Vai alla navigazione del sito</a></li>
    </ul>

    {include uri='design:page_browser_alert.tpl'}

    {if and( $pagedata.website_toolbar, array( 'edit', 'browse' )|contains( $ui_context )|not() )}
        {include uri='design:page_toolbar.tpl'}
    {/if}


<section id="header" class="navbar-fixed-top container-fluid">
    <div class="top-nav row row-eq-height hidden-xs main_cage">
        <div class="col-xs-3">
            <a href="{'/'|ezurl(no)}"><img class="main_logo" src="{'logo.png'|ezimage(no)}" alt="Pedibus" title="Pedibus" /></a>
        </div>
        <div class="col-xs-9 text-right">
            <div class="search">
                <form id="search_form" action="{"/content/search"|ezurl(no)}" class="form-horizontal" role="search">
                    <div class="input-group">

                            <label for="srch">Cerca: </label>
                            <input type="text" class="form-control" placeholder="" required name="SearchText" {if $pagedata.is_edit}disabled="disabled"{/if}>
                        <div class="input-group-btn">
                            <button class="btn" type="submit" value="cerca" name="SearchButton" {if $pagedata.is_edit}disabled="disabled"{/if} title="Avvia la ricerca" aria-label="Avvia la ricerca"><i class="fa fa-search"></i></button>
                        </div>
                    </div>
                    {if eq( $ui_context, 'browse' )}
                    <input name="Mode" type="hidden" value="browse"/>
                    {/if}
                </form>
            </div>

            <div class="contain_icons">
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

                </ul>
            {/if}

            </div>
        </div>
    </div>

{if and( $pagedata.is_login_page|not(), array( 'edit', 'browse' )|contains( $ui_context )|not(), openpaini( 'TopMenu', 'ShowMegaMenu', 'enabled' )|eq('enabled') )}

{def $top_menu_node_ids = openpaini( 'TopMenu', 'NodiCustomMenu', array() )}
{def $top_menu_node_ids_count = $top_menu_node_ids|count()}

{def $main_styles = openpaini( 'Stili', 'Nodo_NomeStile', array() )}
{def $item_class = "no-main-style"}

{if $top_menu_node_ids_count}
    <nav class="row" id="navigator">
        <div id="block-nav" class="container row-eq-height">
            <div class="navbar-header visible-xs-block no_pad">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                    <span class="sr-only">Espandi menu</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-header" href="#"><img class="img-responsive main_logo" src="{'logo.png'|ezimage(no)}" alt="Pedibus" title="Pedibus" /></a>
            </div>
            <div id="navbar" class="navbar-collapse collapse" aria-expanded="false" style="height: 1px;">
                <ul class="nav navbar-nav navbar-left">
                    <li><a href="{'/'|ezurl(no)}">Home</a></li>
                {foreach $top_menu_node_ids as $id}
                    {def $tree_menu = tree_menu( hash( 'root_node_id', $id, 'scope', 'top_menu'))}
                    <li>
                        <a {if $tree_menu.item.node_id|eq($current_node_id)} class="selected"{/if} href="{$tree_menu.item.url|ezurl('no')}">{$tree_menu.item.name|wash()}</a>
                    </li>
                    {undef $tree_menu}
                {/foreach}
            {/if}
                </ul>
            </div>{*<!--/.nav-collapse -->*}
        </div>{*<!--/.container-fluid -->*}
    </nav>
{/if}

</section>

        {if and(is_set($pagedata.persistent_variable.has_sidemenu), $pagedata.persistent_variable.has_sidemenu)}
            <p class="u-md-hidden u-lg-hidden u-padding-r-all u-text-m u-background-grey-20">
                <span class="Icon-list u-text-r-xl u-alignMiddle u-padding-r-right" aria-hidden="true"></span>
                <a accesskey="3"  class="js-scrollTo u-text-r-s u-textClean u-color-grey-50 u-alignMiddle" href="#subnav" >Vai menu di sezione</a>
            </p>
        {/if}

        {if $pagedata.is_homepage}
            <header id="strip_header" class="strip clearfix">
                <div class="container-fluid">
                    <div class="row">
                        <div id="slideHeader" class="carousel slide fade-carousel carousel-fade" data-ride="carousel">
                            <div class="carousel-inner">
                                <div class="item next left">
                                    <img src="{'ph_header.jpg'|ezimage(no)}" style="width:100%" data-src="" alt="slide">
                                </div>
                                <div class="item active left">
                                    <img src="{'ph_header.jpg'|ezimage(no)}" style="width:100%" data-src="" alt="slide">
                                </div>

                                <div class="container-fluid">
                                    <div class="header-caption">
                                        <p>a scuola a piedi tutti insieme :)</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /carousel -->
                    </div>

                </div>
            </header>
        {/if}
        <section id="strip_intro" class="strip">

            {if and( $pagedata.is_homepage|not(), $pagedata.is_search_page|not(), $pagedata.show_path, array( 'edit', 'browse' )|contains( $ui_context )|not(), is_set( $module_result.content_info ) )}
                {include uri='design:breadcrumb.tpl'}
            {/if}

            {if is_set($pagedata.persistent_variable.has_container)|not()}
                <div class="u-text-r-xl u-layout-r-withGutter u-padding-r-top">
            {/if}

{/cache-block}

                {include uri='design:page_mainarea.tpl'}
{cache-block keys=array( $module_result.uri, $user_hash_cache_key, $access_type.name, $extra_cache_key )}

            {if is_set($pagedata.persistent_variable.has_container)|not()}
                </div>
            {/if}
        </section>

            {if is_unset($pagedata)}{def $pagedata = openpapagedata()}{/if}
            {if and( $pagedata.is_login_page|not(), $pagedata.show_path, array( 'edit', 'browse' )|contains( $ui_context )|not() )}
                {include uri='design:page_footer.tpl' current_user=$current_user}
            {/if}

{/cache-block}



{*    </div>*}

    {* Codice extra usato da plugin javascript *}
    {include uri='design:page_extra.tpl'}

    <!--DEBUG_REPORT-->
    {include uri='design:page_footer_script.tpl'}

</body>
</html>
