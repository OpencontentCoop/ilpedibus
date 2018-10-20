<div class="container-fluid main_cage breadcrumb">
    Sei in:
    {foreach $pagedata.default_path_array as $path}
        {if $path.url}
            &nbsp;<a href={cond( is_set( $path.url_alias ), $path.url_alias, $path.url )|ezurl}>{$path.text|wash}</a>&nbsp;|
        {else}
            &nbsp;{$path.text|wash}
        {/if}
    {/foreach}
</div>