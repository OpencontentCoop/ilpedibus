{def $is_area_tematica = is_area_tematica()}
{def $footerBlocks = 4
     $has_notes = false()
     $has_contacts = false()
     $has_links  = false()
     $has_social  = false()
     $footerBlocksClass = 'u-sizeFull'}

{if and($is_area_tematica, $is_area_tematica|has_attribute('link'))}
    {def $footer_links = array()}
    {foreach $is_area_tematica|attribute('link').content.relation_list as $item}
        {set $footer_links = $footer_links|append(fetch(content, node, hash(node_id, $item.node_id)))}
    {/foreach}
{else}
    {def $footer_links = fetch( 'openpa', 'footer_links' )}
{/if}

{if and($is_area_tematica, $is_area_tematica|has_attribute('note_footer'))}
    {def $footer_notes = $is_area_tematica|attribute('note_footer')}
{else}
    {def $footer_notes = fetch( 'openpa', 'footer_notes' )}
{/if}

{if count( $footer_notes )|gt(0)}
    {set $has_notes = true()}
{else}
    {set $footerBlocks = $footerBlocks|sub(1)}
{/if}

{if and($is_area_tematica, $is_area_tematica|has_attribute('contacts'))}
    {def $contacts = parse_contacts_matrix($is_area_tematica)}
{else}
    {def $contacts = $pagedata.contacts}
{/if}

{if or(is_set($contacts.indirizzo), is_set($contacts.telefono), is_set($contacts.fax),
       is_set($contacts.email), is_set($contacts.pec), is_set($contacts.web))}
    {set $has_contacts = true()}
{else}
    {set $footerBlocks = $footerBlocks|sub(1)}
{/if}

{if or(is_set($contacts.facebook), is_set($contacts.twitter), is_set($contacts.linkedin), is_set($contacts.instagram))}
    {set $has_social = true()}
{else}
    {set $footerBlocks = $footerBlocks|sub(1)}
{/if}

{if count( $footer_links )|gt(0)}
    {set $has_links = true()}
{else}
    {set $footerBlocks = $footerBlocks|sub(1)}
{/if}

{if $footerBlocks|gt(1)}
    {set $footerBlocksClass = concat('u-md-size1of', $footerBlocks, ' u-lg-size1of', $footerBlocks) }
{/if}

{def $__LINEE = fetch('content','node',hash('node_id', ezini( 'IlPedibus', 'Linee', 'ilpedibus.ini' )))}
{def $__MODULI = fetch('content','node',hash('node_id', ezini( 'IlPedibus', 'Modulistica', 'ilpedibus.ini' )))}

<div class="row_subscribe">
    <div class="container-fluid main_cage">
        <div class="row row-eq-height">
            <div class="col-sm-9">
                <p class="section_title">VUOI DIVENTARE VOLONTARIO?</p>
                <p class="white-space">
                    Siamo sempre alla ricerca di volontari! Effettua l’iscrizione per entrare a far parte del nostro team ;)
                </p>
            </div>
            <div class="col-sm-3 text-center">
                <a href="{$__MODULI.url|ezroot('no')}" class="btn btn_subscribe">Iscriviti subito</a>
            </div>
        </div>
    </div>
</div>

{cache-block keys="footer_map"}
    <div class=" row_map">
        <div class="container-fluid main_cage margin-top">
            <div class="row">
                <p class="section_title text-center">gli itinerari</p>

                <a href="{$__LINEE.url|ezroot('no')}">
                    <img src="{'maps.jpg'|ezimage(no)}" style="width:100%" data-src="" alt="mappa linee pedibus" title="mappa linee pedibus">
                </a>
{*<!--
                {def $__HOME_NODE = fetch('content','node',hash('node_id',2))}

                {attribute_view_gui attribute=$__HOME_NODE.data_map.page}
-->*}
            </div>
        </div>
    </div>
{/cache-block}

{if openpaini('GeneralSettings','valutation', 1)}
    {if and( $ui_context|ne( 'edit' ), $ui_context|ne( 'browse' ) )}
        {if $pagedata.class_identifier|ne('')}
           {literal}<script>$(document).on('click', '#toggle-validation', function(e){$('#openpa-valuation').toggle();e.preventDefault();});</script>{/literal}
            {* ILPEDIBUS  *}
            <div class="row_rating_site">
                <div class="container-fluid main_cage">
                    <div id="toggle-validation" class="row">
                        <p class="text-center">Valuta questo sito</p>
                    </div>
                </div>
            </div>
            {* /ILPEDIBUS  *}
            <div style="display: none" id="openpa-valuation">
                {include name=valuation node_id=$current_node_id uri='design:openpa/valuation.tpl'}
            </div>
        {/if}
    {/if}
{/if}


{if and( $pagedata.homepage|has_attribute('partners'), $pagedata.homepage|attribute('partners').has_content) }
    {include uri='design:footer/partners.tpl'}
{/if}

<div id="strip_footer" class="strip">
    <footer id="footer" class="container-fluid main_cage">
        <div class="row">
            <div class="col-xs-12 logo_footer">
                <a href="/"><img class="main_logo" src="{'logo_white.png'|ezimage(no)}" alt="Pedibus" title="Pedibus" /></a>
            </div>

            {if $has_notes}
                <div class="col-sm-6 col-md-3 info_col">
                    <p class="info_title">Informazioni</p>
                    <p class="white-space">
                        {attribute_view_gui attribute=$footer_notes}
                    </p>
                </div>
            {/if}

            {if $has_contacts}
                <div class="col-sm-6 col-md-3 info_col">
                    <p class="info_title">Contatti</p>
                    <p class="white-space">
                        {include uri='design:footer/contacts_list.tpl' contacts=$contacts}
                    </p>
                </div>
            {/if}

            {if $has_links}
                <div class="col-sm-6 col-md-3 info_col">
                    <p class="info_title">Link</p>
                    <p>
                        {foreach $footer_links as $item}
                            {def $href = $item.url_alias|ezurl(no)}
                            {if eq( $ui_context, 'browse' )}
                                {set $href = concat("content/browse/", $item.node_id)|ezurl(no)}
                            {elseif $pagedata.is_edit}
                                {set $href = '#'}
                            {elseif and( is_set( $item.data_map.location ), $item.data_map.location.has_content )}
                                {set $href = $item.data_map.location.content}
                            {/if}
                                <a href="{$href}" title="Leggi {$item.name|wash()}">{$item.name|wash()}</a>
                            {undef $href}
                        {/foreach}
                    </p>
                </div>
            {/if}


                <div class="col-sm-6 col-md-3 info_col">
                    <p class="info_title">Seguici su</p>
                    {if $has_social}
                    <div class="info_icons">
                        {include uri='design:footer/social.tpl'}
                    </div>
                     {/if}


                    {def $__AREA_RISERVATA = fetch('content','node',hash('node_id', ezini( 'IlPedibus', 'AreaRiservata', 'ilpedibus.ini' )))}
                    {if $current_user.is_logged_in|not()}
                        <p class="info_title">Area Riservata</p>
                        <p class="reserved-area">
                            <a href="{$__AREA_RISERVATA.url|ezroot('no')}" class="button" target="_blank">
                                <i class="fa fa-lock"></i><span class="title">Accedi</span><br>all'area riservata
                            </a>
                        </p>
                    {else}
                        <a class="info_title" href="\{$__AREA_RISERVATA.url}">Area Riservata</a>
                        <p>
                            Benvenuto <strong>{$current_user.contentobject.name|wash()}</strong>
                        </p>
                        <p>
                            <a href="{'user/logout'|ezroot('no')}">clicca qui per uscire</a>
                        </p>
                    {/if}
                </div>



            <div class="col-xs-12 close_row">
                <p>© 2018 OpenVolontario powered by ComunWEB con il supporto di OpenContent Scarl e Interline srl</p>
            </div>
        </div>
    </footer>
</div>


<a href="#" title="torna all'inizio del contenuto" class="ScrollTop js-scrollTop js-scrollTo">
    <i class="ScrollTop-icon Icon-collapse" aria-hidden="true"></i>
    <span class="u-hiddenVisually">torna all'inizio del contenuto</span>
</a>

{undef}