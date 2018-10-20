{def $lang_selector = array()
     $avail_translation = array()}
{if and( is_set( $DesignKeys:used.url_alias ), $DesignKeys:used.url_alias|count|ge( 1 ) )}
    {set $avail_translation = language_switcher( $DesignKeys:used.url_alias )}
{else}
    {set $avail_translation = language_switcher( $site.uri.original_uri )}
{/if}


{if $avail_translation|count|gt( 1 )}

    {foreach $avail_translation as $siteaccess => $lang}
    {if is_set($lang.locale)}
      {append-block variable=$lang_selector}
        {if $siteaccess|eq( $access_type.name )}
          <a class="Header-language is-active u-hidden u-md-inlineBlock u-lg-inlineBlock" title="{$lang.text|wash|upcase}" href={$lang.url|ezurl}>
            {$lang.text|wash|upcase}
          </a>
        {else}
          <a class="Header-language u-hidden u-md-inlineBlock u-lg-inlineBlock" title="{$lang.text|wash|upcase}" href={$lang.url|ezurl} lang="{$lang.locale|extract_right(2)|downcase}">
            {$lang.text|wash|upcase}
          </a>

        {/if}
        {/append-block}
    {/if}
    {/foreach}


  <div class="Header-languages">
    {$lang_selector|implode( '' )}
  </div>

{/if}
{undef $lang_selector}
