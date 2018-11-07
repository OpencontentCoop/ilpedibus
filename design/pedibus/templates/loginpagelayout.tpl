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

    {cache-block keys=array( $module_result.uri, $user_hash_cache_key, $access_type.name, $extra_cache_key )}
    {def $pagedata = openpapagedata()
    $locales = fetch( 'content', 'translation_list' )
    $current_node_id = $pagedata.node_id}

    {include uri='design:page_head.tpl'}
    {include uri='design:page_head_style.tpl'}
    {include uri='design:page_head_script.tpl'}

</head>
<body class="Pac">

{include uri='design:page_browser_alert.tpl'}

{if and( $pagedata.website_toolbar, array( 'edit', 'browse' )|contains( $ui_context )|not() )}
    {include uri='design:page_toolbar.tpl'}
{/if}

{include uri='design:page_header.tpl'}


<div id="main">
    <section>

        {/cache-block}

        <div class="u-layout-wide u-layoutCenter u-layout-withGutter u-padding-r-top">
            {include uri='design:page_mainarea.tpl'}
        </div>

    </section>

</div>

<!--DEBUG_REPORT-->
{include uri='design:page_footer_script.tpl'}

</body>
</html>
