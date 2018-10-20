{if is_set($contacts.indirizzo)}
    <a href="http://maps.google.com/maps?q={$contacts.indirizzo|urlencode}">
        <i class="fa fa-map-marker fa-building u-textClean"></i>
        {$contacts.indirizzo}
    </a>
{/if}

{if is_set($contacts.telefono)}
    {def $tel = strReplace($contacts.telefono,array(" ",""))}
    <a class="u-linkClean" href="tel:{$tel}">
        <i class="fa fa-phone u-textClean"></i>
        {$contacts.telefono}
    </a>
{/if}
{if is_set($contacts.fax)}
    {def $fax = strReplace($contacts.fax,array(" ",""))}
    <a class="u-linkClean" href="tel:{$fax}">
        <i class="fa fa-fax fa-print u-textClean"></i>
        {$contacts.fax}
    </a>
{/if}
{if is_set($contacts.email)}
    <a class="u-linkClean" href="mailto:{$contacts.email}">
        <i class="fa fa-envelope-o u-textClean"></i>
        {$contacts.email}
    </a>
{/if}
{if is_set($contacts.pec)}
    <a class="u-linkClean" href="mailto:{$contacts.pec}">
        <i class="fa fa-envelope u-textClean"></i>
        {$contacts.pec}
    </a>
{/if}
{if is_set($contacts.web)}
    <a class="u-linkClean" href="{$contacts.web}">
        <i class="fa fa-link u-textClean"></i>
        {def $pnkParts = $contacts.web|explode('//')}{if is_set( $pnkParts[1] )}{$pnkParts[1]}{/if}
    </a>
{/if}