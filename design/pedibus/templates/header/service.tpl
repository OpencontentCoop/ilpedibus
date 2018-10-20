{def $header_service = openpaini('GeneralSettings','header_service', 1)
	 $header_service_list = array()
	 $is_area_tematica = is_area_tematica()}
{if $header_service|eq(1)}
	{set $header_service_list = $header_service_list|append(hash(
		'url', openpaini('InstanceSettings','UrlAmministrazioneAfferente', '#'),
		'name', openpaini('InstanceSettings','NomeAmministrazioneAfferente', 'Provincia autonoma di Trento')
	))}    
{/if}
{if and($is_area_tematica, $is_area_tematica|has_attribute('logo'))}
	{set $header_service_list = $header_service_list|append(hash(
		'url', "/"|ezurl(no),
		'name', cond( $pagedata.homepage|has_attribute('site_name'), $pagedata.homepage|attribute('site_name').content|wash(), ezini('SiteSettings','SiteName'))
	))}    
{/if}

{if $header_service_list|count()|gt(0)}
<div class="Header-banner">
        <div class="Header-owner Headroom-hideme">
            {foreach $header_service_list as $item}
	            <div class="Breadcrumb-item">
		            <a class="Breadcrumb-link u-color-white" href="{$item.url}">
		                <span>{$item.name|wash()}</span>
		            </a>	
	            </div>
            {/foreach}

            {include uri='design:header/languages.tpl'}

        </div>
    </div>
{/if}

{undef $header_service $header_service_list $is_area_tematica}