{def $is_only_logo = cond(and( $pagedata.homepage|has_attribute('only_logo'), $pagedata.homepage|attribute('only_logo').data_int|eq(1) ), true(), false())
     $logo_url = cond(and( is_set($pagedata.header.logo.url), $pagedata.header.logo.url), $pagedata.header.logo.url, false())
     $site_name = cond( $pagedata.homepage|has_attribute('site_name'), $pagedata.homepage|attribute('site_name').content|wash(), ezini('SiteSettings','SiteName'))
     $site_url = "/"|ezurl(no)
     $site_slug = false()
     $is_area_tematica = is_area_tematica()}

{if and($is_area_tematica, $is_area_tematica|has_attribute('logo'))}
    {set $is_only_logo = cond(and( $is_area_tematica|has_attribute('only_logo'), $is_area_tematica|attribute('only_logo').data_int|eq(1) ), true(), false())
         $logo_url = $is_area_tematica|attribute('logo').content.header_logo.url
         $site_name = $is_area_tematica.name|wash()
         $site_url = $is_area_tematica.url_alias|ezurl(no)}
{/if}
<div class="Header-logo Grid-cell" aria-hidden="true">
    {if $is_only_logo}
        <h1 alt="{$site_name}">
    {/if}
    <a href="{$site_url}" tabindex="-1">
        {if $logo_url}
            <img src="{$logo_url|ezroot(no)}" alt="{$site_name}" {if $is_only_logo}style="width: auto;"{/if}/>
        {/if}
    </a>
    {if $is_only_logo}
        </h1>
    {/if}
</div>

{if $is_only_logo}
    <div class="Header-title Grid-cell"></div>
{else}
    <div class="Header-title Grid-cell">
        <h1 class="Header-titleLink">
            <a accesskey="1" href="{$site_url}">
                {$site_name}
                {if $site_slug}
                <br><small>{$site_slug}</small>
                {/if}
            </a>
        </h1>
    </div>
{/if}
{undef $is_only_logo $logo_url $site_name $site_url $site_slug $is_area_tematica}
