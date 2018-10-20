{set-block scope=root variable=cache_ttl}0{/set-block}
{def $__AREA_RISERVATA = fetch('content','node',hash('node_id', ezini( 'IlPedibus', 'AreaRiservata', 'ilpedibus.ini' )))}

{def $__VOLUNTEERS = fetch(
                        'content',
                        'list',
                        hash(
                            'parent_node_id', ezini( 'IlPedibus', 'Volontari', 'ilpedibus.ini' ),
                            'class_identifier', 'adulto'
                        )
                    )}

{def $__ABSENCES = fetch(
                        'content',
                        'list',
                        hash(
                            'parent_node_id', ezini( 'IlPedibus', 'Assenze', 'ilpedibus.ini' ),
                            'class_identifier', 'assenza_volontario'
                        )
                    )}

<div class="container-fluid main_cage row_main_content margin-both reserved_area">

	{if and(
				is_set($view_parameters.ok)|not(),
				is_set($view_parameters.error)|not()
			)
	}
        <div class="row">
            <div class="col-xs-12">
                <p class="white-space">Inserisci la sostituzione di un volontario</p>
            </div>
        </div>
        <form action="/ilpedibus_ra/substitution" method="post">
            <div class="row">
                <div class="col-xs-12">
                    <h3>Assenza (richiesto)</h3>
                    <p class="small">Seleziona l'assenza da sostituire</p>
                    <select name="substitution_absence">
                    {foreach $__ABSENCES as $__ABSENCE}
                        {* PATCH: il fetch delle assenze anche se filtrato per 'assenza_volontario' prende
                        tutti i suoi figli *}
                        {if $__ABSENCE.class_identifier|eq('assenza_volontario')}
                            {def $__VOLONTARIO = fetch('content','node',hash('node_id', $__ABSENCE.data_map.volontario.content.relation_list[0].node_id))}
                            {def $__DATA = $__ABSENCE.data_map.data.data_int|datetime('custom', '%d/%m/%Y')}
                            {def $__LINEA = fetch('content','node',hash('node_id', $__ABSENCE.data_map.linea.content.relation_list[0].node_id))}
{*                            <option value="{$__ABSENCE.contentobject_id}">{$__ABSENCE.name|wash()}</option>*}
                            <option value="{$__ABSENCE.contentobject_id}">
                                {$__VOLONTARIO.name|wash()}&nbsp;-&nbsp;{$__DATA}&nbsp;-&nbsp;{$__LINEA.name|wash()}
{*                                {$__ABSENCE.data_map.volontario.content.relation_list|attribute(show)}*}
{*                            {$__ABSENCE.name|wash()}*}
                            </option>
                        {/if}
                    {/foreach}
                    </select>
                </div>
            </div>
            <hr>
            <div class="row">
                <div class="col-xs-12">
                    <h3>Volontario (richiesto)</h3>
                    <p class="small">Seleziona il volontario che sopperisce all'assenza</p>
                    <select name="substitution_volunteer">
                    {foreach $__VOLUNTEERS as $__VOLUNTEER}
                        <option value="{$__VOLUNTEER.contentobject_id}">{$__VOLUNTEER.name|wash()}</option>
                    {/foreach}
                    </select>
                </div>
            </div>
            <hr>
            <div class="row">
                <div class="col-xs-12">
                    <button type="submit" class="btn action">Salva</button>
                </div>
                <div class="col-xs-12">
                    <a href="{$__AREA_RISERVATA.url|ezroot('no')}" class="">Annulla l'inserimento</a>
                </div>
            </div>
            <input type="hidden" name="__URL__" value={$node.url|ezurl()} >
        </form>
	{elseif and(is_set($view_parameters.error),$view_parameters.error|ne(''))}
		<p>
			Si è verificato un errore
		</p>
		{if $view_parameters.error|int()|eq(2)}
			<p>
                Non è possibile creare la sostituzione: contattare l'aministratore per notificare l'accaduto.
			</p>
            <div class="col-xs-12">
                <a href="{$__AREA_RISERVATA.url|ezroot('no')}" class="">Torna all'area riservata</a>
            </div>
		{elseif $view_parameters.error|int()|eq(1)}
			<p>
                Non è possibile creare la sostituzione senza valori.
			</p>
            <div class="col-xs-12">
                <a href="{$__AREA_RISERVATA.url|ezroot('no')}" class="">Torna all'area riservata</a>
            </div>
		{/if}
	{elseif is_set($view_parameters.ok)}
		<p>
			Sostituzione creata con successo!
		</p>
		<br/>
        <div class="col-xs-12">
            <a href="{$__AREA_RISERVATA.url|ezroot('no')}" class="">Torna all'area riservata</a>
        </div>
	{/if}
</div>